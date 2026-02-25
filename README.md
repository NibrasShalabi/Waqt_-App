# Waqt — وَقْت

  A comprehensive Islamic app for prayer times & daily worship


---

## ✨ Features

### 🕌 Prayer Times
- Accurate prayer time calculation based on selected city
- Countdown timer to the next prayer
- 100+ Arabic & international cities supported
- Prayer time notifications

### 📋 Prayer Log
- Daily prayer tracking
- Daily commitment progress indicator

### 📿 Worship
- Customizable Tasbih counter
- Quran reading progress tracker

### 📖 Duas & Dhikr
- Comprehensive library of duas and adhkar
- Morning & evening dhikr with reminders
- Daily Quran reading reminder

### ⚙️ Settings
- City selection from a full list
- Full notification control
- Do Not Disturb mode

---

## 🚀 Upcoming Features

> This is the initial release — the following features will be added in upcoming updates

- ⬜ Full Quran inside the app
- ⬜ Audio recitation by famous Qaris
- ⬜ Quran Tafsir (interpretation)
- ⬜ Home screen widget
- ⬜ UI improvements
- ⬜ iOS support

---

## 🛠️ Requirements

- Flutter 3.x or higher
- Dart 3.x or higher
- Android 5.0 (API 21) or higher

---

## 📦 Dependencies

| Package | Description |
|---------|-------------|
| `flutter_bloc` | State management |
| `adhan` | Prayer time calculation |
| `hive` | Local database |
| `flutter_local_notifications` | Notifications |
| `shared_preferences` | Settings storage |
| `flutter_screenutil` | Responsive UI |

---

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/       # Colors, dimensions, cities
│   └── services/        # Notifications, widget
├── data/
│   ├── models/          # Hive models
│   └── repositories/    # Data repositories
├── features/
│   ├── prayer/          # Prayer times
│   ├── worship/         # Tasbih & Quran
│   ├── duas/            # Duas & Adhkar
│   └── settings/        # App settings
└── shared/
    └── widgets/         # Shared widgets
```

---
Built with Flutter & ❤️
Waqt v1.0.0 — 2025