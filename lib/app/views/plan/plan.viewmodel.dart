import 'package:assume/core/base/view_model/base_view_model.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/local/hive/mission_cache.dart';
import 'package:assume/core/service/local/hive/system_cache.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:assume/core/service/network/firebase/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanViewModel extends BaseViewModel {
  DateTime _today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 3)
          .toLocal()
          .toUtc();
  DateTime get today => _today;
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _today = selectedDay;
    notifyListeners();
  }

  bool _isClickedImportance = false;
  bool get isClickedImportance => _isClickedImportance;
  void changeImportanceStuation() {
    _isClickedImportance = !_isClickedImportance;
    notifyListeners();
  }

  static String _dropdownValue =
      SystemCacheService.instance.getLanguage() == 0 ? 'Weekly' : 'Haftalık';
  static void updateDropDownValue() {
    _dropdownValue =
        SystemCacheService.instance.getLanguage() == 0 ? 'Weekly' : 'Haftalık';
  }

  String get dropdownValue => _dropdownValue;
  set dropdownValue(String item) {
    _dropdownValue = item;
    changeCalendarFormat((item == 'Weekly' || item == 'Haftalık')
        ? CalendarFormat.week
        : CalendarFormat.month);
    notifyListeners();
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  get calendarFormat => _calendarFormat;
  void changeCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  Map<String, bool> _planCategory = {};
  Map<String, bool> get planCategory => _planCategory;
  set planCategory(Map<String, bool> value) {
    _planCategory = value;
    notifyListeners();
  }

  getPlanCategories() {
    final categories = UserCacheService.instance.getCategories();
    if (categories != null) {
      if (categories.length != 0) {
        for (var item in categories) {
          if (!planCategory.containsKey(item)) {
            planCategory[item] = false;
          }
        }
      }
    }
  }

  int? _importanceValue;
  int? get importanceValue => _importanceValue;
  changeImportanceValue(int value) {
    if (importanceValue != value) {
      _importanceValue = value;
    } else {
      _importanceValue = null;
      changeImportanceStuation();
    }
    notifyListeners();
  }

  choosePlanCategory(int index) {
    planCategory[planCategory.keys.elementAt(index)] =
        !planCategory[planCategory.keys.elementAt(index)]!;
    notifyListeners();
  }

  bool _isClickedCategoryAdd = false;
  bool get isClickedCategoryAdd => _isClickedCategoryAdd;
  void changeCategoryAddSituation() {
    _isClickedCategoryAdd = !_isClickedCategoryAdd;
    notifyListeners();
  }

  getMissions(MissionStatus status) {
    final clickedCategories = [
      for (var i in planCategory.keys.toList())
        if (planCategory[i] == true) i
    ];

    Map<DateTime, List<MissionRequest>>? response =
        MissionCacheService.instance.getMissions(status)!.missions;
    Map<DateTime, List<MissionRequest>> result = {};
    if (_importanceValue != null) {
      for (var date in response!.keys.toList()) {
        for (var mission in response[date]!) {
          if (mission.importance == _importanceValue) {
            if (result.containsKey(date)) {
              result[date]!.add(mission);
            } else {
              result[date] = [mission];
            }
          }
        }
      }
      response = result;
    }
    result = {};
    if (clickedCategories.isNotEmpty) {
      for (var date in response!.keys.toList()) {
        for (var mission in response[date] ?? []) {
          for (var category in mission.category) {
            if (clickedCategories.contains(category)) {
              if (result.containsKey(date)) {
                result[date]!.add(mission);
              } else {
                result[date] = [mission];
              }
              break;
            }
          }
        }
      }
      return result;
    } else {
      return response;
    }
  }

  deleteMission(BuildContext context, String value) async {
    changeIsLoading(context);
    await MissionService.instance
        .deleteMission(value, MissionStatus.plans)
        .then((value) => changeIsLoading(context));
    notifyListeners();
  }

  MissionRequest? editMissionModel;
  prepareEditMission(MissionRequest mission) {
    editMissionModel = mission;
    titleText.text = mission.title;
    descriptionText.text = mission.description;

    date = mission.date;
    time = mission.date;
    changeImportanceCreateValue(mission.importance);
    for (var i in mission.category) {
      createCategory[i] = true;
    }
    notifyListeners();
  }

  editMission(BuildContext context, MissionStatus status) async {
    checkItems();
    if (createFormKey.currentState!.validate() && checkItems()) {
      changeIsLoading(context);
      final catList = [
        for (var i in createCategory.keys.toList())
          if (createCategory[i] == true) i
      ];

      await MissionService.instance
          .editMission(
              status: status,
              mission: MissionRequest(
                  id: editMissionModel!.id,
                  startedAt: editMissionModel!.startedAt,
                  finishedAt: editMissionModel!.finishedAt,
                  archivedAt: editMissionModel!.archivedAt,
                  createdAt: editMissionModel!.createdAt,
                  title: titleText.text,
                  description: descriptionText.text,
                  category: catList,
                  date: DateTime(
                    date!.year,
                    date!.month,
                    date!.day,
                    time!.hour,
                    time!.minute,
                  ),
                  importance: _importanceCreateValue ?? 0))
          .then((value) => changeIsLoading(context));
    }

    notifyListeners();
  }

  runMission(BuildContext context, String id) async {
    changeIsLoading(context);
    await MissionService.instance
        .runMission(id)
        .then((value) => changeIsLoading(context));

    notifyListeners();
  }

  //CREATE SUBVIEW
  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();
  TextEditingController newCategoryText = TextEditingController();

  GlobalKey<FormState> createFormKey = GlobalKey<FormState>();

  bool _hasDateError = false;
  bool get hasDateError => _hasDateError;
  changeHasDateError(bool value) {
    _hasDateError = value;
    notifyListeners();
  }

  bool _hasTimeError = false;
  bool get hasTimeError => _hasTimeError;
  changeHasTimeError(bool value) {
    _hasTimeError = value;
    notifyListeners();
  }

  bool hasImportanceError = false;
  bool _hasCategoryError = false;
  bool get hasCategoryError => _hasCategoryError;
  changeHasCategoryError(bool value) {
    _hasCategoryError = value;
    notifyListeners();
  }

  checkItems() {
    bool result = true;
    if (date != null) {
      _hasDateError = false;
    } else {
      _hasDateError = true;
      result = false;
    }

    if (time != null) {
      _hasTimeError = false;
    } else {
      _hasTimeError = true;
      result = false;
    }

    if (importanceCreateValue != null) {
      hasImportanceError = false;
    } else {
      hasImportanceError = true;
      result = false;
    }

    final clickedCategories = [
      for (var i in createCategory.keys.toList())
        if (createCategory[i] == true) i
    ];
    if (clickedCategories.isNotEmpty) {
      _hasCategoryError = false;
    } else {
      _hasCategoryError = true;
      result = false;
    }

    return result;
  }

  DateTime? date;
  DateTime? time;

  int? _importanceCreateValue;
  int? get importanceCreateValue => _importanceCreateValue;
  changeImportanceCreateValue(int value) {
    hasImportanceError = false;
    if (importanceCreateValue != value) {
      _importanceCreateValue = value;
    } else {
      _importanceCreateValue = null;
    }
    notifyListeners();
  }

  Map<String, bool> createCategory = {};
  getCreateCategories() {
    final categories = UserCacheService.instance.getCategories();
    if (categories != null) {
      if (categories.length != 0) {
        for (var item in categories) {
          if (!createCategory.containsKey(item)) {
            createCategory[item] = false;
          }
        }
      }
    }
    return createCategory;
  }

  chooseCreateCategory(int index) {
    createCategory[createCategory.keys.elementAt(index)] =
        !createCategory[createCategory.keys.elementAt(index)]!;
    changeHasCategoryError(false);
    notifyListeners();
  }

  String? _editCategoryText;
  String? get editCategoryText => _editCategoryText ?? '';
  set editCategoryText(String? text) => _editCategoryText = text;

  void addCategory() async {
    if (newCategoryText.text.isNotEmpty) {
      createCategory[newCategoryText.text] = false;
      planCategory[newCategoryText.text] = false;
      await UserService.instance.updateCategory(createCategory.keys.toList());
      newCategoryText.clear();
      _editCategoryText = '';
      changeCategoryAddSituation();
    }
  }

  void editCategory(String category) async {
    newCategoryText.text = category;
    _editCategoryText = category;

    await deleteCategory(category);
    changeCategoryAddSituation();
    notifyListeners();
  }

  deleteCategory(String category) async {
    createCategory.remove(category);
    planCategory.remove(category);
    await UserService.instance.updateCategory(createCategory.keys.toList());
    notifyListeners();
  }

  createMission(BuildContext context) async {
    checkItems();
    if (createFormKey.currentState!.validate() && checkItems()) {
      changeIsLoading(context);
      final catList = [
        for (var i in createCategory.keys.toList())
          if (createCategory[i] == true) i
      ];

      await MissionService.instance
          .addMission(
              MissionStatus.plans,
              MissionRequest(
                  title: titleText.text,
                  description: descriptionText.text,
                  category: catList,
                  date: DateTime(
                    date!.year,
                    date!.month,
                    date!.day,
                    time!.hour,
                    time!.minute,
                  ),
                  importance: _importanceCreateValue ?? 0))
          .then((value) => changeIsLoading(context));
    }
    notifyListeners();
    return createFormKey.currentState!.validate() && checkItems();
  }

  //SHOW CASE VIEW
  final GlobalKey oneShowCase = GlobalKey();
  final GlobalKey twoShowCase = GlobalKey();
  final GlobalKey threeShowCase = GlobalKey();

  clearCreatePageValues() {
    titleText.clear();
    descriptionText.clear();
    newCategoryText.clear();
    _importanceCreateValue = null;
    date = null;
    time = null;
    _hasDateError = false;
    _hasTimeError = false;
    hasImportanceError = false;
    _hasCategoryError = false;
    createCategory = {};
  }

  @override
  void clear() {
    clearCreatePageValues();
    _importanceValue = null;
    _isClickedCategoryAdd = false;
    planCategory = {};
  }
}
