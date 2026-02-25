abstract class SettingsEvent {}

class LoadSettings           extends SettingsEvent {}
class TogglePrayerNotif      extends SettingsEvent { final bool value; TogglePrayerNotif(this.value); }
class ToggleQuranNotif       extends SettingsEvent { final bool value; ToggleQuranNotif(this.value); }
class ToggleAzkarNotif       extends SettingsEvent { final bool value; ToggleAzkarNotif(this.value); }
class ToggleDnd              extends SettingsEvent { final bool value; ToggleDnd(this.value); }