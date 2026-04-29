import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryDark = Color(0xFF1A1A2E);
  static const Color primaryMid = Color(0xFF16213E);
  static const Color primaryLight = Color(0xFF0F3460);
  static const Color accent = Color(0xFFE94560);
  static const Color gold = Color(0xFFFFD700);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color danger = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  static const Color textPrimary = Color(0xFFEEEEEE);
  static const Color textSecondary = Color(0xFFAAAAAA);
  static const Color cardBackground = Color(0xFF1E2A3A);
  static const Color surfaceColor = Color(0xFF0D1B2A);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryLight,
        secondary: accent,
        surface: cardBackground,
        error: danger,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: textPrimary, fontSize: 28, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: textPrimary, fontSize: 24, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: textPrimary, fontSize: 20, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
          bodySmall: TextStyle(color: textSecondary, fontSize: 12),
          labelLarge: TextStyle(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryMid,
        foregroundColor: textPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLight,
          foregroundColor: textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textSecondary),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: accent,
        inactiveTrackColor: primaryMid,
        thumbColor: accent,
        overlayColor: Color(0x29E94560),
      ),
      dividerColor: primaryLight,
      iconTheme: const IconThemeData(color: textSecondary),
    );
  }

  static Color getStatColor(double value) {
    if (value >= 70) return success;
    if (value >= 40) return warning;
    return danger;
  }

  static Color getRiskColor(double value) {
    if (value >= 70) return danger;
    if (value >= 40) return warning;
    return success;
  }
}
