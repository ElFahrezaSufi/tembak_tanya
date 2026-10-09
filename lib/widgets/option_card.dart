import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_icon.dart';

/// Kartu satu opsi jawaban: huruf A–D + label + radio/centang.
/// Tanpa penanda benar/salah (itu hanya muncul di halaman tinjau).
class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final radius = BorderRadius.circular(18);
    final chip = context.rs(34);

    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Opsi $letter, $text',
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected ? p.tint : p.card,
          borderRadius: radius,
          border: Border.all(
            color: isSelected ? p.primary : p.border,
            width: isSelected ? 2 : 1.2,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.rs(14),
                vertical: context.rs(16),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: chip,
                    height: chip,
                    decoration: BoxDecoration(
                      color: isSelected ? p.primary : p.bg,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? p.onPrimary : p.muted,
                      ),
                    ),
                  ),
                  SizedBox(width: context.rs(14)),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.3,
                        color: p.ink,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: context.rs(10)),
                  if (isSelected)
                    AppIcon('circle-check', size: context.rs(22), color: p.primary)
                  else
                    Container(
                      width: context.rs(22),
                      height: context.rs(22),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: p.border, width: 1.5),
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
