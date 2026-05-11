import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/data/datasources/episode_local_data_source.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository.dart';
import 'package:rick_and_morty/data/services/api/rick_and_morty_service.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

class EpisodeRepositoryOffline implements EpisodeRepository {
  final EpisodeLocalDataSource _localDataSource;
  final RickAndMortyService _service;

  EpisodeRepositoryOffline(this._localDataSource, this._service);

  @override
  Stream<Result<PaginatedResponse<Episode>>> getEpisodes({
    required int page,
  }) async* {
    // Emit cache only on first page — gives instant feedback on app open
    if (page == 1) {
      final cached = await _localDataSource.getEpisodes();
      if (cached.isNotEmpty) {
        yield Result.ok(
          PaginatedResponse(
            results: cached,
            count: cached.length,
            pages: 1,
            hasNext: true,
          ),
        );
      }
    }

    // Always fetch remote
    final remoteResult = await _service.getEpisodes(page: page);

    if (remoteResult is Ok<PaginatedResponse<Episode>>) {
      await _localDataSource.saveEpisodes(remoteResult.value.results);
      yield remoteResult;
      return;
    }

    // Remote failed — only propagate error if no cache was emitted
    if (page != 1) {
      yield remoteResult;
    }
  }
}
