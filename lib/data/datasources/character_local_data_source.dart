import 'package:hive_ce/hive.dart';
import 'package:rick_and_morty/data/models/local/character_local.dart';
import 'package:rick_and_morty/data/models/local/location_local.dart';
import 'package:rick_and_morty/data/models/local/origin_local.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/domain/models/location.dart';
import 'package:rick_and_morty/domain/models/origin.dart';

abstract class CharacterLocalDataSource {
  Future<void> saveCharacters(List<Character> characters);
  Future<List<Character>> getCharacters();
  Future<void> clear();
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  static const _boxName = 'characters';

  Future<Box<CharacterLocal>> get _box async =>
      await Hive.openBox<CharacterLocal>(_boxName);

  @override
  Future<void> saveCharacters(List<Character> characters) async {
    final box = await _box;
    final entries = {
      for (final c in characters) c.id: _toLocal(c),
    };
    await box.putAll(entries);
  }

  @override
  Future<List<Character>> getCharacters() async {
    final box = await _box;
    return box.values.map(_toDomain).toList();
  }

  @override
  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }

  // --- Mappers ---

  CharacterLocal _toLocal(Character c) {
    return CharacterLocal()
      ..id = c.id
      ..name = c.name
      ..status = c.status
      ..species = c.species
      ..type = c.type
      ..gender = c.gender
      ..image = c.image
      ..url = c.url
      ..created = c.created
      ..episode = c.episode
      ..origin = (OriginLocal()
        ..name = c.origin.name
        ..url = c.origin.url)
      ..location = (LocationLocal()
        ..name = c.location.name
        ..url = c.location.url);
  }

  Character _toDomain(CharacterLocal c) {
    return Character(
      id: c.id,
      name: c.name,
      status: c.status,
      species: c.species,
      type: c.type,
      gender: c.gender,
      image: c.image,
      url: c.url,
      created: c.created,
      episode: c.episode,
      origin: Origin(name: c.origin.name, url: c.origin.url),
      location: Location(name: c.location.name, url: c.location.url),
    );
  }
}
