import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/domain/models/location.dart';
import 'package:rick_and_morty/domain/models/origin.dart';
import 'package:rick_and_morty/domain/usecases/get_characters_usecase.dart';

import '../../mocks/generated_mocks.mocks.dart';
import '../../utils/dummy_helper.dart';

void main() {
  final characterRepository = MockCharacterRepository();
  final usecase = GetCharactersUseCaseImpl(characterRepository);
  final characterList = <Character>[
    Character(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      gender: 'Male',
      origin: Origin(name: 'Earth', url: 'url'),
      location: Location(name: 'Earth', url: 'url'),
      image: 'image',
      episode: ["https://rickandmortyapi.com/api/episode/1"],
      url: 'url',
      created: 'created',
      type: '',
    ),
  ];

  group('GetCharactersUseCase', () {
    setUp(() => registerDummyValues());

    test('should return a list of characters', () async {
      when(
        characterRepository.getCharactersByIds(ids: ['1']),
      ).thenAnswer((_) async => Result.ok(characterList));

      final result = await usecase.call(ids: ['1']);

      expect(result, isA<Ok<List<Character>>>());

      final okResult = result as Ok<List<Character>>;
      expect(okResult.value.length, 1);
    });

    test('should return an error if the repository returns an error', () async {
      when(
        characterRepository.getCharactersByIds(ids: ['1']),
      ).thenAnswer((_) async => Result.error(Exception('error')));

      final result = await usecase.call(ids: ['1']);

      expect(result, isA<Error<List<Character>>>());
    });
  });
}
