import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The main theme class for the Modern Flutter UI Kit
class ModernTheme extends InheritedWidget {
  /// The theme data for the Modern Flutter UI Kit
  final ModernThemeData data;

  /// Creates a ModernTheme
  const ModernTheme({super.key, required this.data, required super.child});

  /// Returns the nearest ModernThemeData in the widget tree
  static ModernThemeData of(BuildContext context) {
    final ModernTheme? theme =
        context.dependOnInheritedWidgetOfExactType<ModernTheme>();
    return theme?.data ?? ModernThemeData.light();
  }

  @override
  bool updateShouldNotify(ModernTheme oldWidget) => data != oldWidget.data;
}

/// The theme data for the Modern Flutter UI Kit
class ModernThemeData {
  /// The color scheme for the theme
  final ColorScheme colorScheme;

  /// The text theme for the theme
  final TextTheme textTheme;

  /// Creates a ModernThemeData
  const ModernThemeData({required this.colorScheme, required this.textTheme});

  /// Creates a light theme
  factory ModernThemeData.light() {
    return ModernThemeData(
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.amber,
        surface: Colors.white,
        error: Colors.red,
      ),
      textTheme: Typography.material2018().black,
    );
  }

  /// Creates a dark theme
  factory ModernThemeData.dark() {
    return ModernThemeData(
      colorScheme: ColorScheme.dark(
        primary: Colors.blue[300]!,
        secondary: Colors.amber[300]!,
        surface: Colors.grey[900]!,
        error: Colors.red[300]!,
      ),
      textTheme: Typography.material2018().white,
    );
  }
}

class AppTheme {
  static const _primaryColor = Color(0xFF6200EE);
  static const _secondaryColor = Color(0xFF03DAC6);
  static const _surfaceColor = Color(0xFFFFFFFF);
  static const _errorColor = Color(0xFFB00020);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: _surfaceColor,
      error: _errorColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: Color(0xFF1E1E1E),
      error: _errorColor,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primaryColor,
        side: const BorderSide(color: _primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
