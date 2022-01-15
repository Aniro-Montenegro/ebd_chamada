// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aula.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AulaAdapter extends TypeAdapter<Aula> {
  @override
  final int typeId = 0;

  @override
  Aula read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Aula()
      ..data = fields[0] as DateTime
      ..total = fields[1] as int
      ..oferta = fields[2] as double
      ..infomarcaoAula = (fields[3] as List)
          .map((dynamic e) => (e as Map).cast<String, int>())
          .toList();
  }

  @override
  void write(BinaryWriter writer, Aula obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.total)
      ..writeByte(2)
      ..write(obj.oferta)
      ..writeByte(3)
      ..write(obj.infomarcaoAula);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AulaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
