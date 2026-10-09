import 'package:flutter/material.dart';

/// Menyimpan pilihan tema (terang/gelap). Default mengikuti sistem.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  /// Balik tema berdasarkan kecerahan yang sedang tampil.
  void toggle(Brightness current) {
    _mode = current == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
