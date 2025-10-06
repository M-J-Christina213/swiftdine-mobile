import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF6B35);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color headingColor = Color(0xFF000000);
  static const Color descriptionColor = Color(0xFF7D7D7D);
  static const Color accentColor = Color(0xFFFFD700);

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: backgroundColor,
      elevation: 0,
    ),
    textTheme: GoogleFonts.nunitoTextTheme().copyWith(
      titleLarge: const TextStyle(
          color: headingColor, fontWeight: FontWeight.bold, fontSize: 22),
      bodyMedium: const TextStyle(color: descriptionColor, fontSize: 14),
      labelLarge:
          const TextStyle(color: backgroundColor, fontWeight: FontWeight.w600),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
    cardColor: Colors.white,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme:
        GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme).copyWith(
      titleLarge: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
      bodyMedium: TextStyle(color: Colors.grey[400], fontSize: 14),
      labelLarge: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w600),
    ),
    colorScheme: ColorScheme.dark().copyWith(secondary: accentColor),
    cardColor: Colors.grey[850],
  );
}
