// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordered_mission.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderedMissionAdapter extends TypeAdapter<OrderedMission> {
  @override
  final int typeId = 2;

  @override
  OrderedMission read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderedMission(
      missions: (fields[0] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as DateTime, (v as List).cast<MissionRequest>())),
    );
  }

  @override
  void write(BinaryWriter writer, OrderedMission obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.missions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderedMissionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
