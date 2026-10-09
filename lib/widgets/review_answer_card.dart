import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../models/question_model.dart';
import '../utils/responsive.dart';
import 'app_card.dart';
import 'app_icon.dart';

/// Kartu pembahasan satu soal di halaman "Tinjau jawaban".
class ReviewAnswerCard extends StatelessWidget {
  const ReviewAnswerCard({
    super.key,
    required this.number,
    required this.question,
    required this.selectedIndex,
  });

  /// Nomor soal (basis 1).
  final int number;
  final Question question;
  final int? selectedIndex;

  bool get _isCorrect => selectedIndex == question.correctOptionIndex;

  String _label(int? index) => index == null
      ? 'Tidak dijawab'
      : '${Question.letterOf(index)} · ${question.options[index]}';

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      padding: EdgeInsets.all(context.rs(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'SOAL $number',
                  style: TextStyle(
                    color: p.muted,
                    fontSize: 13,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _StatusPill(correct: _isCorrect),
            ],
          ),
          SizedBox(height: context.rs(14)),
          Text(
            question.text,
            style: TextStyle(
              color: p.ink,
              fontSize: 19,
              height: 1.3,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: context.rs(16)),
          _AnswerBlock(
            caption: _isCorrect ? 'PILIHANMU · BENAR' : 'PILIHANMU · SALAH',
            value: _label(selectedIndex),
            correct: _isCorrect,
          ),
          if (!_isCorrect) ...[
            SizedBox(height: context.rs(10)),
            _AnswerBlock(
              caption: 'JAWABAN YANG BENAR',
              value: _label(question.correctOptionIndex),
              correct: true,
            ),
          ],
          SizedBox(height: context.rs(16)),
          Text(
            'Kenapa begitu?',
            style: TextStyle(
              color: p.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.rs(6)),
          Text(
            question.explanation,
            style: TextStyle(color: p.muted, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.correct});

  final bool correct;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = correct ? p.success : p.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: correct ? p.successBg : p.errorBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(correct ? 'circle-check' : 'circle-x', size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            correct ? 'Jawaban benar' : 'Jawaban salah',
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerBlock extends StatelessWidget {
  const _AnswerBlock({
    required this.caption,
    required this.value,
    required this.correct,
  });

  final String caption;
  final String value;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final color = correct ? p.success : p.error;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.rs(14)),
      decoration: BoxDecoration(
        color: correct ? p.successBg : p.errorBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caption,
            style: TextStyle(
              color: color,
              fontSize: 11,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: p.ink,
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
