import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/app/views/profile/profile.viewmodel.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/model/user/request/user_request.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/auth/register/register_service.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/utils/parser/full_name_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpViewModel extends BaseViewModel {
  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();

  bool isObsecure = true;

  void changeIsObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  Future<void> addUser(BuildContext context) async {
    changeIsLoading(context);
    if (signUpFormKey.currentState!.validate()) {
      List<String>? fullName = fullNameParser(nameText.text);
      UserRequest user = UserRequest(
          name: fullName![0],
          surname: fullName[1],
          email: emailText.text,
          password: passwordText.text,
          createdAt: DateTime.now());

      // IF USER ANONYMOUS USER CONTROL
      UserRequest? userCache = UserCacheService.instance.getUser();
      if (userCache == null) {
        await RegisterService.instance
            .register(user: user, isGoogle: false)
            .then((value) async {
          if (value.success == false) changeIsLoading(context);
          if (value.success == true) {
            await MissionService.instance.updateAllMissions().then((value) {
              changeIsLoading(context);
            });
            clear();
            navigation();
          } else {
            super.showSnackBar(context, message: value.message!);
          }
        });
      } else {
        userCache.name = fullName[0];
        userCache.surname = fullName[1];
        userCache.email = emailText.text;
        userCache.password = passwordText.text;
        await RegisterService.instance
            .registerAnonymousUser(user: userCache)
            .then((value) async {
          if (value.success == false) changeIsLoading(context);
          if (value.success == true) {
            changeIsLoading(context);
            clear();
            context.read<ProfileViewModel>().logOut(context);
            super.showSnackBar(context, message: context.l10n.pleaseSignIn);
          } else {
            super.showSnackBar(context, message: value.message!);
          }
        });
      }
    }
  }

  @override
  void clear() {
    nameText.clear();
    emailText.clear();
    passwordText.clear();
  }
}
