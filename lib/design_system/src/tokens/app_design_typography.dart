import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/app_fonts.dart';

class AppDesignTypography {
  AppDesignTypography({this.fontFamily = AppFonts.appFontFamily});

  final String fontFamily;

  TextStyle get display => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.15,
  );

  TextStyle get headline => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  TextStyle get title => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  TextStyle get subtitle => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  TextStyle get body => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  TextStyle get caption => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.35,
  );

  TextStyle get button => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  TextTheme toTextTheme(Color color) {
    return TextTheme(
      displayLarge: display.copyWith(color: color),
      headlineMedium: headline.copyWith(color: color),
      titleLarge: title.copyWith(color: color),
      titleMedium: subtitle.copyWith(color: color),
      bodyLarge: body.copyWith(fontSize: 16.sp, color: color),
      bodyMedium: body.copyWith(color: color),
      bodySmall: caption.copyWith(color: color),
      labelLarge: button.copyWith(color: color),
      labelMedium: caption.copyWith(fontWeight: FontWeight.w600, color: color),
      labelSmall: caption.copyWith(color: color),
    );
  }
}
