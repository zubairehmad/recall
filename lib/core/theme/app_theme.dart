import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const primary = Color(0xFF171717);

  static const lightBackground = Color(0xFFF5F5F5);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceContainer = Color(0xFFEDEDED);
  static const lightText = Color(0xFF171717);
  static const lightSecondaryText = Color(0xFF737373);
  static const lightBorder = Color(0xFFE0E0E0);

  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkSurfaceContainer = Color(0xFF2A2A2A);
  static const darkText = Color(0xFFF5F5F5);
  static const darkSecondaryText = Color(0xFFA3A3A3);
  static const darkBorder = Color(0xFF383838);

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: primary,
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
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: lightBorder),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: lightSurface,
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: lightText),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: lightText),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: lightSurfaceContainer,
          disabledForegroundColor: lightSecondaryText,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(
          color: lightText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(lightSurface),
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
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: const CardThemeData(
        color: darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: darkBorder),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: darkSurface,
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: darkText),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(color: darkText),
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkText,
          foregroundColor: darkBackground,
          disabledBackgroundColor: darkSurfaceContainer,
          disabledForegroundColor: darkSecondaryText,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),
      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(
          color: darkText,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(darkSurface),
        ),
      ),
    );
  }
}
