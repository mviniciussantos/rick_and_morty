import 'package:hive_ce/hive.dart';
import 'package:rick_and_morty/data/models/local/episode_local.dart';
import 'package:rick_and_morty/domain/models/episode.dart';

abstract class EpisodeLocalDataSource {
  Future<void> saveEpisodes(List<Episode> episodes);
  Future<List<Episode>> getEpisodes();
  Future<void> clear();
}

class EpisodeLocalDataSourceImpl implements EpisodeLocalDataSource {
  static const _boxName = 'episodes';

  Future<Box<EpisodeLocal>> get _box async =>
      await Hive.openBox<EpisodeLocal>(_boxName);

  @override
  Future<void> saveEpisodes(List<Episode> episodes) async {
    final box = await _box;
    final entries = {for (final e in episodes) e.id: _toLocal(e)};
    await box.putAll(entries);
  }

  @override
  Future<List<Episode>> getEpisodes() async {
    final box = await _box;
    return box.values.map(_toDomain).toList();
  }

  @override
  Future<void> clear() async {
    final box = await _box;
    await box.clear();
  }

  // --- Mappers ---

  EpisodeLocal _toLocal(Episode e) {
    return EpisodeLocal()
      ..id = e.id
      ..name = e.name
      ..airDate = e.airDate
      ..episode = e.episode
      ..url = e.url
      ..characters = e.characters
      ..created = e.created;
  }

  Episode _toDomain(EpisodeLocal e) {
    return Episode(
      id: e.id,
      name: e.name,
      airDate: e.airDate,
      episode: e.episode,
      url: e.url,
      created: e.created,
      characters: e.characters,
    );
  }
}
