import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/core/utils/dynamic_localization/dynamic_localization.dart';
import 'package:assume/core/utils/parser/full_name_parser.dart';

class FormValidator {
  static L10n _l10n = DynamicLocalization.l10n;
  static void updateL10N() {
    _l10n = DynamicLocalization.l10n;
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return _l10n.emailEmptyVal;
    }
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return _l10n.emailVal;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return _l10n.passwordEmptyVal;
    }
    if (value.length < 8) {
      return _l10n.passwordRuleVal;
    }
    final RegExp passwordRegex = RegExp(
        r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+\-=[\]{};':'\\|,.<>/?]).{8,}$");

    if (!passwordRegex.hasMatch(value)) {
      return _l10n.passwordVal;
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value!.isEmpty) {
      return _l10n.nameEmptyVal;
    }
    List<String>? fullName = fullNameParser(value);

    if (fullName == null) {
      return _l10n.nameRuleVal;
    }

    return null;
  }

  static String? defaultValidator(String value,
      {required String message, int minLength = 3, int maxLength = 15}) {
    if (value.isEmpty) {
      return '$message ${_l10n.defaultEmptyVal}';
    } else if (value.length < minLength) {
      return '$message ${_l10n.defaultEmptyValFront} $minLength ${_l10n.defaultEmptyValEnd}';
    } else if (value.length > maxLength) {
      return '$message ${_l10n.defaultEmptyValFront2} $maxLength ${_l10n.defaultEmptyValEnd}';
    }
    return null;
  }
}
