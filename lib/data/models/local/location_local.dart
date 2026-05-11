import 'package:hive_ce/hive.dart';

part 'location_local.g.dart';

@HiveType(typeId: 2)
class LocationLocal extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String url;
}
