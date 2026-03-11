  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:waqt/services/hive_service.dart';
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


    await HiveService.init();

    // await DuaRepository().initDefaults();
    // await NotificationService.init();
    // await NotificationService.requestPermission();

    runApp(const WaqtApp());
  }