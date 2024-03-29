import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class AppTheme {
  static TextTheme darkTextTheme = TextTheme(
    // Rating
    headline1: GoogleFonts.rubik(
      fontSize: 28.0,
      fontWeight: FontWeight.w900,
      color: Colors.white,
      letterSpacing: 2.0,
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
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
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
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    subtitle1: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: gray,
    ),
  );

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: m3IndicatorColor,
        backgroundColor: m3NavBarColor,
        labelTextStyle: MaterialStateProperty.all(darkTextTheme.headline4),
        iconTheme: MaterialStateProperty.all(
          const IconThemeData(color: m3NavBarOnPrimary),
        ),
      ),
      textTheme: darkTextTheme,
    );
  }
}
