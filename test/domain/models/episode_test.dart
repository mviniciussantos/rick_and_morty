import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

void main() {
  const json = {
    'id': 1,
    'name': 'Pilot',
    'air_date': 'December 2, 2013',
    'episode': 'S01E01',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/1',
    'created': '2017-11-10T12:56:33.798Z',
  };

  group('Episode', () {
    test('fromJson maps all fields correctly', () {
      final episode = Episode.fromJson(json);

      expect(episode.id, 1);
      expect(episode.name, 'Pilot');
      expect(episode.airDate, 'December 2, 2013');
      expect(episode.episode, 'S01E01');
      expect(episode.characters, [
        'https://rickandmortyapi.com/api/character/1',
        'https://rickandmortyapi.com/api/character/2',
      ]);
      expect(episode.url, 'https://rickandmortyapi.com/api/episode/1');
      expect(episode.created, '2017-11-10T12:56:33.798Z');
    });

    test('toJson produces the expected map', () {
      final episode = Episode.fromJson(json);

      expect(episode.toJson(), json);
    });

    test('fromJson → toJson round-trip preserves all values', () {
      final episode = Episode.fromJson(json);
      final restored = Episode.fromJson(episode.toJson());

      expect(restored.id, episode.id);
      expect(restored.name, episode.name);
      expect(restored.airDate, episode.airDate);
      expect(restored.episode, episode.episode);
      expect(restored.characters, episode.characters);
      expect(restored.url, episode.url);
      expect(restored.created, episode.created);
    });
  });
}
