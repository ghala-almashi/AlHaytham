import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// خطوط التطبيق: Readex Pro للعناوين، Tajawal للنصوص.
class AppText {
  AppText._();

  static TextStyle heading(
    double size, {
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.ink,
    double height = 1.35,
  }) => GoogleFonts.readexPro(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );

  static TextStyle body(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.inkSoft,
    double height = 1.6,
  }) => GoogleFonts.tajawal(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );
  static TextStyle button(
    double size, {
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.ink,
  }) =>
      const TextStyle(fontFamily: 'TheYearofHandicrafts')
          .copyWith(fontSize: size, fontWeight: weight, color: color);
}

class AppTheme {
  AppTheme._();

  static OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );

  static ThemeData get light {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.coral,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.coral,
          onPrimary: Colors.white,
          secondary: AppColors.aqua,
          onSecondary: AppColors.ink,
          surface: Colors.white,
          onSurface: AppColors.ink,
          outline: AppColors.clay,
          error: AppColors.danger,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.blush,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'TheYearofHandicrafts',
        bodyColor: AppColors.ink,
        displayColor: AppColors.ink,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: AppText.body(14, color: AppColors.clay),
        errorStyle: AppText.body(12, color: AppColors.danger),
        border: _border(AppColors.clay.withValues(alpha: 0.45)),
        enabledBorder: _border(AppColors.clay.withValues(alpha: 0.45)),
        focusedBorder: _border(AppColors.coral, 1.6),
        errorBorder: _border(AppColors.danger),
        focusedErrorBorder: _border(AppColors.danger, 1.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coral,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.clay,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: AppText.button(16, color: Colors.white),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.coral,
          textStyle: AppText.body(14, weight: FontWeight.w700),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.coral
              : Colors.white,
        ),
        side: BorderSide(
          color: AppColors.clay.withValues(alpha: 0.8),
          width: 1.4,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}
