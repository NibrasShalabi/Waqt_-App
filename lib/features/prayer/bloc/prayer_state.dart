import 'package:adhan/adhan.dart';
import '../../prayer_times/data/prayer_log_model.dart';

abstract class PrayerState {}

class PrayerInitial extends PrayerState {}
class PrayerLoading extends PrayerState {}
class PrayerError   extends PrayerState {
  final String message;
  PrayerError(this.message);
}

class PrayerLoaded extends PrayerState {
  final PrayerTimes         prayerTimes;
  final Prayer              nextPrayer;
  final DateTime            nextPrayerTime;
  final PrayerLogModel      todayLog;
  final List<PrayerLogModel> weeklyLogs;
  // final double              weeklyPercentage;
  final String              cityName;

  PrayerLoaded({
    required this.prayerTimes,
    required this.nextPrayer,
    required this.nextPrayerTime,
    required this.todayLog,
    required this.weeklyLogs,
    // required this.weeklyPercentage,
    required this.cityName,
  });
}