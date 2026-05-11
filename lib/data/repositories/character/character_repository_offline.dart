import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/data/datasources/character_local_data_source.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository.dart';
import 'package:rick_and_morty/data/services/api/rick_and_morty_service.dart';
import 'package:rick_and_morty/domain/models/character.dart';

class CharacterRepositoryOffline implements CharacterRepository {
  final RickAndMortyService _service;
  final CharacterLocalDataSource _localDataSource;

  CharacterRepositoryOffline(this._service, this._localDataSource);

  @override
  Future<Result<List<Character>>> getCharactersByIds({
    required List<String> ids,
  }) async {
    // Step 1: read from local cache
    final cached = await _localDataSource.getCharacters();

    // Step 2: always try to fetch fresh data from remote
    final remoteResult = await _service.getCharactersByIds(ids: ids);

    // Step 3: if remote succeeded, update cache and return fresh data
    if (remoteResult is Ok<List<Character>>) {
      await _localDataSource.saveCharacters(remoteResult.value);
      return remoteResult;
    }

    // Step 4: remote failed — return cache if available, otherwise the error
    if (cached.isNotEmpty) {
      return Result.ok(cached);
    }

    return remoteResult;
  }
}
