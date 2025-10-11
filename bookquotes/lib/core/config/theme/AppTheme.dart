import 'package:bookquotes/core/config/theme/AppColor.dart';
import 'package:flutter/material.dart';
// 1. Import the google_fonts package
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final _playfairTextTheme = GoogleFonts.playfairDisplayTextTheme();

  static final LightTheme = ThemeData(
    primaryColor: AppColor.primary1,
    scaffoldBackgroundColor: AppColor.primary1,

    textTheme: _playfairTextTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

        textStyle: _playfairTextTheme.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    brightness: Brightness.light,
  );

  static final DarkTheme = ThemeData(
    primaryColor: AppColor.primary2,
    scaffoldBackgroundColor: AppColor.primary2,

    textTheme: _playfairTextTheme,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        textStyle: _playfairTextTheme.labelLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    brightness: Brightness.dark,
  );
}
