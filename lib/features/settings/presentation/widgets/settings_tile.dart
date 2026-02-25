import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class SettingsTile extends StatelessWidget {
  final IconData   icon;
  final Color      iconColor;
  final String     title;
  final String     subtitle;
  final bool       value;
  final void Function(bool) onChanged;
  final bool       showDivider;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width:  40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color:        iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(icon, color: iconColor, size: AppDimensions.iconM),
          ),
          title: Text(
            title,
            style: TextStyle(
              color:    AppColors.textPrimary,
              fontSize: AppDimensions.fontM,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color:    AppColors.textHint,
              fontSize: AppDimensions.fontS,
            ),
          ),
          trailing: Switch(
            value:     value,
            onChanged: onChanged,
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color:  AppColors.divider,
            indent: 70.w,
          ),
      ],
    );
  }
}