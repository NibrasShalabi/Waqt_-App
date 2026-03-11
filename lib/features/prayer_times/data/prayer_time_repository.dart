import 'package:adhan/adhan.dart';
import 'package:waqt/features/prayer_times/domain/prayer_time_model.dart';
import 'package:waqt/services/dio_service.dart';
import 'package:waqt/services/settings_service.dart';

class PrayerTimeRepository {
  Future<PrayerTimeModel> getPrayerTimes ()async {
final lat  = SettingsService.latitude ;
final lng      = SettingsService.longitude;
final cityName = SettingsService.cityName;
final now      = DateTime.now();
final date     = '${now.day.toString().padLeft(2, '0')}-' '${now.month.toString().padLeft(2, '0')}-' '${now.year}';
try{
return await _fromApi (lat , lng , cityName , date);
}catch(_){
  return _fromAdhan (lat , lng , cityName);
}
  }


  Future <PrayerTimeModel> _fromApi(
      double lat, double lng, String cityName, String date,

      )async{
    final data  = await DioService.get('timings/$date', params: {'latitude': lat, 'longitude': lng, 'method': 3},);
  final timings = data ['data']['timings'];   
  return PrayerTimeModel(
    fajr:     _parseTime(timings['Fajr']),
    sunrise:  _parseTime(timings['Sunrise']),
    dhuhr:    _parseTime(timings['Dhuhr']),
    asr:      _parseTime(timings['Asr']),
    maghrib:  _parseTime(timings['Maghrib']),
    isha:     _parseTime(timings['Isha']),
    cityName: cityName,
    date:     DateTime.now(),
  );
  }
  PrayerTimeModel _fromAdhan (double lat, double lng, String cityName) {
    final coords =  Coordinates(lat, lng);
    final params  = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    final pt      = PrayerTimes.today(coords, params);

    return PrayerTimeModel(
      fajr:     pt.fajr,
      sunrise:  pt.sunrise,
      dhuhr:    pt.dhuhr,
      asr:      pt.asr,
      maghrib:  pt.maghrib,
      isha:     pt.isha,
      cityName: cityName,
      date:     DateTime.now(),
    );
  }
  DateTime _parseTime(String time) {
    final parts  = time.split(':');
    final hour   = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final now    = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }


}