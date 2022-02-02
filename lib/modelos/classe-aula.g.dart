// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classe-aula.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClasseAulaAdapter extends TypeAdapter<ClasseAula> {
  @override
  final int typeId = 3;

  @override
  ClasseAula read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClasseAula()
      ..data = fields[0] as DateTime
      ..total = fields[1] as int
      ..oferta = fields[2] as double
      ..id_classe = fields[3] as int;
  }

  @override
  void write(BinaryWriter writer, ClasseAula obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.total)
      ..writeByte(2)
      ..write(obj.oferta)
      ..writeByte(3)
      ..write(obj.id_classe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClasseAulaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
