// config/theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),


    colorScheme: const ColorScheme.light(
      primary: Color(0xFF009688), // Vibrant teal primary color
      onPrimary: Colors.white, // White text on primary color
      secondary: Color(0xFF8E24AA), // Deep purple secondary color
      onSecondary: Colors.white, // White text on secondary color
      surface: Color(0xFFFFFFFF), // White background color for surfaces
      onSurface: Colors.black87, // Dark text on light surfaces
      error: Color(0xFFD32F2F), // Red for error messages
      onSurfaceVariant: Color(0xffeaeff5), // اضافه کردن یک رنگ کم‌رنگ 
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF009688), // Teal AppBar color
      iconTheme: IconThemeData(color: Colors.white), // White icons in AppBar
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.grey,
      labelColor: Color(0xFF009688),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Color(0xFF009688),
          width: 1.5,
        ),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      iconColor: Colors.grey,
      prefixIconColor: Colors.grey
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF009688),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      splashRadius: 20.0,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.tealAccent; // رنگ فعال
        }
        return Colors.grey; // رنگ غیرفعال
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.teal.withOpacity(0.5); // رنگ فعال
        }
        return Colors.grey.withOpacity(0.3); // رنگ غیرفعال
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),
    textTheme:GoogleFonts.poppinsTextTheme(
       const TextTheme(
      
      displayLarge: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.black87),
      titleLarge: TextStyle(fontSize: 22.0, fontStyle: FontStyle.normal, color: Colors.black87),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black87,),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 16.0)
    ),
    ),
    
  );

  static final ThemeData darkTheme = ThemeData(
    // fontFamily: 'Vazir',
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7C4DFF), // Bright purple primary color
      onPrimary: Colors.black, // Black text on primary color
      secondary: Color(0xFF03A9F4), // Light blue secondary color
      onSecondary: Colors.black, // Black text on secondary color
      surface: Color(0xFF1E1E1E), // Dark surface color
      onSurface: Colors.white, // White text on dark surfaces
      error: Color(0xFFCF6679), // Pink for error messages
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Colors.grey,
      labelColor: Color(0xFF7C4DFF),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Color(0xFF7C4DFF),
          width: 1.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF7C4DFF),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
       const TextTheme(
      displayLarge: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(fontSize: 22.0, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16.0, color: Colors.white70, ),
      bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white60, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 16.0)
    ),
    )
  );
}
