import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static const String _prayerNotifKey = 'prayer_notif';
  static const String _quranNotifKey  = 'quran_notif';
  static const String _azkarNotifKey  = 'azkar_notif';
  static const String _dndKey         = 'dnd_mode';

  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoad);
    on<TogglePrayerNotif>(_onTogglePrayer);
    on<ToggleQuranNotif>(_onToggleQuran);
    on<ToggleAzkarNotif>(_onToggleAzkar);
    on<ToggleDnd>(_onToggleDnd);
  }

  Future<void> _onLoad(LoadSettings event, Emitter emit) async {
    emit(SettingsLoading());
    final prefs = await SharedPreferences.getInstance();
    emit(SettingsLoaded(
      prayerNotif: prefs.getBool(_prayerNotifKey) ?? true,
      quranNotif:  prefs.getBool(_quranNotifKey)  ?? true,
      azkarNotif:  prefs.getBool(_azkarNotifKey)  ?? true,
      dndMode:     prefs.getBool(_dndKey)         ?? false,
    ));
  }

  Future<void> _onTogglePrayer(TogglePrayerNotif event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prayerNotifKey, event.value);
    if (state is SettingsLoaded) {
      final s = state as SettingsLoaded;
      emit(SettingsLoaded(prayerNotif: event.value, quranNotif: s.quranNotif, azkarNotif: s.azkarNotif, dndMode: s.dndMode));
    }
  }

  Future<void> _onToggleQuran(ToggleQuranNotif event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_quranNotifKey, event.value);
    if (state is SettingsLoaded) {
      final s = state as SettingsLoaded;
      emit(SettingsLoaded(prayerNotif: s.prayerNotif, quranNotif: event.value, azkarNotif: s.azkarNotif, dndMode: s.dndMode));
    }
  }

  Future<void> _onToggleAzkar(ToggleAzkarNotif event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_azkarNotifKey, event.value);
    if (state is SettingsLoaded) {
      final s = state as SettingsLoaded;
      emit(SettingsLoaded(prayerNotif: s.prayerNotif, quranNotif: s.quranNotif, azkarNotif: event.value, dndMode: s.dndMode));
    }
  }

  Future<void> _onToggleDnd(ToggleDnd event, Emitter emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dndKey, event.value);
    if (state is SettingsLoaded) {
      final s = state as SettingsLoaded;
      emit(SettingsLoaded(prayerNotif: s.prayerNotif, quranNotif: s.quranNotif, azkarNotif: s.azkarNotif, dndMode: event.value));
    }
  }
}