abstract class PrayerEvent {}

class LoadPrayerTimes extends PrayerEvent {}

class UpdatePrayerLog extends PrayerEvent {
  final String prayer;
  final bool value;

  UpdatePrayerLog(this.prayer, this.value);
}

class LoadWeeklyLog extends PrayerEvent {}
class ChangeCity extends PrayerEvent {
  final String cityName;
  ChangeCity(this.cityName);
}