import 'package:equatable/equatable.dart';

class PrayerTimeModel extends Equatable {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final String   cityName;
  final DateTime date;

  const PrayerTimeModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.cityName,
    required this.date,
  });

  @override
  List<Object> get props => [
    fajr, sunrise, dhuhr, asr, maghrib, isha, cityName, date,
  ];
}