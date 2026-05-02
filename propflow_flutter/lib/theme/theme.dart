import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Rolls-Royce / private estate–inspired palette built from the wireframe gradients
/// (cool trust + regal accent) and tuned for dark, high-contrast luxury UI.
abstract final class AppColors {
  static const voidBlack = Color(0xFF07080C);
  static const midnight = Color(0xFF0C0F14);
  static const graphite = Color(0xFF141A22);
  static const slate = Color(0xFF1E2734);
  static const mist = Color(0xFF8B96AA);

  /// Champagne gold — metallic accent (not yellow toy gold).
  static const champagne = Color(0xFFD4BC7E);
  static const champagneDeep = Color(0xFFB89B54);

  static const frost = Color(0xFFEEF2F8);
  static const pearl = Color(0xFFF7F5F0);

  /// Wireframe blue → cyan gradient endpoints.
  static const mgmtBlue = Color(0xFF1D4ED8);
  static const mgmtCyan = Color(0xFF38BDF8);

  /// Wireframe violet → rose gradient endpoints.
  static const maintViolet = Color(0xFF7C3AED);
  static const maintRose = Color(0xFFEC4899);
}

abstract final class AppGradients {
  static const management = LinearGradient(
    colors: [AppColors.mgmtBlue, AppColors.mgmtCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const maintenance = LinearGradient(
    colors: [AppColors.maintViolet, AppColors.maintRose],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Ambient studio backdrop behind hero typography.
  static const studioBackdrop = LinearGradient(
    colors: [
      Color(0xFF0A0C11),
      Color(0xFF121722),
      Color(0xFF141C28),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.45, 1.0],
  );

  /// Soft vignette used behind dashboard panels.
  static const panelShimmer = LinearGradient(
    colors: [
      Color(0x11FFFFFF),
      Color(0x00FFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// Central place for text + component theming. Single dark “atelier” mode.
abstract final class AppTheme {
  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.champagne,
      onPrimary: AppColors.voidBlack,
      secondary: AppColors.mgmtCyan,
      surface: AppColors.graphite,
      onSurface: AppColors.pearl,
      error: const Color(0xFFFF6B6B),
    );

    final textTheme = TextTheme(
      displayLarge: GoogleFonts.cormorantGaramond(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 1.05,
        letterSpacing: -0.6,
        color: AppColors.pearl,
      ),
      headlineMedium: GoogleFonts.cormorantGaramond(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        color: AppColors.pearl,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        color: AppColors.pearl,
      ),
      titleMedium: GoogleFonts.outfit(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.pearl,
      ),
      bodyLarge: GoogleFonts.outfit(
        fontSize: 16,
        height: 1.55,
        color: AppColors.mist,
      ),
      bodyMedium: GoogleFonts.outfit(
        fontSize: 14,
        height: 1.45,
        color: AppColors.mist,
      ),
      labelLarge: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
        color: AppColors.pearl,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.midnight,
      textTheme: textTheme,
      dividerColor: Colors.white.withOpacity(0.08),
      splashFactory: InkSparkle.splashFactory,
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Colors.white.withOpacity(0.08),
        backgroundColor: AppColors.graphite.withOpacity(0.94),
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: 0.2,
            color: selected ? AppColors.pearl : AppColors.mist,
          );
        }),
      ),
    );
  }
}
