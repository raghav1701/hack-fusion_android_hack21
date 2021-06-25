import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  // textTheme: ThemeData.light().textTheme.apply(
  //   fontFamily: GoogleFonts.montserrat().fontFamily,
  // ),
  // primaryTextTheme: ThemeData.light().textTheme.apply(
  //   fontFamily: GoogleFonts.montserrat().fontFamily,
  // ),
  // accentTextTheme: ThemeData.light().textTheme.apply(
  //   fontFamily: GoogleFonts.montserrat().fontFamily,
  // ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue.shade700,
    unselectedItemColor: Colors.grey.shade600,
    selectedLabelStyle: GoogleFonts.montserrat(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2
    ),
    unselectedLabelStyle: GoogleFonts.montserrat(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2
    ),
  ),

  dividerTheme: DividerThemeData(
    color: Colors.grey.shade600,
  ),

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);
