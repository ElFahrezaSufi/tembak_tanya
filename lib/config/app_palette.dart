import 'package:flutter/material.dart';

/// Palet warna TembakTanya. Nilai diambil dari mockup (indigo / citrus / gelap).
///
/// Disimpan sebagai [ThemeExtension] agar seluruh widget cukup memanggil
/// `context.palette` dan otomatis mengikuti mode terang/gelap.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.bg,
    required this.card,
    required this.border,
    required this.primary,
    required this.onPrimary,
    required this.tint,
    required this.ink,
    required this.muted,
    required this.accent,
    required this.accentSoft,
    required this.onAccent,
    required this.success,
    required this.successBg,
    required this.error,
    required this.errorBg,
    required this.disabledBg,
    required this.disabledFg,
  });

  final Color bg;
  final Color card;
  final Color border;
  final Color primary;
  final Color onPrimary;
  final Color tint;
  final Color ink;
  final Color muted;
  final Color accent;
  final Color accentSoft;
  final Color onAccent;
  final Color success;
  final Color successBg;
  final Color error;
  final Color errorBg;
  final Color disabledBg;
  final Color disabledFg;

  static const AppPalette light = AppPalette(
    bg: Color(0xFFF8F8FC),
    card: Color(0xFFFFFFFF),
    border: Color(0xFFE4E3EF),
    primary: Color(0xFF5750C6),
    onPrimary: Color(0xFFFFFFFF),
    tint: Color(0xFFEEEDFF),
    ink: Color(0xFF252440),
    muted: Color(0xFF77768F),
    accent: Color(0xFFF4C85B),
    accentSoft: Color(0xFFFFF4D3),
    onAccent: Color(0xFF252440),
    success: Color(0xFF1F7A4D),
    successBg: Color(0xFFE8F6EE),
    error: Color(0xFFB8344A),
    errorBg: Color(0xFFFFF0F1),
    disabledBg: Color(0xFFE3E2ED),
    disabledFg: Color(0xFF9A99AE),
  );

  static const AppPalette dark = AppPalette(
    bg: Color(0xFF171725),
    card: Color(0xFF222235),
    border: Color(0xFF3C3A53),
    primary: Color(0xFFB5AEFF),
    onPrimary: Color(0xFF171725),
    tint: Color(0xFF34314F),
    ink: Color(0xFFF2F1FF),
    muted: Color(0xFFA3A1BD),
    accent: Color(0xFFF4C85B),
    accentSoft: Color(0xFF3A3426),
    onAccent: Color(0xFF252440),
    success: Color(0xFF7FD8A4),
    successBg: Color(0xFF1F3A2C),
    error: Color(0xFFFF8FA0),
    errorBg: Color(0xFF3E2530),
    disabledBg: Color(0xFF2C2B40),
    disabledFg: Color(0xFF706E8C),
  );

  @override
  AppPalette copyWith({
    Color? bg,
    Color? card,
    Color? border,
    Color? primary,
    Color? onPrimary,
    Color? tint,
    Color? ink,
    Color? muted,
    Color? accent,
    Color? accentSoft,
    Color? onAccent,
    Color? success,
    Color? successBg,
    Color? error,
    Color? errorBg,
    Color? disabledBg,
    Color? disabledFg,
  }) {
    return AppPalette(
      bg: bg ?? this.bg,
      card: card ?? this.card,
      border: border ?? this.border,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      tint: tint ?? this.tint,
      ink: ink ?? this.ink,
      muted: muted ?? this.muted,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      successBg: successBg ?? this.successBg,
      error: error ?? this.error,
      errorBg: errorBg ?? this.errorBg,
      disabledBg: disabledBg ?? this.disabledBg,
      disabledFg: disabledFg ?? this.disabledFg,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      bg: mix(bg, other.bg),
      card: mix(card, other.card),
      border: mix(border, other.border),
      primary: mix(primary, other.primary),
      onPrimary: mix(onPrimary, other.onPrimary),
      tint: mix(tint, other.tint),
      ink: mix(ink, other.ink),
      muted: mix(muted, other.muted),
      accent: mix(accent, other.accent),
      accentSoft: mix(accentSoft, other.accentSoft),
      onAccent: mix(onAccent, other.onAccent),
      success: mix(success, other.success),
      successBg: mix(successBg, other.successBg),
      error: mix(error, other.error),
      errorBg: mix(errorBg, other.errorBg),
      disabledBg: mix(disabledBg, other.disabledBg),
      disabledFg: mix(disabledFg, other.disabledFg),
    );
  }
}

/// Akses cepat: `context.palette.primary`.
extension PaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
