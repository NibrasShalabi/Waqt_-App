import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../../features/prayer/presentation/prayer_page.dart';
import '../../features/worship/presentation/worship_page.dart';
import '../../features/duas/presentation/duas_page.dart';
import '../../features/settings/presentation/settings_page.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<Widget> pages = [
    PrayerPage(),
    WorshipPage(),
    DuasPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap:        onTap,
        items: const [
          BottomNavigationBarItem(
            icon:  Icon(Icons.access_time_outlined),
            activeIcon: Icon(Icons.access_time_filled),
            label: AppStrings.navPrayer,
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.self_improvement_outlined),
            activeIcon: Icon(Icons.self_improvement),
            label: AppStrings.navWorship,
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: AppStrings.navDuas,
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: AppStrings.navSettings,
          ),
        ],
      ),
    );
  }
}