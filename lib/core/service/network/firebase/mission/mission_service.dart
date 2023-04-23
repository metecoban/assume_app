import 'package:assume/app/l10n/app_l10n.dart';
import 'package:assume/core/base/service/base_firestore.dart';
import 'package:assume/core/model/mission/ordered_mission/ordered_mission.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/model/mission/response/mission_response.dart';
import 'package:assume/core/model/result/result_response.dart';
import 'package:assume/core/service/local/hive/mission_cache.dart';
import 'package:assume/core/service/local/hive/user_cache.dart';
import 'package:assume/core/service/local/notification/notification_service.dart';
import 'package:assume/core/utils/dynamic_localization/dynamic_localization.dart';

class MissionService extends IBaseFirestore {
  static final MissionService _instance = MissionService._init();
  static MissionService get instance => _instance;
  MissionService._init() : super(path: 'users');

  static L10n _l10n = DynamicLocalization.l10n;
  static void updateL10N() {
    _l10n = DynamicLocalization.l10n;
  }

  Future<void> addMission(MissionStatus status, MissionRequest mission) async {
    String uuid = UserCacheService.instance.getUserID();
    await super.addSubdata(uuid, status.name, mission.toJson(), null);
    if (status == MissionStatus.plans && mission.date.isAfter(DateTime.now())) {
      _scheduleNotification(
          mission.date.millisecond, mission.title, mission.date);
    }
    await updateSelectedMissions([MissionStatus.plans]);
  }

  void _scheduleNotification(int id, String title, DateTime startTime) {
    if (startTime.isAfter(DateTime.now())) {
      NotificationService().scheduleNotification(
        id: id,
        title: _l10n.assumeMissionTime,
        body: '${_l10n.missionTitle} $title',
        scheduledNotificationDateTime: startTime,
      );
    }
  }

  Future _cancelNotification(String id) async {
    String uuid = UserCacheService.instance.getUserID();
    var response =
        await super.fetchOneSubdata(uuid, MissionStatus.plans.name, id);

    var model = MissionRequest.fromJson(response.data()!);
    NotificationService().cancelNotification(model.date.millisecond);
  }

  Future<MissionResponse> fetchMissionsOrderly(MissionStatus status) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      var response = [];
      var den = await super.fetchSubdata(uuid, status.name);
      for (var value in den.docs) {
        if (value.data()['title'] != null) {
          response.add(MissionRequest.fromJson(value.data()));
        }
      }

      Map<DateTime, List<MissionRequest>> missionResponseAsDate = {};
      for (MissionRequest i in response) {
        var date = i.date;
        var cleanDate = DateTime.utc(date.year, date.month, date.day);
        if (missionResponseAsDate.containsKey(cleanDate)) {
          missionResponseAsDate[cleanDate]!.add(i);
        } else {
          missionResponseAsDate[cleanDate] = [i];
        }
      }

      await MissionCacheService.instance.saveMissions(
          status, OrderedMission(missions: missionResponseAsDate));

