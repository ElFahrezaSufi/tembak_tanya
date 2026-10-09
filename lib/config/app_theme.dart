import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Definisi tema terang & gelap TembakTanya.
class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Inter';

  static ThemeData get lightTheme => _build(AppPalette.light, Brightness.light);

  static ThemeData get darkTheme => _build(AppPalette.dark, Brightness.dark);

  static ThemeData _build(AppPalette p, Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: p.primary,
      brightness: brightness,
    ).copyWith(
      primary: p.primary,
      onPrimary: p.onPrimary,
      surface: p.card,
      onSurface: p.ink,
      error: p.error,
      outline: p.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: fontFamily,
      colorScheme: scheme,
      scaffoldBackgroundColor: p.bg,
      canvasColor: p.bg,
      dividerColor: p.border,
      extensions: [p],
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: p.primary,
        selectionColor: p.primary.withValues(alpha: 0.25),
        selectionHandleColor: p.primary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.card,
        modalBackgroundColor: p.card,
        surfaceTintColor: Colors.transparent,
        modalBarrierColor: Colors.black.withValues(alpha: 0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.ink,
        contentTextStyle: TextStyle(
          fontFamily: fontFamily,
          color: p.bg,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
