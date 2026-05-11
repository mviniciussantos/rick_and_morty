import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:rick_and_morty/hive_registrar.g.dart';

class HiveClient {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
  }
}
