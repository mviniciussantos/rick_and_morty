import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/data/repositories/character/character_repository.dart';
import 'package:rick_and_morty/domain/models/character.dart';

abstract class GetCharactersUseCase {
  Future<Result<List<Character>>> call({required List<String> ids});
}

class GetCharactersUseCaseImpl implements GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCaseImpl(this.repository);
  @override
  Future<Result<List<Character>>> call({required List<String> ids}) {
    return repository.getCharactersByIds(ids: ids);
  }
}
