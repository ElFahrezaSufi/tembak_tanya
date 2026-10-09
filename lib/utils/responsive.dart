import 'package:flutter/widgets.dart';

/// Kelas ukuran layar yang dipakai untuk memilih layout adaptif.
///
/// * [compact]  : ponsel (potret)
/// * [medium]   : tablet / ponsel lanskap
/// * [expanded] : browser / desktop lebar
enum ScreenClass { compact, medium, expanded }

class Breakpoints {
  Breakpoints._();

  static const double medium = 700;
  static const double expanded = 1200;
}

extension ResponsiveContext on BuildContext {
  /// Kelas layar berdasarkan lebar jendela saat ini.
  ScreenClass get screenClass {
    final width = MediaQuery.sizeOf(this).width;
    if (width < Breakpoints.medium) return ScreenClass.compact;
    if (width < Breakpoints.expanded) return ScreenClass.medium;
    return ScreenClass.expanded;
  }

  /// Faktor skala untuk ponsel (lebar 400 dp = 1.0). Layout lebar memakai 1.0.
  double get uiScale {
    final width = MediaQuery.sizeOf(this).width;
    if (width >= Breakpoints.medium) return 1.0;
    return (width / 400).clamp(0.85, 1.25).toDouble();
  }

  /// "Responsive size": ubah nilai dasar menjadi nilai yang menyesuaikan layar.
  double rs(double value) => value * uiScale;
}
