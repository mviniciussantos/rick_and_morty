import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/domain/models/location.dart';

void main() {
  const json = {
    'name': 'Citadel of Ricks',
    'url': 'https://rickandmortyapi.com/api/location/3',
  };

  group('Location', () {
    test('fromJson maps all fields correctly', () {
      final location = Location.fromJson(json);

      expect(location.name, 'Citadel of Ricks');
      expect(location.url, 'https://rickandmortyapi.com/api/location/3');
    });

    test('toJson produces the expected map', () {
      final location = Location.fromJson(json);

      expect(location.toJson(), json);
    });

    test('fromJson → toJson round-trip preserves all values', () {
      final location = Location.fromJson(json);
      final restored = Location.fromJson(location.toJson());

      expect(restored.name, location.name);
      expect(restored.url, location.url);
    });
  });
}
