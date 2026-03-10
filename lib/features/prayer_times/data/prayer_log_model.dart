import 'package:hive/hive.dart';

part 'prayer_log_model.g.dart';

@HiveType(typeId: 1)
class PrayerLogModel extends HiveObject {
  @HiveField(0)
  String date; // yyyy-MM-dd

  @HiveField(1)
  bool fajr;

  @HiveField(2)
  bool dhuhr;

  @HiveField(3)
  bool asr;

  @HiveField(4)
  bool maghrib;

  @HiveField(5)
  bool isha;

  PrayerLogModel({
    required this.date,
    this.fajr    = false,
    this.dhuhr   = false,
    this.asr     = false,
    this.maghrib = false,
    this.isha    = false,
  });
}