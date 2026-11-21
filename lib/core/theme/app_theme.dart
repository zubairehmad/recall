import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const primary = Color(0xFF171717);

  static const lightBackground = Color(0xFFFAFAFA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceContainer = Color(0xFFF2F2F2);
  static const lightText = Color(0xFF171717);
  static const lightSecondaryText = Color(0xFF737373);
  static const lightBorder = Color(0xFFE5E5E5);

  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1C1C1C);
  static const darkSurfaceContainer = Color(0xFF262626);
  static const darkText = Color(0xFFF5F5F5);
  static const darkSecondaryText = Color(0xFFA3A3A3);
  static const darkBorder = Color(0xFF333333);

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF171717),
      onPrimary: Colors.white,
      secondary: Color(0xFF525252),
      onSecondary: Colors.white,
      surface: lightSurface,
      onSurface: lightText,
      error: Color(0xFFDC2626),
      outline: lightBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: lightBackground,
      dividerColor: lightBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        foregroundColor: lightText,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: lightBorder),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFFF5F5F5),
      onPrimary: Color(0xFF171717),
      secondary: Color(0xFFA3A3A3),
      onSecondary: Color(0xFF171717),
      surface: darkSurface,
      onSurface: darkText,
      error: Color(0xFFF87171),
      outline: darkBorder,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: darkBackground,
      dividerColor: darkBorder,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: darkBorder),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: darkText, width: 1.5),
        ),
      ),
    );
  }
}
