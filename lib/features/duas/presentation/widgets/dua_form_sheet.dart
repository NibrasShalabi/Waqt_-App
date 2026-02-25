import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';

class DuaFormSheet extends StatefulWidget {
  final Map<String, dynamic>?               existing;
  final bool                                isAzkar;
  final void Function(Map<String, dynamic>) onSave;

  const DuaFormSheet({
    super.key,
    this.existing,
    required this.isAzkar,
    required this.onSave,
  });

  @override
  State<DuaFormSheet> createState() => _DuaFormSheetState();
}

class _DuaFormSheetState extends State<DuaFormSheet> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _sourceController;

  @override
  void initState() {
    super.initState();
    _titleController   = TextEditingController(text: widget.existing?['title']);
    _contentController = TextEditingController(text: widget.existing?['content']);
    _sourceController  = TextEditingController(text: widget.existing?['source']);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _sourceController.dispose();
    super.dispose();
  }

  void _save() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) return;
    widget.onSave({
      'title':   _titleController.text,
      'content': _contentController.text,
      'source':  _sourceController.text,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width:  40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color:        AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),

            Text(
              widget.existing == null
                  ? (widget.isAzkar ? 'إضافة ذكر' : AppStrings.addDua)
                  : (widget.isAzkar ? 'تعديل ذكر' : AppStrings.editDua),
              style: TextStyle(
                color:      AppColors.gold,
                fontSize:   AppDimensions.fontXL,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),

            TextField(
              controller: _titleController,
              style:      TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM),
              decoration: InputDecoration(
                labelText: widget.isAzkar ? 'اسم الذكر' : AppStrings.duaTitle,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: AppDimensions.paddingM),

            TextField(
              controller: _contentController,
              style:      TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM),
              decoration: InputDecoration(
                labelText: widget.isAzkar ? 'نص الذكر' : AppStrings.duaContent,
              ),
              maxLines:  4,
              textAlign: TextAlign.right,
            ),
            SizedBox(height: AppDimensions.paddingM),

            TextField(
              controller: _sourceController,
              style:      TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontM),
              decoration: InputDecoration(labelText: AppStrings.duaSource),
              textAlign:  TextAlign.right,
            ),
            SizedBox(height: AppDimensions.paddingL),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                    ),
                    child: Text(AppStrings.cancel, style: TextStyle(fontSize: AppDimensions.fontM)),
                  ),
                ),
                SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                    ),
                    child: Text(AppStrings.save, style: TextStyle(fontSize: AppDimensions.fontM)),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingM),
          ],
        ),
      ),
    );
  }
}