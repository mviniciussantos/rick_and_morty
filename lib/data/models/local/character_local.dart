import 'package:hive_ce/hive.dart';
import 'package:rick_and_morty/data/models/local/location_local.dart';
import 'package:rick_and_morty/data/models/local/origin_local.dart';

part 'character_local.g.dart';

@HiveType(typeId: 0)
class CharacterLocal extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String status;

  @HiveField(3)
  late String species;

  @HiveField(4)
  late String type;

  @HiveField(5)
  late String gender;

  @HiveField(6)
  late String image;

  @HiveField(7)
  late String url;

  @HiveField(8)
  late String created;

  @HiveField(9)
  late OriginLocal origin;

  @HiveField(10)
  late LocationLocal location;

  @HiveField(11)
  late List<String> episode;
}
