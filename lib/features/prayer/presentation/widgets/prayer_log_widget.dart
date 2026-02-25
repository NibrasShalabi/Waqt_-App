import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../data/models/prayer_log_model.dart';

class PrayerLogWidget extends StatelessWidget {
  final PrayerLogModel log;
  final void Function(String, bool) onToggle;

  const PrayerLogWidget({
    super.key,
    required this.log,
    required this.onToggle,
  });

  int get _prayedCount =>
      (log.fajr ? 1 : 0) +
          (log.dhuhr ? 1 : 0) +
          (log.asr ? 1 : 0) +
          (log.maghrib ? 1 : 0) +
          (log.isha ? 1 : 0);

  @override
  Widget build(BuildContext context) {
    final percentage = _prayedCount / 5;

    return Container(
      padding:    EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color:        AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border:       Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التزام اليوم',
                style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM),
              ),
              Text(
                '$_prayedCount / 5',
                style: TextStyle(
                  color:      AppColors.gold,
                  fontSize:   AppDimensions.fontL,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingS),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            child: LinearProgressIndicator(
              value:           percentage,
              backgroundColor: AppColors.surfaceLight,
              valueColor:      const AlwaysStoppedAnimation(AppColors.gold),
              minHeight:       6.h,
            ),
          ),
          SizedBox(height: AppDimensions.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _PrayerCheckBox(name: AppStrings.fajr,    checked: log.fajr,    onTap: () => onToggle('fajr',    !log.fajr)),
              _PrayerCheckBox(name: AppStrings.dhuhr,   checked: log.dhuhr,   onTap: () => onToggle('dhuhr',   !log.dhuhr)),
              _PrayerCheckBox(name: AppStrings.asr,     checked: log.asr,     onTap: () => onToggle('asr',     !log.asr)),
              _PrayerCheckBox(name: AppStrings.maghrib, checked: log.maghrib, onTap: () => onToggle('maghrib', !log.maghrib)),
              _PrayerCheckBox(name: AppStrings.isha,    checked: log.isha,    onTap: () => onToggle('isha',    !log.isha)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrayerCheckBox extends StatelessWidget {
  final String       name;
  final bool         checked;
  final VoidCallback onTap;

  const _PrayerCheckBox({
    required this.name,
    required this.checked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width:  40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: checked
                  ? AppColors.primary.withOpacity(0.3)
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              border: Border.all(
                color: checked ? AppColors.primary : AppColors.border,
              ),
            ),
            child: checked
                ? Icon(Icons.check, color: AppColors.gold, size: 20.w)
                : null,
          ),
          SizedBox(height: 4.h),
          Text(
            name,
            style: TextStyle(
              color:    AppColors.textSecondary,
              fontSize: AppDimensions.fontXS,
            ),
          ),
        ],
      ),
    );
  }
}