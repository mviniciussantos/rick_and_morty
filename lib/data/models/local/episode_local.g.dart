// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpisodeLocalAdapter extends TypeAdapter<EpisodeLocal> {
  @override
  final typeId = 3;

  @override
  EpisodeLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpisodeLocal()
      ..id = (fields[0] as num).toInt()
      ..name = fields[1] as String
      ..airDate = fields[2] as String
      ..episode = fields[3] as String
      ..characters = (fields[4] as List).cast<String>()
      ..url = fields[5] as String
      ..created = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, EpisodeLocal obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.airDate)
      ..writeByte(3)
      ..write(obj.episode)
      ..writeByte(4)
      ..write(obj.characters)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.created);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpisodeLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
