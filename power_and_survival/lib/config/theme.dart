import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFF0D1117);
  static const Color accent = Color(0xFFC9A84C);
  static const Color danger = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFB8C00);
  static const Color textPrimary = Color(0xFFE8EAF0);
  static const Color textSecondary = Color(0xFF78909C);
  static const Color cardBackground = Color(0xFF161B22);
  static const Color cardBorder = Color(0xFF30363D);

  static TextStyle headerStyle({double size = 20, FontWeight weight = FontWeight.w700}) {
    return GoogleFonts.rajdhani(fontSize: size, fontWeight: weight, color: textPrimary);
  }

  static TextStyle bodyStyle({double size = 14, FontWeight weight = FontWeight.w400, Color? color}) {
    return GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color ?? textPrimary);
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: accent,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: cardBackground,
        error: danger,
      ),
      textTheme: GoogleFonts.interTextTheme(
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
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.rajdhani(
          fontSize: 20, fontWeight: FontWeight.w700, color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: cardBorder),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          side: const BorderSide(color: accent),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.rajdhani(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: cardBorder),
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
        inactiveTrackColor: cardBorder,
        thumbColor: accent,
        overlayColor: Color(0x29C9A84C),
      ),
      dividerColor: cardBorder,
      iconTheme: const IconThemeData(color: textSecondary),
    );
  }

  static Color getStatColor(double value) {
    if (value >= 65) return success;
    if (value >= 35) return warning;
    return danger;
  }

  static Color getRiskColor(double value) {
    if (value >= 65) return danger;
    if (value >= 35) return warning;
    return success;
  }

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: cardBackground,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: cardBorder),
  );
}
