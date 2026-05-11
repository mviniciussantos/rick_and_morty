import 'package:hive_ce/hive.dart';

part 'origin_local.g.dart';

@HiveType(typeId: 1)
class OriginLocal extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String url;
}
