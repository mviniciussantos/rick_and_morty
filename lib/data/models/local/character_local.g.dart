// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterLocalAdapter extends TypeAdapter<CharacterLocal> {
  @override
  final typeId = 0;

  @override
  CharacterLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterLocal()
      ..id = (fields[0] as num).toInt()
      ..name = fields[1] as String
      ..status = fields[2] as String
      ..species = fields[3] as String
      ..type = fields[4] as String
      ..gender = fields[5] as String
      ..image = fields[6] as String
      ..url = fields[7] as String
      ..created = fields[8] as String
      ..origin = fields[9] as OriginLocal
      ..location = fields[10] as LocationLocal
      ..episode = (fields[11] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, CharacterLocal obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.created)
      ..writeByte(9)
      ..write(obj.origin)
      ..writeByte(10)
      ..write(obj.location)
      ..writeByte(11)
      ..write(obj.episode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
