import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness:   Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary:     AppColors.primary,
      secondary:   AppColors.gold,
      surface:     AppColors.surface,
      error:       AppColors.error,
      onPrimary:   AppColors.textPrimary,
      onSecondary: AppColors.background,
      onSurface:   AppColors.textPrimary,
      onError:     AppColors.textPrimary,
    ),

    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation:       0,
      centerTitle:     true,
      titleTextStyle: TextStyle(
        color:      AppColors.gold,
        fontSize:   AppDimensions.fontXXL,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColors.gold),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:     AppColors.surface,
      selectedItemColor:   AppColors.gold,
      unselectedItemColor: AppColors.textHint,
      type:                BottomNavigationBarType.fixed,
      elevation:           0,
      selectedLabelStyle: TextStyle(
        fontSize:   AppDimensions.fontXS,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: AppDimensions.fontXS,
      ),
    ),

    cardTheme: CardTheme(
      color:     AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color:     AppColors.divider,
      thickness: 1,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled:    true,
      fillColor: AppColors.surfaceLight,
      hintStyle:  const TextStyle(color: AppColors.textHint),
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide:   const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide:   const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        borderSide:   const BorderSide(color: AppColors.gold, width: 1.5),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical:   AppDimensions.paddingM,
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge:  TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 57.sp),
      displayMedium: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 45.sp),
      titleLarge:    TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: AppDimensions.fontXXL),
      titleMedium:   TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontL),
      titleSmall:    TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM),
      bodyLarge:     TextStyle(color: AppColors.textPrimary, fontSize: AppDimensions.fontL),
      bodyMedium:    TextStyle(color: AppColors.textSecondary, fontSize: AppDimensions.fontM),
      bodySmall:     TextStyle(color: AppColors.textHint, fontSize: AppDimensions.fontS),
      labelLarge:    TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: AppDimensions.fontM),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) =>
      states.contains(WidgetState.selected)
          ? AppColors.gold
          : AppColors.textHint),
      trackColor: WidgetStateProperty.resolveWith((states) =>
      states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.surfaceLight),
    ),
  );
}