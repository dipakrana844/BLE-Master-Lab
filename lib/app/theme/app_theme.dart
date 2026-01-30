import 'package:flutter/material.dart';

class AppTheme {
  // Custom color palette from design
  static const Color primary = Color(0xFF06F9F9);
  static const Color backgroundLight = Color(0xFFF5F8F8);
  static const Color backgroundDark = Color(0xFF0A0A14);
  static const Color cardDark = Color(0xFF161B2E);
  static const Color textColorLight = Color(0xFF000000);
  static const Color textColorDark = Color(0xFFFFFFFF);
  static const Color secondaryTextLight = Color(0xFF808080);
  static const Color secondaryTextDark = Color(0xFF8ECCCC);
  
  // Spacing system
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;
  
  // Border radius
  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusFull = 9999;
  
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primary,
      onPrimary: backgroundDark,
      surface: backgroundLight,
      onSurface: textColorLight,
      outline: Color(0xFFE0E0E0),
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundLight,
      foregroundColor: textColorLight,
      titleTextStyle: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 32,
        height: 1.2,
        color: textColorLight,
      ),
      headlineMedium: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: textColorLight,
      ),
      titleLarge: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: textColorLight,
      ),
      titleMedium: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: textColorLight,
      ),
      bodyLarge: TextStyle(
    
        fontSize: 16,
        color: textColorLight,
      ),
      bodyMedium: TextStyle(
    
        fontSize: 14,
        color: textColorLight,
      ),
      labelLarge: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: 1.2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: backgroundDark,
        textStyle: const TextStyle(
      
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
      
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        side: const BorderSide(color: primary, width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      onPrimary: backgroundDark,
      surface: backgroundDark,
      onSurface: textColorDark,
      outline: Color(0xFF33334D),
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundDark,
      foregroundColor: textColorDark,
      titleTextStyle: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 32,
        height: 1.2,
        color: textColorDark,
      ),
      headlineMedium: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: textColorDark,
      ),
      titleLarge: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: textColorDark,
      ),
      titleMedium: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: textColorDark,
      ),
      bodyLarge: TextStyle(
    
        fontSize: 16,
        color: textColorDark,
      ),
      bodyMedium: TextStyle(
    
        fontSize: 14,
        color: textColorDark,
      ),
      labelLarge: TextStyle(
    
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: 1.2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: backgroundDark,
        textStyle: const TextStyle(
      
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        textStyle: const TextStyle(
      
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
        side: const BorderSide(color: primary, width: 1),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    ),
    cardTheme: const CardThemeData(
      color: cardDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radiusLg)),
      ),
    ),
  );
}