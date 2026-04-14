import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/character.dart';

abstract class CharacterRepository {
  Future<Result<List<Character>>> getCharactersByIds({
    required List<String> ids,
  });
}
