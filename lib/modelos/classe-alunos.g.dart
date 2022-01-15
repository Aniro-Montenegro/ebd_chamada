// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classe-alunos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClasseAlunosAdapter extends TypeAdapter<ClasseAlunos> {
  @override
  final int typeId = 2;

  @override
  ClasseAlunos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClasseAlunos()
      ..id_classe = fields[0] as int
      ..nome_classe = fields[1] as String
      ..quantidade_alunos = fields[2] as int;
  }

  @override
  void write(BinaryWriter writer, ClasseAlunos obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id_classe)
      ..writeByte(1)
      ..write(obj.nome_classe)
      ..writeByte(2)
      ..write(obj.quantidade_alunos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClasseAlunosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
