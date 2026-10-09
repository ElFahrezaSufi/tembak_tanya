import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';

/// "Soal 3 dari 10 · 2/10 terjawab" + 10 segmen progres.
///
/// Segmen biru = sudah dijawab, kuning = soal yang sedang dibuka, abu = belum.
class QuizProgress extends StatelessWidget {
  const QuizProgress({
    super.key,
    required this.current,
    required this.answered,
  });

  /// Indeks soal aktif (basis 0).
  final int current;

  /// Status terjawab per soal.
  final List<bool> answered;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final total = answered.length;
    final done = answered.where((a) => a).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Soal ${current + 1} dari $total',
                style: TextStyle(
                  color: p.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '$done/$total terjawab',
              style: TextStyle(color: p.muted, fontSize: 13),
            ),
          ],
        ),
        SizedBox(height: context.rs(10)),
        Row(
          children: [
            for (var i = 0; i < total; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: context.rs(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: i == current
                        ? p.accent
                        : answered[i]
                            ? p.primary
                            : p.border,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
