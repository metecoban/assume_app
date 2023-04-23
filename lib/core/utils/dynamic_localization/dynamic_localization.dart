
import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/app/views/onboarding/onboarding.viewmodel.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:assume/core/service/network/firebase/auth/auth_services.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/utils/validator/form_validator.dart';
import 'package:flutter/material.dart';

/// The class solves the dynamic localization without context addiction
class DynamicLocalization {
  static final DynamicLocalization _instance = DynamicLocalization._init();
  static DynamicLocalization get instance => _instance;
  DynamicLocalization._init();

  static L10n l10n = lookupL10n(
      Locale(SystemCacheService.instance.getLanguage() == 0 ? 'en' : 'tr'));

  static void setL10n() {
    l10n = lookupL10n(
        Locale(SystemCacheService.instance.getLanguage() == 0 ? 'en' : 'tr'));
    _updateDependentClasses();
  }

  static void _updateDependentClasses() {
    FormValidator.updateL10N();
    LoginService.updateL10N();
    ResetPasswordService.updateL10N();
    ResetPasswordService.updateL10N();
    MissionService.updateL10N();
    OnboardingViewModel.updateL10N();
  }
}
