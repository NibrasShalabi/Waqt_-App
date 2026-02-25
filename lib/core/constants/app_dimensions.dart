import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  AppDimensions._();

  // Padding & Margin
  static double get paddingXS  => 4.w;
  static double get paddingS   => 8.w;
  static double get paddingM   => 16.w;
  static double get paddingL   => 24.w;
  static double get paddingXL  => 32.w;
  static double get paddingXXL => 48.w;

  // Border Radius
  static double get radiusS    => 8.r;
  static double get radiusM    => 12.r;
  static double get radiusL    => 16.r;
  static double get radiusXL   => 24.r;
  static double get radiusXXL  => 32.r;

  // Icon Sizes
  static double get iconS      => 16.w;
  static double get iconM      => 24.w;
  static double get iconL      => 32.w;
  static double get iconXL     => 48.w;

  // Font Sizes
  static double get fontXS     => 10.sp;
  static double get fontS      => 12.sp;
  static double get fontM      => 14.sp;
  static double get fontL      => 16.sp;
  static double get fontXL     => 20.sp;
  static double get fontXXL    => 24.sp;
  static double get fontDisplay => 32.sp;

  // Card & Widget Heights
  static double get cardHeight      => 80.h;
  static double get bannerHeight    => 160.h;
  static double get bottomNavHeight => 65.h;
  static double get appBarHeight    => 60.h;
}