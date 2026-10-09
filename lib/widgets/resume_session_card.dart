import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';

/// Kartu "Lanjutkan sesi `nama` →" di halaman sambutan.
class ResumeSessionCard extends StatelessWidget {
  const ResumeSessionCard({
    super.key,
    required this.name,
    required this.answered,
    required this.total,
    required this.onTap,
  });

  final String name;
  final int answered;
  final int total;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final radius = BorderRadius.circular(18);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: p.tint, borderRadius: radius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.rs(14),
              horizontal: context.rs(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lanjutkan sesi $name →',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: p.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$answered/$total terjawab · sesi masih terbuka',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: p.muted, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
