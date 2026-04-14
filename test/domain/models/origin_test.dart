import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/models/origin.dart';

void main() {
  const json = {
    'name': 'Earth (C-137)',
    'url': 'https://rickandmortyapi.com/api/location/1',
  };

  group('Origin', () {
    test('fromJson maps all fields correctly', () {
      final origin = Origin.fromJson(json);

      expect(origin.name, 'Earth (C-137)');
      expect(origin.url, 'https://rickandmortyapi.com/api/location/1');
    });

    test('toJson produces the expected map', () {
      final origin = Origin.fromJson(json);

      expect(origin.toJson(), json);
    });

    test('fromJson → toJson round-trip preserves all values', () {
      final origin = Origin.fromJson(json);
      final restored = Origin.fromJson(origin.toJson());

      expect(restored.name, origin.name);
      expect(restored.url, origin.url);
    });
  });
}
