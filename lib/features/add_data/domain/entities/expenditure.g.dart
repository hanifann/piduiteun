// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenditure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenditureAdapter extends TypeAdapter<Expenditure> {
  @override
  final int typeId = 0;

  @override
  Expenditure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expenditure(
      expenditure: fields[0] as int,
      dateTime: fields[1] as DateTime,
      information: fields[2] as String,
      time: fields[3] as String,
      tag: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expenditure obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.expenditure)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.information)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenditureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
