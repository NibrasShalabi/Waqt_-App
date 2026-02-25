import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../data/models/quran_progress_model.dart';

class QuranTracker extends StatelessWidget {
  final QuranProgressModel progress;
  final void Function(int) onKhatmChanged;
  final void Function(int) onJuzChanged;

  const QuranTracker({
    super.key,
    required this.progress,
    required this.onKhatmChanged,
    required this.onJuzChanged,
  });

  int get _totalJuz  => progress.khatmCount * 30;
  int get _juzPerDay => progress.khatmCount;
  double get _prog   => _totalJuz == 0 ? 0 : progress.currentJuz / _totalJuz;

  @override
  Widget build(BuildContext context) {
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
              Text(AppStrings.khatmCount,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM)),
              Row(
                children: [
                  _CounterButton(
                    icon:  Icons.remove,
                    onTap: () { if (progress.khatmCount > 1) onKhatmChanged(progress.khatmCount - 1); },
                  ),
                  SizedBox(width: AppDimensions.paddingS),
                  Text('${progress.khatmCount}',
                      style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontXL, fontWeight: FontWeight.bold)),
                  SizedBox(width: AppDimensions.paddingS),
                  _CounterButton(
                    icon:  Icons.add,
                    onTap: () => onKhatmChanged(progress.khatmCount + 1),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),
          Divider(color: AppColors.divider),
          SizedBox(height: AppDimensions.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.dailyTarget,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM)),
              Text('$_juzPerDay ${AppStrings.juzPerDay}',
                  style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontM, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.progress,
                  style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM)),
              Text('${progress.currentJuz} / $_totalJuz جزء',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM)),
            ],
          ),
          SizedBox(height: AppDimensions.paddingS),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            child: LinearProgressIndicator(
              value:           _prog,
              backgroundColor: AppColors.surfaceLight,
              valueColor:      const AlwaysStoppedAnimation(AppColors.gold),
              minHeight:       8.h,
            ),
          ),
          SizedBox(height: AppDimensions.paddingM),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () { if (progress.currentJuz > 0) onJuzChanged(progress.currentJuz - 1); },
                  icon:  Icon(Icons.remove, size: AppDimensions.iconS),
                  label: Text('جزء -', style: TextStyle(fontSize: AppDimensions.fontM)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                  ),
                ),
              ),
              SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () { if (progress.currentJuz < _totalJuz) onJuzChanged(progress.currentJuz + 1); },
                  icon:  Icon(Icons.add, size: AppDimensions.iconS),
                  label: Text('جزء +', style: TextStyle(fontSize: AppDimensions.fontM)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData     icon;
  final VoidCallback onTap;
  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color:        AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          border:       Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.gold, size: AppDimensions.iconS),
      ),
    );
  }
}