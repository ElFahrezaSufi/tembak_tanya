import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import 'app_icon.dart';
import 'app_logo_badge.dart';

/// Ilustrasi sambutan: ikon target TembakTanya + chip kode + percikan.
/// Seluruh posisi dihitung dari [size] sehingga ikut menyesuaikan layar.
class HeroIllustration extends StatelessWidget {
  const HeroIllustration({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.84,
            height: size * 0.84,
            decoration: BoxDecoration(color: p.tint, shape: BoxShape.circle),
          ),
          Transform.rotate(
            angle: 6 * math.pi / 180,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * 0.14),
                boxShadow: [
                  BoxShadow(
                    color: p.primary.withValues(alpha: 0.25),
                    blurRadius: size * 0.1,
                    offset: Offset(0, size * 0.05),
                  ),
                ],
              ),
              child: AppLogoBadge(size: size * 0.58),
            ),
          ),
          // Chip kode kuning
          Positioned(
            right: size * 0.06,
            bottom: size * 0.1,
            child: Transform.rotate(
              angle: -4 * math.pi / 180,
              child: Container(
                width: size * 0.34,
                height: size * 0.26,
                decoration: BoxDecoration(
                  color: p.accent,
                  borderRadius: BorderRadius.circular(size * 0.07),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: size * 0.06,
                      offset: Offset(0, size * 0.03),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  '</>',
                  style: TextStyle(
                    color: p.onAccent,
                    fontSize: size * 0.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          // Percikan
          Positioned(
            right: size * 0.02,
            top: size * 0.3,
            child: AppIcon('sparkles', size: size * 0.15, color: p.accent),
          ),
          // Titik kuning
          Positioned(
            left: size * 0.06,
            bottom: size * 0.3,
            child: Container(
              width: size * 0.05,
              height: size * 0.05,
              decoration: BoxDecoration(color: p.accent, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
