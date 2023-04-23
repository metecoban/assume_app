// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRequestAdapter extends TypeAdapter<UserRequest> {
  @override
  final int typeId = 1;

  @override
  UserRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRequest(
      id: fields[0] as String?,
      name: fields[2] as String?,
      surname: fields[3] as String?,
      email: fields[4] as String?,
      password: fields[1] as String?,
      categories: (fields[6] as List?)?.cast<dynamic>(),
      createdAt: fields[7] as DateTime?,
      otpCode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserRequest obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.surname)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.otpCode)
      ..writeByte(6)
      ..write(obj.categories)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
