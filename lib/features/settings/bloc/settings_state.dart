abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
class SettingsLoading extends SettingsState {}
class SettingsLoaded  extends SettingsState {
  final bool prayerNotif;
  final bool quranNotif;
  final bool azkarNotif;
  final bool dndMode;

  SettingsLoaded({
    required this.prayerNotif,
    required this.quranNotif,
    required this.azkarNotif,
    required this.dndMode,
  });
}