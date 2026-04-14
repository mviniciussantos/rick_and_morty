import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/paginated_response.dart';
import 'package:rick_and_morty/core/result.dart';
import 'package:rick_and_morty/domain/models/character.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

class RickAndMortyService {
  final Dio dio;

  final String baseUrl = 'https://rickandmortyapi.com/api';
  final String characterEndpoint = '/character';
  final String episodeEndpoint = '/episode';

  RickAndMortyService(this.dio);

  Future<Result<List<Character>>> getCharactersByUrls({
    required List<String> urls,
  }) async {
    try {
      final ids = urls.map((url) => url.split('/').last).join(',');
      final response = await dio.get('$baseUrl$characterEndpoint/$ids');

      final data = response.data;
      final List<dynamic> results = data is List ? data : [data];

      return Result.ok(
        results
            .map((e) => Character.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<PaginatedResponse<Episode>>> getEpisodes({
    required int page,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl$episodeEndpoint',
        queryParameters: {'page': page},
      );

      final data = response.data as Map<String, dynamic>;
      final info = data['info'] as Map<String, dynamic>;
      final results = (data['results'] as List)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList();

      return Result.ok(
        PaginatedResponse(
          results: results,
          count: info['count'] as int,
          pages: info['pages'] as int,
          hasNext: info['next'] != null,
        ),
      );
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<List<Character>>> getCharactersByIds({
    required List<String> ids,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl$characterEndpoint/${ids.join(',')}',
      );

      final results = (response.data as List)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList();

      return Result.ok(results);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
