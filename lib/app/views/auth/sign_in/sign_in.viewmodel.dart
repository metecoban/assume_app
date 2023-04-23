import 'dart:io';

import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/auth/sign_in/subview/forgot_password.view.dart';
import 'package:assume/app/views/auth/sign_in/subview/login.view.dart';
import 'package:assume/app/views/auth/sign_in/subview/new_password.view.dart';
import 'package:assume/app/views/auth/sign_in/subview/otp.view.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/extensions/common_extension.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/auth/auth_services.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInViewModel extends BaseViewModel {
  List<Widget> pageOptions = <Widget>[
    const LoginView(),
    const ForgotPasswordView(),
    const OTPView(),
    const NewPasswordView(),
  ];
  PageController pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int get currentPage => _currentPage;

  changePage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  final loginFormKey = GlobalKey<FormState>();
  final newPasswordFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController resetEmailText = TextEditingController();
  TextEditingController otpText = TextEditingController();

  TextEditingController newPasswordText = TextEditingController();
  TextEditingController newPasswordText2 = TextEditingController();

  DateTime? _firstPressedAt, _secondPressedAt;

  bool isObsecure = true;
  bool isObsecureNewPassword = true;
  bool isObsecureNewPassword2 = true;

  void changeIsObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  void changeIsObsecureNewPassword() {
    isObsecureNewPassword = !isObsecureNewPassword;
    notifyListeners();
  }

  void changeIsObsecureNewPassword2() {
    isObsecureNewPassword2 = !isObsecureNewPassword2;
    notifyListeners();
  }

  void sendCode(BuildContext context) async {
    if (forgotPasswordFormKey.currentState!.validate()) {
      changeIsLoading(context);
      _secondPressedAt = DateTime.now();
      if (_firstPressedAt != null &&
          _secondPressedAt != null &&
          _secondPressedAt!.difference(_firstPressedAt!) <=
              const Duration(minutes: 5)) {
        changeIsLoading(context);
        Future.delayed(const Duration(seconds: 0), () {
          super.showSnackBar(context, message: context.l10n.waitSendAgain);
        });
      } else {
        _firstPressedAt = _secondPressedAt;
        await ResetPasswordService.instance
            .sendPasswordResetCode(resetEmailText.text)
            .then((value) {
          if (value.success == false) changeIsLoading(context);
          if (value.success == true) {
            context.read<SignInViewModel>().pageController.animateToPage(2,
                duration: const Duration(milliseconds: 750),
                curve: Curves.easeInOut);
            changeIsLoading(context);
          } else {
            super.showSnackBar(context, message: value.message!);
          }
        });
      }
    }
  }

  void resetPassword(BuildContext context) async {
    if (newPasswordFormKey.currentState!.validate()) {
      changeIsLoading(context);
      await ResetPasswordService.instance
          .resetPassword(
              resetEmailText.text, newPasswordText.text, newPasswordText2.text)
          .then((value) {
        if (value.success == false) changeIsLoading(context);
        if (value.success == true) {
          _currentPage = 0;
          NavigationService.instance
              .navigateToPageClear(path: Routes.signIn.name);
          changeIsLoading(context);
        } else {
          super.showSnackBar(context, message: value.message!);
        }
      });
      newPasswordText.text = '';
      newPasswordText2.text = '';
    }
  }

  void resetPasswordForProfile(BuildContext context) async {
    if (newPasswordFormKey.currentState!.validate()) {
      changeIsLoading(context);
      await ResetPasswordService.instance
          .resetPassword(UserCacheService.instance.getUser().email,
              newPasswordText.text, newPasswordText2.text)
          .then((value) {
        if (value.success == false) changeIsLoading(context);
        if (value.success == true) {
          Navigator.pop(context);
          super.showSnackBar(context,
              message: context.l10n.passwordChangedSuccesfully);
          changeIsLoading(context);
          clear();
        } else {
          super.showSnackBar(context, message: value.message!);
        }
      });
      newPasswordText.text = '';
      newPasswordText2.text = '';
    }
  }

  void otpControl(BuildContext context) async {
    changeIsLoading(context);
    await ResetPasswordService.instance
        .otpControl(resetEmailText.text, otpText.text)
        .then((value) {
      if (value.success == false) {
        changeIsLoading(context);
      }
      if (value.success == true) {
        context.read<SignInViewModel>().pageController.animateToPage(3,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOut);
        changeIsLoading(context);
      } else {
        super.showSnackBar(context, message: value.message!);
      }
    });
    notifyListeners();
  }

  void loginWithAuth(BuildContext context) async {
    changeIsLoading(context);
    await LoginService.instance.googleLogin().then((value) async {
      if (value.success == false) {
        changeIsLoading(context);
      }
      if (value.success == true) {
        await MissionService.instance.updateAllMissions().then((value) {
          changeIsLoading(context);
        });
        navigation();
      } else {
        super.showSnackBar(context, message: value.message!);
      }
    });
  }

  void login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      changeIsLoading(context);
      await LoginService.instance
          .login(emailText.text, passwordText.text)
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

      notifyListeners();
    }
  }

  @override
  void clear() {
    emailText.clear();
    passwordText.clear();
    resetEmailText.clear();
    otpText.clear();

    newPasswordText.clear();
    newPasswordText2.clear();
  }
}

/// TO PERMISSION OPERATION
void navigation() {
  if (Platform.isAndroid) {
    NavigationService.instance.navigateToPageClear(path: Routes.home.name);
  } else if (Platform.isIOS) {
    SystemCacheService.instance.getPermission()
        ? NavigationService.instance.navigateToPageClear(path: Routes.home.name)
        : NavigationService.instance
            .navigateToPageClear(path: Routes.permission.name);
  }
}
