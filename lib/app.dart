import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'shared/widgets/custom_bottom_nav.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/prayer/presentation/prayer_page.dart';
import 'features/prayer/bloc/prayer_bloc.dart';
import 'features/prayer/bloc/prayer_event.dart';
import 'features/worship/presentation/worship_page.dart';
import 'features/duas/presentation/duas_page.dart';
import 'features/settings/presentation/settings_page.dart';

class WaqtApp extends StatelessWidget {
  const WaqtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:      const Size(390, 844),
      minTextAdapt:    true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title:                      AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme:                      AppTheme.darkTheme,
          home:                       const MainScreen(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final PrayerBloc _prayerBloc;

  @override
  void initState() {
    super.initState();
    _prayerBloc = PrayerBloc()..add(LoadPrayerTimes());
  }

  @override
  void dispose() {
    _prayerBloc.close();
    super.dispose();
  }

  void _onTabChanged(int index) {
    if (index == 0) _prayerBloc.add(LoadPrayerTimes());
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        BlocProvider.value(
          value: _prayerBloc,
          child: const PrayerPage(),
        ),
        const WorshipPage(),
        const DuasPage(),
        SettingsPage(onCityChanged: () => _prayerBloc.add(LoadPrayerTimes())),
      ][_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap:        _onTabChanged,
      ),
    );
  }
}