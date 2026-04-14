import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

abstract class EpisodeRepository {
  Future<Result<PaginatedResponse<Episode>>> getEpisodes({required int page});
}
