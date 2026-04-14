// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
  id: json['id'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
  species: json['species'] as String,
  type: json['type'] as String,
  gender: json['gender'] as String,
  image: json['image'] as String,
  url: json['url'] as String,
  created: json['created'] as String,
  origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
  episode: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
  'species': instance.species,
  'type': instance.type,
  'gender': instance.gender,
  'image': instance.image,
  'url': instance.url,
  'created': instance.created,
  'origin': instance.origin,
  'location': instance.location,
  'episode': instance.episode,
};
