import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository.dart';
import 'package:rick_and_morty/data/services/api/rick_and_morty_service.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

class EpisodeRepositoryRemote implements EpisodeRepository {
  final RickAndMortyService _service;

  EpisodeRepositoryRemote(this._service);

  @override
  Future<Result<PaginatedResponse<Episode>>> getEpisodes({required int page}) {
    return _service.getEpisodes(page: page);
  }
}
