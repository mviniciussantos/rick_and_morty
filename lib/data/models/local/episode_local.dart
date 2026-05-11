import 'package:hive_ce/hive.dart';

part 'episode_local.g.dart';

@HiveType(typeId: 3)
class EpisodeLocal extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String airDate;

  @HiveField(3)
  late String episode;

  @HiveField(4)
  late List<String> characters;

  @HiveField(5)
  late String url;

  @HiveField(6)
  late String created;
}
