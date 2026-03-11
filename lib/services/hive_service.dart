import 'package:hive_flutter/hive_flutter.dart';

import '../../features/adhkar/dua_model.dart';
import '../../features/prayer_times/data/prayer_log_model.dart';
////// object، بتستدعيه مباشرة بـ HiveService.init()

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(PrayerLogModelAdapter());
    Hive.registerAdapter(DuaModelAdapter());

    await Hive.openBox<PrayerLogModel>('prayer_logs');
    await Hive.openBox<DuaModel>('duas');
    await Hive.openBox('settings');
  }

  static Box<PrayerLogModel> get prayerLogs =>
      Hive.box<PrayerLogModel>('prayer_logs');

  static Box<DuaModel> get duas =>
      Hive.box<DuaModel>('duas');

  static Box get settings =>
      Hive.box('settings');
}