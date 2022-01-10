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
      ..adultosHomens = fields[1] as int
      ..adultosMulheres = fields[2] as int
      ..jovens = fields[3] as int
      ..adolescentes = fields[4] as int
      ..criancas = fields[5] as int
      ..total = fields[6] as int
      ..oferta = fields[7] as double
      ..visitantes = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, Aula obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.adultosHomens)
      ..writeByte(2)
      ..write(obj.adultosMulheres)
      ..writeByte(3)
      ..write(obj.jovens)
      ..writeByte(4)
      ..write(obj.adolescentes)
      ..writeByte(5)
      ..write(obj.criancas)
      ..writeByte(6)
      ..write(obj.total)
      ..writeByte(7)
      ..write(obj.oferta)
      ..writeByte(8)
      ..write(obj.visitantes);
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
