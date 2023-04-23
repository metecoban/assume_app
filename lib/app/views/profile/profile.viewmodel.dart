import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/app/routes/navigation_service.dart';
import 'package:assume/app/routes/routes.dart';
import 'package:assume/app/views/done/done.viewmodel.dart';
import 'package:assume/app/views/home/home.viewmodel.dart';
import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/constants/color_constants.dart';
import 'package:assume/core/model/mission/ordered_mission/ordered_mission.dart';
import 'package:assume/core/service/local/hive/mission_cache.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:assume/core/service/local/notification/notification_service.dart';
import 'package:assume/core/service/network/firebase/auth/auth_services.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/utils/dynamic_localization/dynamic_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends BaseViewModel {
  // APP THEME PART
  bool _switchValue = SystemCacheService.instance.getTheme();
  bool get switchValue => _switchValue;
  changeSwitchValue(bool value) {
    SystemCacheService.instance.saveTheme(value);
    _switchValue = value;
    notifyListeners();
  }

  initThemeStatus() {
    _switchValue = SystemCacheService.instance.getTheme();
    return _switchValue ? ThemeMode.dark : ThemeMode.light;
  }

  // L10N PART
  int _radioValue = SystemCacheService.instance.getLanguage();
  int get radioValue => _radioValue;
  changeRadioValue(int value) {
    _radioValue = value;
    notifyListeners();
  }

  List<String> languages = ['English', 'Turkish'];
  Locale _languageCode = Locale(L10n.supportedLocales[0].languageCode);
  Locale get languageCode => _languageCode;
  set languageCode(Locale value) {
    SystemCacheService.instance.saveLanguage(_radioValue);
    _updateDependentParts();
    _languageCode = value;
    notifyListeners();
  }

  void _updateDependentParts() {
    DynamicLocalization.setL10n();
    DoneViewModel.updateDropDownValue();
    PlanViewModel.updateDropDownValue();
  }

  initLocale() {
    _languageCode = Locale(L10n
        .supportedLocales[SystemCacheService.instance.getLanguage()]
        .languageCode);

    return _languageCode;
  }

  // MAIN COLOR PART
  Color _currentColor = Color(SystemCacheService.instance.getMainColor());
  Color get currentColor => _currentColor;
  changeCurrentColor(Color color) {
    _currentColor = color;
    notifyListeners();
  }

  changeMainColor() {
    ColorConstant.instance.changeMainColor(_currentColor);
    SystemCacheService.instance.saveMainColor(_currentColor.value);
    notifyListeners();
  }

  // STATISTICS PAGE
  DateTime now = DateTime.now();

  arrangeDate({required bool isNextMonth}) async {
    if (isNextMonth) {
      if (now.month == DateTime.now().month &&
          now.year == DateTime.now().year) {
        return;
      }
      now = DateTime(now.year, now.month + 1, 1);
    } else {
      now = DateTime(now.year, now.month - 1, 1);
    }
    notifyListeners();
  }

  setState() {
    notifyListeners();
  }

  getStatisticalData() {
    var doneMissions =
        MissionCacheService.instance.getMissions(MissionStatus.dones);

    var days = DateTime(now.year, now.month + 1, 0).day;
    List<int> result = List<int>.filled(days, 0);

    for (var item in doneMissions!.missions!.keys.toList()) {
      if (item.month == now.month) {
        result[item.day - 1] = doneMissions.missions![item]!.length;
      }
    }
    return result.toList();
  }

  getCategoricalData() {
    var doneMissions =
        MissionCacheService.instance.getMissions(MissionStatus.dones);
    Map<String, double> catValues = {};

    for (var item in doneMissions!.missions!.keys.toList()) {
      if (item.month == now.month) {
        for (var mission in doneMissions.missions![item]!) {
          for (var cat in mission.category) {
            if (catValues[cat!] == null) {
              catValues[cat] = 1;
            } else {
              catValues[cat] = catValues[cat]! + 1;
            }
          }
        }
      }
    }
    return catValues;
  }

  getImportanceData() {
    var doneMissions =
        MissionCacheService.instance.getMissions(MissionStatus.dones);
    Map<String, double> catValues = {};

    for (var item in doneMissions!.missions!.keys.toList()) {
      if (item.month == now.month) {
        for (var mission in doneMissions.missions![item]!) {
          if (catValues[mission.importance.toString()] == null) {
            catValues[mission.importance.toString()] = 1;
          } else {
            catValues[mission.importance.toString()] =
                catValues[mission.importance.toString()]! + 1;
          }
        }
      }
    }
    return catValues;
  }

  getTimeCatData() {
    var doneMissions =
        MissionCacheService.instance.getMissions(MissionStatus.dones);
    Map<String, int>? values = {};

    for (var item in doneMissions!.missions!.keys.toList()) {
      if (item.month == now.month) {
        for (var mission in doneMissions.missions![item]!) {
          for (var cat in mission.category) {
            if (values.containsKey(cat)) {
              values[cat] = values[cat]! +
                  mission.finishedAt!.difference(mission.startedAt!).inHours;
            } else {
              values[cat] =
                  mission.finishedAt!.difference(mission.startedAt!).inHours;
            }
          }
        }
      }
    }

    return values;
  }

  // ARCHIVE PAGE
  getArchives() {
    var missions = MissionCacheService.instance
        .getMissions(MissionStatus.archives)!
        .missions;

    var archives = [];
    for (var item in missions!.keys.toList()) {
      for (var mission in missions[item]!) {
        archives.add(mission);
      }
    }
    archives.sort(
      (a, b) {
        return b.archivedAt!.compareTo(a.archivedAt!);
      },
    );
    return archives;
  }

  archiveToDoneMissions(String id) async {
    await MissionService.instance.archiveToDoneMission(id);
    notifyListeners();
  }

  // LOG OUT
  logOut(BuildContext context) async {
    NotificationService().cancelAllNotifications();
    LoginService.instance.logOut();
    await LoginService.instance.googleLogout().then((value) {
      NavigationService.instance
          .navigateToPageClear(path: Routes.onboarding.name);
      context.read<HomeViewModel>().clear();
    });
  }

  // BADGE PART
  int badgeCount = 0;
  controlToBadge() {
    badgeCount = 0;
    OrderedMission? finishedMissions =
        MissionCacheService.instance.getMissions(MissionStatus.dones);

    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (finishedMissions!.missions != null) {
      var dates = finishedMissions.missions!.keys.toList();
      dates.sort();
      if (dates.isNotEmpty) {
        var lastDate = dates.last;
        if ((lastDate.year == yesterday.year &&
                lastDate.month == yesterday.month &&
                lastDate.day == yesterday.day) ||
            (lastDate.year == now.year &&
                lastDate.month == now.month &&
                lastDate.day == now.day)) {
          for (int i = dates.length - 1; i > 0; i--) {
            if ((dates[i].difference(dates[i - 1]).inDays == 1)) {
              badgeCount++;
            } else {
              break;
            }
          }
        }
      } else {
        badgeCount = 0;
      }
    }
  }
}
