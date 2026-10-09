import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_icon.dart';

enum AppButtonVariant { primary, secondary, tonal, text }

/// Tombol reusable: primary (indigo), secondary (outline), tonal (tint), text.
///
/// [dimmed] membuat tampilan tombol terlihat nonaktif, tetapi `onPressed`
/// tetap dipanggil — dipakai untuk menampilkan validasi (mis. nama kosong).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.dimmed = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final String? icon;
  final AppButtonVariant variant;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final disabled = onPressed == null || dimmed;

    Color bg;
    Color fg;
    Color? border;
    switch (variant) {
      case AppButtonVariant.primary:
        bg = p.primary;
        fg = p.onPrimary;
      case AppButtonVariant.secondary:
        bg = p.card;
        fg = p.primary;
        border = p.border;
      case AppButtonVariant.tonal:
        bg = p.tint;
        fg = p.primary;
      case AppButtonVariant.text:
        bg = Colors.transparent;
        fg = p.primary;
    }
    if (disabled) {
      fg = p.disabledFg;
      if (variant != AppButtonVariant.text) {
        bg = p.disabledBg;
        border = null;
      }
    }

    final radius = BorderRadius.circular(16);
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: BoxConstraints(minHeight: context.rs(52)),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: border == null ? null : Border.all(color: border, width: 1.2),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.rs(16),
                vertical: context.rs(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    AppIcon(icon!, size: context.rs(18), color: fg),
                    SizedBox(width: context.rs(8)),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: fg,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
