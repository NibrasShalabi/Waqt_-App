import 'hive_service.dart';

class SettingsService {
  // keys
  static const _latKey = 'latitude';
  static const _lngKey = 'longitude';
  static const _cityNameKey = 'city_name';
  static const _prayerNotifKey = 'prayer_notif';
  static const _azkarNotifKey = 'azkar_notif';
  static const _quranNotifKey = 'quran_notif';

// location
  static double get latitude =>
      HiveService.settings.get(_latKey, defaultValue: 33.5138); // Damascus
  static double get longitude =>
      HiveService.settings.get(_lngKey, defaultValue: 36.2765); // Damascus
  static String get cityName =>
      HiveService.settings.get(_cityNameKey, defaultValue: 'دمشق'); // name

  static Future<void> setLocation({
    required double latitude,
    required double longitude,
    required String cityName,
  }) async {
    await HiveService.settings.put(_latKey, latitude);
    await HiveService.settings.put(_lngKey, longitude);
    await HiveService.settings.put(_cityNameKey, cityName);
  }

// Notifications
  // القيمة الأفتراضية انو الأشعار شغال
  static bool get prayerNotif =>
      HiveService.settings.get(_prayerNotifKey, defaultValue: true);
// حدد القيمة لي رح تجيك
  static Future<void> setPrayerNotif(bool value) =>
      HiveService.settings.put(_prayerNotifKey, value);

  static bool get azkarNotif =>
      HiveService.settings.get(_azkarNotifKey, defaultValue: true);

  static Future<void> setAzkarNotif(bool value) =>
      HiveService.settings.put(_azkarNotifKey, value);

  static bool get quranNotif =>
      HiveService.settings.get(_quranNotifKey, defaultValue: true);

  static Future<void> setQuranNotif(bool value) =>
      HiveService.settings.put(_quranNotifKey, value);
}
