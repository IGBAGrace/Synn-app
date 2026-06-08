import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Couleurs officielles Synneo
  static const Color blue = Color(0xFF035979);
  static const Color blueDark = Color(0xFF024560);
  static const Color blueMid = Color(0xFF1A6B8A);
  static const Color teal = Color(0xFF49D6BB);
  static const Color tealLight = Color(0xFFE8FAF6);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyBg = Color(0xFFF4F6F8);
  static const Color greyLight = Color(0xFFEEF1F4);
  static const Color greyBorder = Color(0xFFDDE3E8);
  static const Color greyText = Color(0xFF6B7A8D);
  static const Color dark = Color(0xFF1A2733);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.blue,
        secondary: AppColors.teal,
        surface: AppColors.white,
        background: AppColors.white,
      ),
      textTheme: GoogleFonts.nunitoSansTextTheme().copyWith(
        displayLarge: GoogleFonts.nunito(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: AppColors.blue,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: AppColors.blue,
        ),
        displaySmall: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.blue,
        ),
        bodyLarge: GoogleFonts.nunitoSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.dark,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.nunitoSans(
          fontSize: 13,
          color: AppColors.greyText,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.nunitoSans(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.greyBorder,
        iconTheme: const IconThemeData(color: AppColors.blue),
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: AppColors.blue,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: AppColors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: GoogleFonts.nunitoSans(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue,
          side: const BorderSide(color: AppColors.blue, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.greyText,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.greyBorder, width: 1.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.greyBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.blue, width: 2),
        ),
        labelStyle: GoogleFonts.nunitoSans(
          color: AppColors.greyText,
          fontSize: 14,
        ),
      ),
    );
  }
}
