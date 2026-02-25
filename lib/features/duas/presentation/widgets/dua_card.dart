import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class DuaCard extends StatelessWidget {
  final String       title;
  final String       content;
  final String       source;
  final bool         isDefault;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DuaCard({
    super.key,
    required this.title,
    required this.content,
    required this.source,
    required this.isDefault,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimensions.paddingM),
      decoration: BoxDecoration(
        color:        AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border:       Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          // Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical:   AppDimensions.paddingS,
            ),
            decoration: BoxDecoration(
              color:        AppColors.surfaceLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppDimensions.radiusXL),
                topLeft:  Radius.circular(AppDimensions.radiusXL),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color:      AppColors.gold,
                      fontSize:   AppDimensions.fontM,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // أزرار تعديل/حذف
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.textHint,
                    size:  AppDimensions.iconM,
                  ),
                  padding:     EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(width: AppDimensions.paddingS),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                    size:  AppDimensions.iconM,
                  ),
                  padding:     EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // النص الكامل
          Padding(
            padding: EdgeInsets.all(AppDimensions.paddingM),
            child: Text(
              content,
              style: TextStyle(
                color:    AppColors.textPrimary,
                fontSize: AppDimensions.fontXL,
                height:   2.0,
              ),
              textAlign: TextAlign.right,
            ),
          ),

          // Footer — المصدر + نسخ
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.paddingM,
              0,
              AppDimensions.paddingM,
              AppDimensions.paddingM,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (source.isNotEmpty)
                  Text(
                    source,
                    style: TextStyle(
                      color:    AppColors.textHint,
                      fontSize: AppDimensions.fontS,
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: content));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'تم النسخ',
                          style: TextStyle(fontSize: AppDimensions.fontM),
                        ),
                        backgroundColor: AppColors.primary,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.copy, color: AppColors.textHint, size: AppDimensions.iconS),
                      SizedBox(width: 4.w),
                      Text(
                        'نسخ',
                        style: TextStyle(
                          color:    AppColors.textHint,
                          fontSize: AppDimensions.fontS,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}