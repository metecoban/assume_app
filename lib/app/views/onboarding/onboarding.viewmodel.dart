import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/app/views/auth/sign_in/sign_in.viewmodel.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/service/network/firebase/auth/login/login_service.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/utils/dynamic_localization/dynamic_localization.dart';
import 'package:assume/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class OnboardingViewModel extends BaseViewModel {
  static L10n _l10n = DynamicLocalization.l10n;
  static void updateL10N() {
    _l10n = DynamicLocalization.l10n;

    pageList = [
      {
        "image": Assets.images.onboarding.plan.path,
        "text": _l10n.planOnboarding,
      },
      {
        "image": Assets.images.onboarding.run.path,
        "text": _l10n.runOnboarding,
      },
      {
        "image": Assets.images.onboarding.done.path,
        "text": _l10n.doneOnboarding,
      },
      {
        "image": Assets.images.onboarding.login.path,
        "text": _l10n.loginOnboarding,
      },
    ];
  }

  static List pageList = [
    {
      "image": Assets.images.onboarding.plan.path,
      "text": _l10n.planOnboarding,
    },
    {
      "image": Assets.images.onboarding.run.path,
      "text": _l10n.runOnboarding,
    },
    {
      "image": Assets.images.onboarding.done.path,
      "text": _l10n.doneOnboarding,
    },
    {
      "image": Assets.images.onboarding.login.path,
      "text": _l10n.loginOnboarding,
    },
  ];

  int _currentPage = 0;
  int get currentPage => _currentPage;

  final PageController _curPage = PageController(initialPage: 0);
  PageController get curPage => _curPage;

  changePage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  loginWithAnon(BuildContext context) async {
    changeIsLoading(context);
    await LoginService.instance.loginAnonymous().then((value) async {
      if (value.success == false) changeIsLoading(context);

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
}
