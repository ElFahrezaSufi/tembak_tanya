import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import 'app_icon.dart';

/// Cincin skor 0–100 dengan angka di tengah dan lencana piala.
class ScoreRing extends StatelessWidget {
  const ScoreRing({super.key, required this.score, required this.size});

  final int score;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: score / 100),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _RingPainter(
                    progress: value,
                    track: p.border,
                    color: p.primary,
                    strokeWidth: size * 0.075,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(value * 100).round()}',
                      style: TextStyle(
                        color: p.ink,
                        fontSize: size * 0.3,
                        height: 1.05,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'dari 100',
                      style: TextStyle(color: p.muted, fontSize: size * 0.075),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: size * 0.01,
                bottom: size * 0.01,
                child: Container(
                  width: size * 0.26,
                  height: size * 0.26,
                  decoration: BoxDecoration(color: p.accent, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: AppIcon('trophy', size: size * 0.13, color: p.onAccent),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.track,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color track;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(strokeWidth / 2);
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(arcRect, 0, math.pi * 2, false, base..color = track);
    if (progress > 0) {
      canvas.drawArc(
        arcRect,
        -math.pi / 2,
        math.pi * 2 * progress,
        false,
        base..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color || old.track != track;
}
