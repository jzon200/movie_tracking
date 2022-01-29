import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const grey = Color(0xFF6D6E70);
  static const greenAccent = Color(0xFFB9C95A);
  static TextTheme darkTextTheme = TextTheme(
    // Rating
    headline1: GoogleFonts.rubik(
      fontSize: 32.0,
      fontWeight: FontWeight.w900,
      color: Colors.white,
    ),
    // Title
    headline2: GoogleFonts.chivo(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Section Header
    headline3: GoogleFonts.chivo(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Navigation Text
    headline4: GoogleFonts.chivo(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    headline5: GoogleFonts.chivo(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Movie Info
    bodyText1: GoogleFonts.chivo(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    // Body Text
    bodyText2: GoogleFonts.chivo(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    button: GoogleFonts.rubik(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    subtitle1: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF727272),
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: grey,
      ),
      textTheme: darkTextTheme,
    );
  }
}
