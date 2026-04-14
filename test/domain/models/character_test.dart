import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/domain/models/location.dart';
import 'package:rick_and_morty/domain/models/origin.dart';

void main() {
  const json = {
    'id': '1',
    'name': 'Rick Sanchez',
    'status': 'Alive',
    'species': 'Human',
    'type': '',
    'gender': 'Male',
    'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    'url': 'https://rickandmortyapi.com/api/character/1',
    'created': '2017-11-04T18:48:46.250Z',
    'origin': {
      'name': 'Earth (C-137)',
      'url': 'https://rickandmortyapi.com/api/location/1',
    },
    'location': {
      'name': 'Citadel of Ricks',
      'url': 'https://rickandmortyapi.com/api/location/3',
    },
    'episode': [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
  };

  group('Character', () {
    test('fromJson maps all fields correctly', () {
      final character = Character.fromJson(json);

      expect(character.id, '1');
      expect(character.name, 'Rick Sanchez');
      expect(character.status, 'Alive');
      expect(character.species, 'Human');
      expect(character.type, '');
      expect(character.gender, 'Male');
      expect(character.image,
          'https://rickandmortyapi.com/api/character/avatar/1.jpeg');
      expect(character.url, 'https://rickandmortyapi.com/api/character/1');
      expect(character.created, '2017-11-04T18:48:46.250Z');
    });

    test('fromJson deserializes nested origin correctly', () {
      final character = Character.fromJson(json);

      expect(character.origin.name, 'Earth (C-137)');
      expect(character.origin.url,
          'https://rickandmortyapi.com/api/location/1');
    });

    test('fromJson deserializes nested location correctly', () {
      final character = Character.fromJson(json);

      expect(character.location.name, 'Citadel of Ricks');
      expect(character.location.url,
          'https://rickandmortyapi.com/api/location/3');
    });

    test('fromJson deserializes episode list correctly', () {
      final character = Character.fromJson(json);

      expect(character.episode, [
        'https://rickandmortyapi.com/api/episode/1',
        'https://rickandmortyapi.com/api/episode/2',
      ]);
    });

    test('toJson maps scalar fields correctly', () {
      final result = Character.fromJson(json).toJson();

      expect(result['id'], '1');
      expect(result['name'], 'Rick Sanchez');
      expect(result['status'], 'Alive');
      expect(result['species'], 'Human');
      expect(result['type'], '');
      expect(result['gender'], 'Male');
      expect(result['image'], 'https://rickandmortyapi.com/api/character/avatar/1.jpeg');
      expect(result['url'], 'https://rickandmortyapi.com/api/character/1');
      expect(result['created'], '2017-11-04T18:48:46.250Z');
    });

    test('toJson includes episode list', () {
      final result = Character.fromJson(json).toJson();

      expect(result['episode'], [
        'https://rickandmortyapi.com/api/episode/1',
        'https://rickandmortyapi.com/api/episode/2',
      ]);
    });

    // Note: toJson() emits nested Origin/Location as objects, not Maps, because
    // @JsonSerializable is missing explicitToJson: true. A full round-trip via
    // fromJson(toJson()) is therefore not possible without that flag.
    test('toJson emits nested origin as Origin instance', () {
      final result = Character.fromJson(json).toJson();

      expect(result['origin'], isA<Origin>());
    });

    test('toJson emits nested location as Location instance', () {
      final result = Character.fromJson(json).toJson();

      expect(result['location'], isA<Location>());
    });
  });
}
