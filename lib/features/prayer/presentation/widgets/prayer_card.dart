import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class PrayerCard extends StatelessWidget {
  final String   name;
  final String   time;
  final Color    color;
  final IconData icon;
  final bool     isNext;
  final bool     isPassed;

  const PrayerCard({
    super.key,
    required this.name,
    required this.time,
    required this.color,
    required this.icon,
    this.isNext   = false,
    this.isPassed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingS),
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical:   AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color:        isNext ? color.withOpacity(0.15) : AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: isNext ? color : AppColors.border,
          width: isNext ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // الأيقونة
          Container(
            width:  40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color:        color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(icon, color: color, size: AppDimensions.iconM),
          ),
          SizedBox(width: AppDimensions.paddingM),

          // اسم الصلاة
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color:      isPassed ? AppColors.textHint : AppColors.textPrimary,
                fontSize:   AppDimensions.fontL,
                fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),

          // الوقت
          Text(
            time,
            style: TextStyle(
              color:      isNext ? AppColors.gold : AppColors.textSecondary,
              fontSize:   AppDimensions.fontL,
              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'monospace',
            ),
          ),

          // بادج القادمة
          if (isNext) ...[
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w,
                vertical:   2.h,
              ),
              decoration: BoxDecoration(
                color:        AppColors.gold,
                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              ),
              child: Text(
                'القادمة',
                style: TextStyle(
                  color:      AppColors.background,
                  fontSize:   AppDimensions.fontXS,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}