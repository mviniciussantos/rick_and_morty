import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/episode.dart';
import 'package:rick_and_morty/domain/usecases/get_episodies_usecase.dart';

import '../../mocks/generated_mocks.mocks.dart';
import '../../utils/dummy_helper.dart';

void main() {
  final episodeRepository = MockEpisodeRepository();
  final usecase = GetEpisodesUseCaseImpl(episodeRepository);
  final episodeList = <Episode>[
    Episode(
      id: 1,
      name: 'Pilot',
      airDate: 'December 2, 2013',
      episode: 'S01E01',
      characters: [
        'https://rickandmortyapi.com/api/character/1',
        'https://rickandmortyapi.com/api/character/2',
      ],
      url: 'https://rickandmortyapi.com/api/episode/1',
      created: '2017-11-10T12:56:33.798364',
    ),
  ];

  group('GetEpisodesUseCase', () {
    setUp(() => registerDummyValues());

    test('should return a list of episodes', () async {
      when(episodeRepository.getEpisodes(page: anyNamed('page'))).thenAnswer(
        (_) async => Result.ok(
          PaginatedResponse<Episode>(
            results: episodeList,
            count: 1,
            pages: 1,
            hasNext: false,
          ),
        ),
      );

      final result = await usecase.call(page: 1);

      expect(result, isA<Ok<PaginatedResponse<Episode>>>());

      final okResult = result as Ok<PaginatedResponse<Episode>>;
      expect(okResult.value.results.length, 1);
    });

    test('should return an error if the repository returns an error', () async {
      when(
        episodeRepository.getEpisodes(page: anyNamed('page')),
      ).thenAnswer((_) async => Result.error(Exception('error')));

      final result = await usecase.call(page: 1);

      expect(result, isA<Error<PaginatedResponse<Episode>>>());
    });
  });
}
