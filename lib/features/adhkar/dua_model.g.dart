// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dua_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DuaModelAdapter extends TypeAdapter<DuaModel> {
  @override
  final int typeId = 0;

  @override
  DuaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DuaModel(
      title: fields[0] as String,
      content: fields[1] as String,
      source: fields[2] as String,
      isDefault: fields[3] as bool,
      isAzkar: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DuaModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.source)
      ..writeByte(3)
      ..write(obj.isDefault)
      ..writeByte(4)
      ..write(obj.isAzkar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DuaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
