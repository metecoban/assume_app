import 'package:assume/core/model/mission/request/mission_request.dart';
import 'package:hive_flutter/adapters.dart';

part 'ordered_mission.g.dart';

@HiveType(typeId: 2)
class OrderedMission {
  @HiveField(0)
  Map<DateTime, List<MissionRequest>>? missions;

  OrderedMission({this.missions});

  Map<String, dynamic> toJson() => {
        'missions': missions,
      };

  static OrderedMission fromJson(Map<String, dynamic> json) => OrderedMission(
        missions: json['missions'],
      );
}
