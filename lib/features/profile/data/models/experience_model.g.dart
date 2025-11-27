// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceModelAdapter extends TypeAdapter<ExperienceModel> {
  @override
  final int typeId = 2;

  @override
  ExperienceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExperienceModel(
      id: fields[0] as String,
      company: fields[1] as String,
      position: fields[2] as String,
      startDate: fields[3] as DateTime,
      endDate: fields[4] as DateTime?,
      bio: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExperienceModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.company)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.endDate)
      ..writeByte(5)
      ..write(obj.bio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
