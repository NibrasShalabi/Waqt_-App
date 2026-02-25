import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class WidgetService {
  static Future<void> updateWidget({
    required String prayerName,
    required String prayerTime,
    required String cityName,
    required String dhikr,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('flutter.prayer_name', prayerName);
      await prefs.setString('flutter.prayer_time', prayerTime);
      await prefs.setString('flutter.city_name',   cityName);
      await prefs.setString('flutter.dhikr',       dhikr);
      await prefs.commit();

      print('Widget data saved: $prayerName $prayerTime $cityName');

      const platform = MethodChannel('com.example.waqt/widget');
      await platform.invokeMethod('updateWidget');

      print('Widget updated successfully');
    } catch (e) {
      print('WidgetService Error: $e');
    }
  }

  static String getRandomDhikr() {
    final list = [
      'سبحان الله',
      'الحمد لله',
      'الله أكبر',
      'لا إله إلا الله',
      'أستغفر الله',
      'سبحان الله وبحمده',
      'لا حول ولا قوة إلا بالله',
      'سبحان الله العظيم',
    ];
    list.shuffle();
    return list.first;
  }
}