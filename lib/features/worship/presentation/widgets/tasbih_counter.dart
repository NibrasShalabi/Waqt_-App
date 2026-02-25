import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class TasbihCounter extends StatelessWidget {
  final List<Map<String, dynamic>>  items;
  final void Function(int)          onIncrement;
  final void Function(int)          onReset;
  final void Function(int, String)  onUpdateLabel;

  const TasbihCounter({
    super.key,
    required this.items,
    required this.onIncrement,
    required this.onReset,
    required this.onUpdateLabel,
  });

  void _showEditDialog(BuildContext context, int index) {
    final controller = TextEditingController(text: items[index]['label']);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('تعديل الذكر',
            style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          autofocus:  true,
          textAlign:  TextAlign.right,
          style: TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM),
          decoration: const InputDecoration(labelText: 'نص الذكر'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onUpdateLabel(index, controller.text);
              }
              Navigator.pop(context);
            },
            child: Text('حفظ', style: TextStyle(color: AppColors.gold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border:       Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical:   AppDimensions.paddingS,
                ),
                child: Row(
                  children: [
                    // أيقونة التعديل
                    GestureDetector(
                      onTap: () => _showEditDialog(context, i),
                      child: Container(
                        width:  36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color:        AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                        ),
                        child: Icon(Icons.edit_outlined, color: AppColors.textHint, size: AppDimensions.iconS),
                      ),
                    ),
                    SizedBox(width: AppDimensions.paddingS),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['label'],
                              style: TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                          Text('${item['count']} مرة',
                              style: TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontS)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () { HapticFeedback.mediumImpact(); onReset(i); },
                      child: Container(
                        width:  36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color:        AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                        ),
                        child: Icon(Icons.refresh, color: AppColors.textHint, size: AppDimensions.iconM),
                      ),
                    ),
                    SizedBox(width: AppDimensions.paddingS),
                    GestureDetector(
                      onTap: () { HapticFeedback.lightImpact(); onIncrement(i); },
                      child: Container(
                        width:  56.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color:        AppColors.gold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                          border:       Border.all(color: AppColors.gold),
                        ),
                        child: Center(
                          child: Text('${item['count']}',
                              style: TextStyle(color: AppColors.gold, fontSize: AppDimensions.fontL, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (i < items.length - 1) Divider(height: 1, color: AppColors.divider),
            ],
          );
        }),
      ),
    );
  }
}