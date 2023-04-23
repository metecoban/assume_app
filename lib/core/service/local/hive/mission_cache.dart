import 'package:assume/core/base/service/base_cache_manager.dart';
import 'package:assume/core/model/mission/ordered_mission/ordered_mission.dart';
import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:assume/core/service/network/firebase/mission/mission_service.dart';
import 'package:hive_flutter/adapters.dart';

class MissionCacheService extends IBaseCacheManager<OrderedMission> {
  static final MissionCacheService _instance = MissionCacheService._init();
  static MissionCacheService get instance => _instance;
  MissionCacheService._init() : super('missions');

  _registerAdapters() {
    Hive.registerAdapter(MissionRequestAdapter());
    Hive.registerAdapter(OrderedMissionAdapter());
  }

  Future<void> openMissionsBox() async {
    _registerAdapters();
    await super.openBox();
  }

  Future<void> saveMissions(
      MissionStatus status, OrderedMission mission) async {
    await super.saveItemWithKey(status.name, mission);
  }

  OrderedMission? getMissions(MissionStatus status) {
    return super.getItem(status.name);
  }

  OrderedMission? updateMissions(MissionStatus status, OrderedMission mission) {
    return super.updateItem(status.name, mission);
  }

  clearMissions() {
    return super.clearBox();
  }
}
