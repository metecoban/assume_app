// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MissionRequestAdapter extends TypeAdapter<MissionRequest> {
  @override
  final int typeId = 0;

  @override
  MissionRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MissionRequest(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String,
      category: (fields[3] as List).cast<dynamic>(),
      date: fields[4] as DateTime,
      createdAt: fields[5] as DateTime?,
      updatedAt: fields[7] as DateTime?,
      finishedAt: fields[8] as DateTime?,
      startedAt: fields[6] as DateTime?,
      archivedAt: fields[9] as DateTime?,
      importance: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MissionRequest obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.startedAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.finishedAt)
      ..writeByte(9)
      ..write(obj.archivedAt)
      ..writeByte(10)
      ..write(obj.importance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissionRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
