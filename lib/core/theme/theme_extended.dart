import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      colors: [
        startColor.withValues(alpha: 0.1),
        endColor.withValues(alpha: 0.1)
      ],
    );
  }
}

/// Premium dark fintech theme with glassmorphic design
class FuelPayTheme {
  // Private constructor
  FuelPayTheme._();

  // ============ COLOR PALETTE ============
  static const Color pageBackground = Color(0xFF0B1220);
  static const Color surface = Color(0xFF111A2C);
  static const Color surfaceAlt = Color(0xFF162033);
  static const Color elevatedSurface = Color(0xFF1A2740);
  static const Color accent = Color(0xFF4DA3FF);
  static const Color accentSoft = Color(0xFF7CC4FF);
  static const Color accentWarm = Color(0xFFF2B36F);
  static const Color textPrimary = Color(0xFFF7FAFC);
  static const Color textSecondary = Color(0xFFB5C2D6);
  static const Color textTertiary = Color(0xFF7E8CA4);
  static const Color successGreen = Color(0xFF2FBF71);
  static const Color errorRed = Color(0xFFE86A6A);
  static const Color warningOrange = Color(0xFFF0B35A);
  static const Color transparentWhite = Color(0x12FFFFFF);
  static const Color borderLight = Color(0xFF26324A);
  static const Color borderDark = Color(0xFF121A29);
  static const Color blackBackground = pageBackground;
  static const Color charcoalCard = surface;
  static const Color darkSurface = surfaceAlt;
  static const Color darkSurface2 = elevatedSurface;
  static const Color neonGreen = accent;
  static const Color neonGreenLight = accentSoft;
  static const Color electricBlue = accent;
  static const Color electricBlueDark = Color(0xFF2E79D4);
  static const Color accentPurple = Color(0xFF7C8DB5);

  // ============ GRADIENTS ============
  static const LinearGradient neonGradient = LinearGradient(
    colors: [accent, accentSoft],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [surface, surfaceAlt],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [surface, elevatedSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient tierGradient = LinearGradient(
    colors: [accent, accentSoft, accentWarm],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ SHADOW ============
  static final List<BoxShadow> glassmorphicShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 8),
    ),
  ];

  static final List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: electricBlue.withValues(alpha: 0.2),
      blurRadius: 24,
      spreadRadius: 0,
      offset: const Offset(0, 12),
    ),
  ];

  static final List<BoxShadow> neonShadow = [
    BoxShadow(
      color: neonGreen.withValues(alpha: 0.3),
      blurRadius: 20,
      spreadRadius: 0,
      offset: const Offset(0, 0),
    ),
  ];

  // ============ THEME DATA ============
  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme.dark(
      primary: accent,
      secondary: accentSoft,
      tertiary: accentWarm,
      surface: surface,
      error: errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: accent,
      scaffoldBackgroundColor: pageBackground,
      canvasColor: pageBackground,
      splashColor: accent.withValues(alpha: 0.12),
      highlightColor: accentSoft.withValues(alpha: 0.08),
      visualDensity: VisualDensity.adaptivePlatformDensity,

      fontFamily: GoogleFonts.inter().fontFamily,

      iconTheme: const IconThemeData(color: textPrimary, size: 22),
      primaryIconTheme: const IconThemeData(color: accent, size: 22),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
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
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
          backgroundColor: accent,
          foregroundColor: Colors.white,
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
          foregroundColor: accent,
          side: const BorderSide(color: accent, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
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
          borderSide: const BorderSide(color: accent, width: 2),
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
        labelStyle: const TextStyle(color: accent),
        prefixIconColor: textSecondary,
        suffixIconColor: textSecondary,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface.withValues(alpha: 0.96),
        indicatorColor: accent.withValues(alpha: 0.14),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color:
                states.contains(WidgetState.selected) ? accent : textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          return IconThemeData(
            color:
                states.contains(WidgetState.selected) ? accent : textSecondary,
            size: 22,
          );
        }),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: surface,
        disabledColor: darkSurface,
        selectedColor: accent.withValues(alpha: 0.14),
        secondarySelectedColor: accentSoft.withValues(alpha: 0.14),
        labelStyle: const TextStyle(color: textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side: const BorderSide(color: borderLight, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: darkSurface2,
        circularTrackColor: darkSurface2,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected) ? accent : textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? accent.withValues(alpha: 0.25)
              : borderLight;
        }),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle: const TextStyle(color: textPrimary),
        actionTextColor: accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return accent;
          }
          return surface;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(color: accent, width: 2),
      ),

      // Radio Theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return accent;
          }
          return textTertiary;
        }),
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
