import 'package:flutter/material.dart';

class SafeWatchTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1F1F1F),

    // COLORS
    colorScheme: const ColorScheme.dark(
      primary: Colors.blueAccent,
      secondary: Colors.redAccent,
      surface: Color(0xFF2A2A2A),
    ),

    // TEXT
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),

    // BUTTONS
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),

    // INPUTS
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
      ),
      hintStyle: const TextStyle(color: Colors.white54),
    ),
  );
}
