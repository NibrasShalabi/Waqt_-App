// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz_data;
// import 'package:adhan/adhan.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _plugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> init() async {
//     if (kIsWeb) return;
//     tz_data.initializeTimeZones();
//     const android  = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);
//     await _plugin.initialize(settings);
//   }
//
//   static Future<void> requestPermission() async {
//     if (kIsWeb) return;
//     final androidImpl = _plugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await androidImpl?.requestNotificationsPermission();
//   }
//
//   static Future<void> schedulePrayerNotifications(PrayerTimes pt) async {
//     if (kIsWeb) return;
//     // await _plugin.cancelAll();
//
//     final prayers = [
//       {'name': 'الفجر',  'time': pt.fajr,    'id': 0},
//       {'name': 'الشروق', 'time': pt.sunrise,  'id': 1},
//       {'name': 'الظهر',  'time': pt.dhuhr,   'id': 2},
//       {'name': 'العصر',  'time': pt.asr,     'id': 3},
//       {'name': 'المغرب', 'time': pt.maghrib, 'id': 4},
//       {'name': 'العشاء', 'time': pt.isha,    'id': 5},
//     ];
//
//     for (final prayer in prayers) {
//       final time = prayer['time'] as DateTime?;
//       if (time == null || time.isBefore(DateTime.now())) continue;
//
//       await _plugin.zonedSchedule(
//         prayer['id'] as int,
//         'حان وقت ${prayer['name']}',
//         'Waqt — وقت',
//         tz.TZDateTime.from(time, tz.local),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'prayer_channel', 'إشعارات الصلاة',
//             channelDescription: 'إشعارات مواقيت الصلاة',
//             importance: Importance.high,
//             priority:   Priority.high,
//           ),
//         ),
//         androidScheduleMode:AndroidScheduleMode.exact ,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//       );
//     }
//   }
//
//   static Future<void> scheduleQuranReminder(bool enabled) async {
//     if (kIsWeb) return;
//     await _plugin.cancel(10);
//     if (!enabled) return;
//
//     await _plugin.zonedSchedule(
//       10,
//       'تذكير القرآن اليومي',
//       'لا تنسَ وردك اليومي من القرآن الكريم',
//       _nextInstanceOfTime(20, 0),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'quran_channel', 'تذكير القرآن',
//           channelDescription: 'تذكير يومي بقراءة القرآن',
//           importance: Importance.defaultImportance,
//           priority:   Priority.defaultPriority,
//         ),
//       ),
//       androidScheduleMode:AndroidScheduleMode.exact ,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
//
//   static Future<void> scheduleAzkarReminders(bool enabled) async {
//     if (kIsWeb) return;
//     await _plugin.cancel(11);
//     await _plugin.cancel(12);
//     if (!enabled) return;
//
//     final entries = [
//       {'id': 11, 'hour': 7,  'title': 'أذكار الصباح', 'body': 'أصبحنا وأصبح الملك لله...'},
//       {'id': 12, 'hour': 17, 'title': 'أذكار المساء',  'body': 'أمسينا وأمسى الملك لله...'},
//     ];
//
//     for (final entry in entries) {
//       await _plugin.zonedSchedule(
//         entry['id'] as int,
//         entry['title'] as String,
//         entry['body']  as String,
//         _nextInstanceOfTime(entry['hour'] as int, 0),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'azkar_channel', 'الأذكار',
//             channelDescription: 'أذكار الصباح والمساء',
//             importance: Importance.defaultImportance,
//             priority:   Priority.defaultPriority,
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exact,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   }
//
//   static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
//     final now       = tz.TZDateTime.now(tz.local);
//     var   scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
//     if (scheduled.isBefore(now)) {
//       scheduled = scheduled.add(const Duration(days: 1));
//     }
//     return scheduled;
//   }
// }