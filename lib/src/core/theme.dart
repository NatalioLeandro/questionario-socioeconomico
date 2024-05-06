import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF004643);
  static Color secondary = const Color(0xFF004643).withOpacity(0.6);
  static const Color error = Color(0xFFD32F2F);
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onError = Colors.white;
  static const Color foregroundColor = Colors.black;
  static const Color scaffoldBackgroundColor = Color(0xFFEFF0F3);
}

ThemeData theme = ThemeData(
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.error,
    onPrimary: AppColors.onPrimary,
    onSecondary: AppColors.onSecondary,
    onError: AppColors.onError,
    background: AppColors.scaffoldBackgroundColor,
  ),
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(AppColors.primary),
      splashRadius: 50),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.foregroundColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: GoogleFonts.baloo2(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        foregroundColor: Colors.white),
  ),
);
