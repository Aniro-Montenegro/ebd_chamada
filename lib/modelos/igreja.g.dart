// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'igreja.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IgrejaAdapter extends TypeAdapter<Igreja> {
  @override
  final int typeId = 1;

  @override
  Igreja read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Igreja()..nomeIgreja = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Igreja obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.nomeIgreja);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IgrejaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
