import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository.dart';
import 'package:rick_and_morty/data/services/api/rick_and_morty_service.dart';
import 'package:rick_and_morty/domain/models/character.dart';

class CharacterRepositoryRemote implements CharacterRepository {
  final RickAndMortyService _service;

  CharacterRepositoryRemote(this._service);

  @override
  Future<Result<List<Character>>> getCharactersByIds({
    required List<String> ids,
  }) {
    return _service.getCharactersByIds(ids: ids);
  }
}
