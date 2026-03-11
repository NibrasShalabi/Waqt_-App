import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/cities_data.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/widget_service.dart';
import '../../../data/repositories/prayer_repository.dart';
import 'prayer_event.dart';
import 'prayer_state.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final PrayerRepository _repo = PrayerRepository();

  PrayerBloc() : super(PrayerInitial()) {
    on<LoadPrayerTimes>(_onLoad);
    on<UpdatePrayerLog>(_onUpdateLog);
    on<LoadWeeklyLog>(_onLoadWeekly);
    on<ChangeCity>(_onChangeCity);
  }

  Future<void> _onLoad(LoadPrayerTimes event, Emitter emit) async {
    emit(PrayerLoading());
    try {
      final prefs    = await SharedPreferences.getInstance();
      final cityName = prefs.getString('selected_city') ?? 'دمشق';
      final city     = CitiesData.cities.firstWhere(
            (c) => c.nameAr == cityName,
        orElse: () => CitiesData.cities.first,
      );

      final coords      = Coordinates(city.latitude, city.longitude);
      final params      = CalculationMethod.muslim_world_league.getParameters();
      params.madhab     = Madhab.shafi;
      final prayerTimes = PrayerTimes.today(coords, params);

      // حل مشكلة Prayer.none بعد العشاء
      final nextPrayer = prayerTimes.nextPrayer();
      final DateTime nextTime;
      final Prayer   displayPrayer;

      if (nextPrayer == Prayer.none) {
        final tomorrow      = DateTime.now().add(const Duration(days: 1));
        final tomorrowTimes = PrayerTimes(coords, DateComponents.from(tomorrow), params);
        nextTime      = tomorrowTimes.fajr ?? DateTime.now().add(const Duration(hours: 8));
        displayPrayer = Prayer.fajr;
      } else {
        nextTime      = prayerTimes.timeForPrayer(nextPrayer) ?? DateTime.now().add(const Duration(hours: 1));
        displayPrayer = nextPrayer;
      }

      final today      = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final todayLog   = await _repo.getLog(today);
      final weeklyLogs = await _repo.getWeeklyLogs();
      // final percentage = _repo.getWeeklyPercentage(weeklyLogs);

      emit(PrayerLoaded(
        prayerTimes:      prayerTimes,
        nextPrayer:       displayPrayer,
        nextPrayerTime:   nextTime,
        todayLog:         todayLog,
        weeklyLogs:       weeklyLogs,
        // weeklyPercentage: percentage,
        cityName:         cityName,
      ));

      // try {
      //   if (prefs.getBool('prayer_notif') ?? true) {
      //     await NotificationService.schedulePrayerNotifications(prayerTimes);
      //   }
      //   await NotificationService.scheduleQuranReminder(prefs.getBool('quran_notif') ?? true);
      //   await NotificationService.scheduleAzkarReminders(prefs.getBool('azkar_notif') ?? true);
      // } catch (e) {
      //   print('Notification Error: $e');
      // }

      try {
        await WidgetService.updateWidget(
          prayerName: getPrayerName(displayPrayer),
          prayerTime: _formatTime(nextTime),
          cityName:   cityName,
          dhikr:      WidgetService.getRandomDhikr(),
        );
      } catch (e) {
        print('Widget Error: $e');
      }

    } catch (e) {
      print('PrayerBloc Error: $e');
      emit(PrayerError(e.toString()));
    }
  }

  Future<void> _onUpdateLog(UpdatePrayerLog event, Emitter emit) async {
    if (state is! PrayerLoaded) return;
    final current = state as PrayerLoaded;
    final log     = current.todayLog;

    switch (event.prayer) {
      case 'fajr':    log.fajr    = event.value; break;
      case 'dhuhr':   log.dhuhr   = event.value; break;
      case 'asr':     log.asr     = event.value; break;
      case 'maghrib': log.maghrib = event.value; break;
      case 'isha':    log.isha    = event.value; break;
    }

    await _repo.updatePrayer(log);
    final weeklyLogs = await _repo.getWeeklyLogs();
    final percentage = _repo.getWeeklyPercentage(weeklyLogs);

    emit(PrayerLoaded(
      prayerTimes:      current.prayerTimes,
      nextPrayer:       current.nextPrayer,
      nextPrayerTime:   current.nextPrayerTime,
      todayLog:         log,
      weeklyLogs:       weeklyLogs,
      // weeklyPercentage: percentage,
      cityName:         current.cityName,
    ));
  }

  Future<void> _onLoadWeekly(LoadWeeklyLog event, Emitter emit) async {
    if (state is! PrayerLoaded) return;
    final current    = state as PrayerLoaded;
    final weeklyLogs = await _repo.getWeeklyLogs();
    final percentage = _repo.getWeeklyPercentage(weeklyLogs);

    emit(PrayerLoaded(
      prayerTimes:      current.prayerTimes,
      nextPrayer:       current.nextPrayer,
      nextPrayerTime:   current.nextPrayerTime,
      todayLog:         current.todayLog,
      weeklyLogs:       weeklyLogs,
      // weeklyPercentage: percentage,
      cityName:         current.cityName,
    ));
  }

  Future<void> _onChangeCity(ChangeCity event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_city', event.cityName);
    add(LoadPrayerTimes());
  }

  String _formatTime(DateTime time) {
    int    hour   = time.hour;
    final  minute = time.minute.toString().padLeft(2, '0');
    final  period = hour >= 12 ? 'م' : 'ص';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $period';
  }

  String getPrayerName(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:    return 'الفجر';
      case Prayer.sunrise: return 'الشروق';
      case Prayer.dhuhr:   return 'الظهر';
      case Prayer.asr:     return 'العصر';
      case Prayer.maghrib: return 'المغرب';
      case Prayer.isha:    return 'العشاء';
      default:             return '';
    }
  }
}