import 'package:hive_flutter/hive_flutter.dart';
import '../../features/prayer_times/data/prayer_log_model.dart';

class PrayerRepository {
  static const String _boxName = 'prayer_log';

  Future<Box<PrayerLogModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box(_boxName)
          : await Hive.openBox<PrayerLogModel>(_boxName);

  // جلب سجل يوم معين
  Future<PrayerLogModel> getLog(String date) async {
    final box = await _box;
    final existing = box.values
        .where((l) => l.date == date)
        .toList();

    if (existing.isNotEmpty) return existing.first;

    // إنشاء سجل جديد لهذا اليوم
    final newLog = PrayerLogModel(date: date);
    await box.add(newLog);
    return newLog;
  }

  // تحديث صلاة معينة
  Future<void> updatePrayer(PrayerLogModel log) async {
    await log.save();
  }

  // جلب سجلات آخر 7 أيام
  Future<List<PrayerLogModel>> getWeeklyLogs() async {
    final box  = await _box;
    final now  = DateTime.now();
    final logs = <PrayerLogModel>[];

    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final key  = '${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}';
      final existing = box.values.where((l) => l.date == key).toList();
      if (existing.isNotEmpty) {
        logs.add(existing.first);
      }
    }
    return logs;
  }

  Object? getWeeklyPercentage(List<PrayerLogModel> weeklyLogs) {}

  // حساب نسبة الالتزام الأسبوعي
//   double getWeeklyPercentage(List<PrayerLogModel> logs) {
//     if (logs.isEmpty) return 0;
//     int total  = logs.length * 5;
//     int prayed = logs.fold(0, (sum, log) {
//       return sum +
//           (log.fajr    ? 1 : 0) +
//           (log.dhuhr   ? 1 : 0) +
//           (log.asr     ? 1 : 0) +
//           (log.maghrib ? 1 : 0) +
//           (log.isha    ? 1 : 0);
//     });
//     return prayed / total;
//   }
 }