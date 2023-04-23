import 'package:assume/app/views/plan/plan.viewmodel.dart';
import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DoneViewModel extends BaseViewModel {
  DateTime _today = DateTime.now();
  DateTime get today => _today;
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _today = selectedDay;
    notifyListeners();
  }

  static String _dropdownValue =
      SystemCacheService.instance.getLanguage() == 0 ? 'Monthly' : 'Aylık';
  static void updateDropDownValue() {
    _dropdownValue =
        SystemCacheService.instance.getLanguage() == 0 ? 'Monthly' : 'Aylık';
  }

  String get dropdownValue => _dropdownValue;
  set dropdownValue(String item) {
    _dropdownValue = item;
    changeCalendarFormat((item == 'Monthly' || item == 'Aylık')
        ? CalendarFormat.month
        : CalendarFormat.week);
    notifyListeners();
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  get calendarFormat => _calendarFormat;
  void changeCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  Map<DateTime, List<MissionRequest>> _missionList = {};
  // ignore: unnecessary_getters_setters
  Map<DateTime, List<MissionRequest>> get missionList => _missionList;
  set missionList(Map<DateTime, List<MissionRequest>> missionList) {
    _missionList = missionList;
  }

  getMissions(BuildContext context) {
    return Provider.of<PlanViewModel>(context, listen: true)
        .getMissions(MissionStatus.dones);
  }

  archiveMissions(BuildContext context, String id) async {
    changeIsLoading(context);
    await MissionService.instance
        .archiveMission(id)
        .then((value) => changeIsLoading(context));
    notifyListeners();
  }

  deleteMissions(BuildContext context, String id) async {
    changeIsLoading(context);
    await MissionService.instance
        .deleteMission(id, MissionStatus.dones)
        .then((value) => changeIsLoading(context));
    notifyListeners();
  }
}
