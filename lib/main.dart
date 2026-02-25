  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:hive_flutter/hive_flutter.dart';
  import 'package:waqt/core/services/notification_service.dart';
  import 'data/models/dua_model.dart';
  import 'data/models/prayer_log_model.dart';
  import 'data/models/quran_progress_model.dart';
  import 'data/repositories/dua_repository.dart';
  import 'app.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:          Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    await Hive.initFlutter();
    Hive.registerAdapter(DuaModelAdapter());
    Hive.registerAdapter(PrayerLogModelAdapter());
    Hive.registerAdapter(QuranProgressModelAdapter());

    await DuaRepository().initDefaults();
    await NotificationService.init();
    await NotificationService.requestPermission();

    runApp(const WaqtApp());
  }