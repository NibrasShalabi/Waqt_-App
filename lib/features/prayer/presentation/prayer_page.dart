import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../features/prayer/bloc/prayer_bloc.dart';
import '../../../features/prayer/bloc/prayer_event.dart';
import '../../../features/prayer/bloc/prayer_state.dart';
import 'package:adhan/adhan.dart';
import 'widgets/next_prayer_banner.dart';
import 'widgets/prayer_card.dart';
import 'widgets/prayer_log_widget.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});

  String _formatTime(DateTime? time) {
    if (time == null) return '--:--';
    int    hour   = time.hour;
    final  minute = time.minute.toString().padLeft(2, '0');
    final  period = hour >= 12 ? 'م' : 'ص';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerBloc, PrayerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state is PrayerLoaded ? state.cityName : 'Waqt'),
          ),
          body: () {
            if (state is PrayerLoading || state is PrayerInitial) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              );
            }

            if (state is PrayerError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_city, color: AppColors.gold, size: AppDimensions.iconXL),
                    SizedBox(height: AppDimensions.paddingM),
                    Text('اختر مدينتك من الإعدادات',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM)),
                    SizedBox(height: AppDimensions.paddingS),
                    Text('دمشق هي المدينة الافتراضية',
                        style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontS)),
                    SizedBox(height: AppDimensions.paddingM),
                    ElevatedButton(
                      onPressed: () => context.read<PrayerBloc>().add(LoadPrayerTimes()),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is PrayerLoaded) {
              final pt  = state.prayerTimes;
              final log = state.todayLog;
              return SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NextPrayerBanner(
                      prayerName: context.read<PrayerBloc>().getPrayerName(state.nextPrayer),
                      nextTime:   state.nextPrayerTime,
                    ),
                    SizedBox(height: AppDimensions.paddingL),
                    Text(AppStrings.prayerTime,
                        style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                    SizedBox(height: AppDimensions.paddingS),
                    PrayerCard(name: AppStrings.fajr,    time: _formatTime(pt.fajr),    color: AppColors.fajr,    icon: Icons.nightlight_round,    isNext: state.nextPrayer == Prayer.fajr),
                    PrayerCard(name: AppStrings.sunrise, time: _formatTime(pt.sunrise),  color: AppColors.sunrise, icon: Icons.wb_twilight,          isNext: state.nextPrayer == Prayer.sunrise),
                    PrayerCard(name: AppStrings.dhuhr,   time: _formatTime(pt.dhuhr),   color: AppColors.dhuhr,   icon: Icons.wb_sunny,             isNext: state.nextPrayer == Prayer.dhuhr),
                    PrayerCard(name: AppStrings.asr,     time: _formatTime(pt.asr),     color: AppColors.asr,     icon: Icons.wb_sunny_outlined,    isNext: state.nextPrayer == Prayer.asr),
                    PrayerCard(name: AppStrings.maghrib, time: _formatTime(pt.maghrib), color: AppColors.maghrib, icon: Icons.wb_twilight_outlined, isNext: state.nextPrayer == Prayer.maghrib),
                    PrayerCard(name: AppStrings.isha,    time: _formatTime(pt.isha),    color: AppColors.isha,    icon: Icons.nights_stay,          isNext: state.nextPrayer == Prayer.isha),
                    SizedBox(height: AppDimensions.paddingL),
                    Text(AppStrings.prayerLog,
                        style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                    SizedBox(height: AppDimensions.paddingS),
                    PrayerLogWidget(
                      log:      log,
                      onToggle: (prayer, value) =>
                          context.read<PrayerBloc>().add(UpdatePrayerLog(prayer, value)),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          }(),
        );
      },
    );
  }
}