import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFF429690);
  static const Color primaryDark = Color(0xFF2A7C76);
  static const Color primaryLight = Color(0xFFE5F1F1);
  
  // Status Colors
  static const Color income = Color(0xFF25A969);
  static const Color expense = Color(0xFFF95B51);
  static const Color warning = Color(0xFFF5A623);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFF4F6F6);
  static const Color surface = Colors.white;
  static const Color cardShadow = Color(0x14000000);

  // Text Colors
  static const Color textDark = Color(0xFF222222);
  static const Color textGrey = Color(0xFF666666);
  static const Color textLight = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: primaryDark,
        surface: surface,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold, color: textDark),
        displayMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: textDark),
        bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: textDark),
        bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: textGrey),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(color: textDark, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
