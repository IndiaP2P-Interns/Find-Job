// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EducationModelAdapter extends TypeAdapter<EducationModel> {
  @override
  final int typeId = 1;

  @override
  EducationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EducationModel(
      id: fields[0] as String,
      institution: fields[1] as String,
      degree: fields[2] as String,
      fieldOfStudy: fields[3] as String,
      startDate: fields[4] as DateTime,
      endDate: fields[5] as DateTime?,
      bio: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EducationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.institution)
      ..writeByte(2)
      ..write(obj.degree)
      ..writeByte(3)
      ..write(obj.fieldOfStudy)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(6)
      ..write(obj.bio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
