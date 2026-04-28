import 'dart:ui';
import 'package:flutter/material.dart';

/// FuelPay Theme Extension - Advanced glassmorphism effects
extension FuelPayThemeExtension on ThemeData {
  /// Create glassmorphic blur effect
  static ImageFilter blurEffect({double blur = 10.0}) {
    return ImageFilter.blur(sigmaX: blur, sigmaY: blur);
  }

  /// Create gradient overlay
  static LinearGradient gradientOverlay({
    required Color startColor,
    required Color endColor,
  }) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [startColor.withOpacity(0.1), endColor.withOpacity(0.1)],
    );
  }
}

/// Premium dark fintech theme with glassmorphic design
class FuelPayTheme {
  // Private constructor
  FuelPayTheme._();

  // ============ COLOR PALETTE ============
  static const Color blackBackground = Color(0xFF000000);
  static const Color charcoalCard = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF0D0D0D);
  static const Color darkSurface2 = Color(0xFF151515);
  static const Color neonGreen = Color(0xFF00FF41);
  static const Color neonGreenLight = Color(0xFF00FF66);
  static const Color electricBlue = Color(0xFF0066FF);
  static const Color electricBlueDark = Color(0xFF0052CC);
  static const Color accentPurple = Color(0xFF9D00FF);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  static const Color successGreen = Color(0xFF00D084);
  static const Color errorRed = Color(0xFFFF4444);
  static const Color warningOrange = Color(0xFFFFB84D);
  static const Color transparentWhite = Color(0x1AFFFFFF);
  static const Color borderLight = Color(0xFF2A2A2A);
  static const Color borderDark = Color(0xFF0A0A0A);

  // ============ GRADIENTS ============
  static const LinearGradient neonGradient = LinearGradient(
    colors: [neonGreen, electricBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [charcoalCard, darkSurface],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [charcoalCard, darkSurface2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient tierGradient = LinearGradient(
    colors: [neonGreen, electricBlue, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ SHADOW ============
  static final List<BoxShadow> glassmorphicShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];

  static final List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: electricBlue.withOpacity(0.2),
      blurRadius: 24,
      spreadRadius: 0,
      offset: const Offset(0, 12),
    ),
  ];

  static final List<BoxShadow> neonShadow = [
    BoxShadow(
      color: neonGreen.withOpacity(0.3),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 0),
    ),
  ];

  // ============ THEME DATA ============
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: neonGreen,
      scaffoldBackgroundColor: blackBackground,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: charcoalCard,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        toolbarHeight: 64,
        surfaceTintColor: Colors.transparent,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: charcoalCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderLight, width: 0.5),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // Text Theme
      textTheme: const TextTheme(
        // Headings
        displayLarge: TextStyle(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
        displaySmall: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        // Titles
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        // Body
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          color: textTertiary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.4,
        ),
        // Labels
        labelLarge: TextStyle(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        labelMedium: TextStyle(
          color: textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
        labelSmall: TextStyle(
          color: textTertiary,
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: neonGreen,
          foregroundColor: blackBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: neonGreen,
          side: const BorderSide(color: neonGreen, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: neonGreen,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: charcoalCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: neonGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: errorRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        hintStyle: const TextStyle(color: textTertiary, fontSize: 14),
        labelStyle: const TextStyle(color: neonGreen),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
      ),

      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: neonGreen,
        secondary: electricBlue,
        tertiary: accentPurple,
        surface: charcoalCard,
        background: blackBackground,
        error: errorRed,
        onPrimary: blackBackground,
        onSecondary: blackBackground,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: Colors.white,
      ),

      // Divider Theme
      dividerColor: borderLight,
      dividerTheme: const DividerThemeData(
        color: borderLight,
        thickness: 0.5,
        space: 16,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: charcoalCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          side: BorderSide(color: borderLight, width: 0.5),
        ),
        surfaceTintColor: Colors.transparent,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: charcoalCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: borderLight, width: 0.5),
        ),
        titleTextStyle: const TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return neonGreen;
          }
          return charcoalCard;
        }),
        checkColor: MaterialStateProperty.all(blackBackground),
        side: const BorderSide(color: neonGreen, width: 2),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return neonGreen;
          }
          return textTertiary;
        }),
      ),
    );
  }
}
