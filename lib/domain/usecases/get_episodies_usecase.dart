import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/episode.dart';
import 'package:rick_and_morty/data/repositories/episode/episode_repository.dart';

abstract class GetEpisodesUseCase {
  Stream<Result<PaginatedResponse<Episode>>> call({required int page});
}

class GetEpisodesUseCaseImpl implements GetEpisodesUseCase {
  final EpisodeRepository repository;

  GetEpisodesUseCaseImpl(this.repository);

  @override
  Stream<Result<PaginatedResponse<Episode>>> call({required int page}) {
    return repository.getEpisodes(page: page);
  }
}