      return MissionResponse(
          success: true,
          data: missionResponseAsDate,
          message: _l10n.successfully);
    } catch (e) {
      return MissionResponse(
          success: false, data: null, message: _l10n.missionNotFound);
    }
  }

  Future<MissionResponse> editMission(
      {required MissionRequest mission, required MissionStatus status}) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      mission.updatedAt = DateTime.now();
      await super.addSubdata(uuid, status.name, mission.toJson(), mission.id);
      if (status == MissionStatus.plans) {
        await _cancelNotification(mission.id!);
        _scheduleNotification(
            mission.date.millisecond, mission.title, mission.date);
      }
      await updateSelectedMissions([status]);
      return MissionResponse(success: true, message: _l10n.successfully);
    } catch (e) {
      return MissionResponse(success: false, message: e.toString());
    }
  }

  Future<ResultResponse> deleteMission(String id, MissionStatus status) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      if (status == MissionStatus.plans) {
        await _cancelNotification(id);
      }
      await super.deleteSubdata(uuid, status.name, id);
      await updateSelectedMissions([status]);

      return ResultResponse(success: true, message: _l10n.successfully);
    } catch (e) {
      return ResultResponse(success: false, message: e.toString());
    }
  }

  Future<ResultResponse> runMission(String id) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      var response =
          await super.fetchOneSubdata(uuid, MissionStatus.plans.name, id);
      await _cancelNotification(id);
      await super.deleteSubdata(uuid, MissionStatus.plans.name, id);
      var model = MissionRequest.fromJson(response.data()!);
      model.startedAt = DateTime.now();
      await addMission(MissionStatus.runs, model);
      await updateSelectedMissions([MissionStatus.plans, MissionStatus.runs]);
      return ResultResponse(success: true, message: _l10n.successfully);
    } catch (e) {
      return ResultResponse(success: false, message: e.toString());
    }
  }

  Future<ResultResponse> doneMission(String id) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      var response =
          await super.fetchOneSubdata(uuid, MissionStatus.runs.name, id);

      await super.deleteSubdata(uuid, MissionStatus.runs.name, id);

      var model = MissionRequest.fromJson(response.data()!);
      model.finishedAt ??= DateTime.now();

      await addMission(MissionStatus.dones, model);
      await updateSelectedMissions([MissionStatus.runs, MissionStatus.dones]);
      return ResultResponse(success: true, message: _l10n.successfully);
    } catch (e) {
      return ResultResponse(success: false, message: e.toString());
    }
  }

  Future<ResultResponse> archiveMission(String id) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      var response =
          await super.fetchOneSubdata(uuid, MissionStatus.dones.name, id);

      await super.deleteSubdata(uuid, MissionStatus.dones.name, id);

      var model = MissionRequest.fromJson(response.data()!);
      model.archivedAt = DateTime.now();

      await addMission(MissionStatus.archives, model);
      await updateSelectedMissions(
          [MissionStatus.dones, MissionStatus.archives]);
      return ResultResponse(success: true, message: _l10n.successfully);
    } catch (e) {
      return ResultResponse(success: false, message: e.toString());
    }
  }

  Future<ResultResponse> archiveToDoneMission(String id) async {
    try {
      String uuid = UserCacheService.instance.getUserID();
      var response =
          await super.fetchOneSubdata(uuid, MissionStatus.archives.name, id);

      await super.deleteSubdata(uuid, MissionStatus.archives.name, id);

      var model = MissionRequest.fromJson(response.data()!);
      model.archivedAt = null;

      await addMission(MissionStatus.dones, model);
      await updateSelectedMissions(
          [MissionStatus.dones, MissionStatus.archives]);
      return ResultResponse(success: true, message: _l10n.successfully);
    } catch (e) {
      return ResultResponse(success: false, message: e.toString());
    }
  }

  /// MISSION DATA IS MOVED FROM USER ANONIM ACCOUNT TO REGISTERED ACCOUNT
  Future carryMissionsToAnotherAccount(
      {required String oldID, required String newID}) async {
    for (var status in MissionStatus.values) {
      final mission = await super.fetchSubdata(oldID, status.name);

      for (var value in mission.docs) {
        var data = value.data();
        if (data['title'] != null) {
          final doc = collection.doc(newID).collection(status.name).doc();

          data['id'] = doc.id;
          doc.set(data);
        }
      }
    }
  }

  stopMission(MissionRequest mission) async {
    mission.finishedAt = DateTime.now();
    await editMission(mission: mission, status: MissionStatus.runs);
  }

  reRunMission(MissionRequest mission) async {
    mission.startedAt =
        mission.startedAt!.add(DateTime.now().difference(mission.finishedAt!));
    mission.finishedAt = null;

    await editMission(mission: mission, status: MissionStatus.runs);
  }

  updateAllMissions() async {
    String uuid = UserCacheService.instance.getUserID();
    if (uuid == '') return;
    for (var i in MissionStatus.values) {
      await fetchMissionsOrderly(i);
    }
  }

  updateSelectedMissions(List<MissionStatus> missionlist) async {
    String uuid = UserCacheService.instance.getUserID();
    if (uuid == '') return;
    for (var i in missionlist) {
      await fetchMissionsOrderly(i);
    }
  }
}

enum MissionStatus { plans, runs, dones, archives }
