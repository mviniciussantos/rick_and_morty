import 'package:mockito/mockito.dart';
import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

void registerDummyValues() {
  provideDummy<Result<List<Character>>>(Result.error(Exception('dummy')));
  provideDummy<Result<PaginatedResponse<Episode>>>(
    Result.error(Exception('dummy')),
  );
}
