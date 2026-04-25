import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.maroon,
        primary: AppColors.maroon,
        secondary: AppColors.gold,
        surface: AppColors.cream,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.cream,
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.w800,
          color: AppColors.maroon,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontWeight: FontWeight.w700,
          color: AppColors.maroon,
        ),
        titleLarge: GoogleFonts.outfit(
          fontWeight: FontWeight.w700,
          color: AppColors.onSurface,
        ),
        bodyLarge: GoogleFonts.outfit(
          color: AppColors.onSurface,
        ),
        bodyMedium: GoogleFonts.outfit(
          color: AppColors.onSurface.withOpacity(0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.maroon,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.maroon,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
