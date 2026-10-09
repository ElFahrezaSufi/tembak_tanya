import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_palette.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/app_button.dart';
import '../widgets/app_header.dart';
import '../widgets/app_icon.dart';
import '../widgets/score_ring.dart';
import '../widgets/stat_tile.dart';

/// Skor akhir: sapaan nama, cincin skor, jumlah benar/salah, dan aksi lanjutan.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Hasil bersifat final, jadi cukup `read` (tidak perlu rebuild saat state
    // direset ketika berpindah halaman).
    final quiz = context.read<QuizProvider>();
    final isWide = context.screenClass != ScreenClass.compact;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 32 : context.rs(24),
            vertical: isWide ? 24 : context.rs(16),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 960 : 520),
              child: Column(
                children: [
                  const AppHeader(title: 'Hasil kuis'),
                  SizedBox(height: isWide ? 32 : context.rs(20)),
                  isWide ? _WideBody(quiz: quiz) : _CompactBody(quiz: quiz),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactBody extends StatelessWidget {
  const _CompactBody({required this.quiz});

  final QuizProvider quiz;

  @override
  Widget build(BuildContext context) {
    final ring = (MediaQuery.sizeOf(context).width * 0.5).clamp(160.0, 240.0).toDouble();
    return Column(
      children: [
        _Summary(quiz: quiz),
        SizedBox(height: context.rs(24)),
        ScoreRing(score: quiz.score, size: ring),
        SizedBox(height: context.rs(24)),
        _Stats(quiz: quiz),
        SizedBox(height: context.rs(16)),
        _Actions(quiz: quiz),
      ],
    );
  }
}

class _WideBody extends StatelessWidget {
  const _WideBody({required this.quiz});

  final QuizProvider quiz;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              _Summary(quiz: quiz),
              const SizedBox(height: 32),
              ScoreRing(score: quiz.score, size: 240),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: Column(
            children: [
              _Stats(quiz: quiz),
              const SizedBox(height: 16),
              _Actions(quiz: quiz),
            ],
          ),
        ),
      ],
    );
  }
}

/// Lencana "KUIS SELESAI", sapaan, dan deskripsi.
class _Summary extends StatelessWidget {
  const _Summary({required this.quiz});

  final QuizProvider quiz;

  String get _greeting {
    if (quiz.score >= 80) return 'Kerja bagus';
    if (quiz.score >= 50) return 'Lumayan';
    return 'Tetap semangat';
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: p.tint,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon('flag', size: 14, color: p.primary),
              const SizedBox(width: 8),
              Text(
                'KUIS SELESAI',
                style: TextStyle(
                  color: p.primary,
                  fontSize: 11.5,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.rs(20)),
        Text(
          '$_greeting, ${quiz.userName}!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: p.ink,
            fontSize: 30,
            height: 1.2,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: context.rs(12)),
        Text(
          'Dasar Flutter makin kamu kuasai.\nIni hasil dari ${quiz.total} jawabanmu.',
          textAlign: TextAlign.center,
          style: TextStyle(color: p.muted, fontSize: 15, height: 1.45),
        ),
      ],
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.quiz});

  final QuizProvider quiz;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StatTile(
              iconName: 'circle-check',
              value: quiz.correctCount,
              label: 'Benar dari ${quiz.total} soal',
            ),
          ),
          SizedBox(width: context.rs(12)),
          Expanded(
            child: StatTile(
              iconName: 'circle-x',
              value: quiz.wrongCount,
              label: 'Salah dari ${quiz.total} soal',
            ),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.quiz});

  final QuizProvider quiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          label: 'Tinjau jawaban',
          icon: 'list-checks',
          onPressed: () => context.push('/review'),
        ),
        SizedBox(height: context.rs(12)),
        AppButton(
          label: 'Coba lagi',
          icon: 'rotate-ccw',
          variant: AppButtonVariant.secondary,
          onPressed: () {
            quiz.retry();
            context.go('/quiz');
          },
        ),
        SizedBox(height: context.rs(8)),
        AppButton(
          label: 'Kembali ke beranda',
          variant: AppButtonVariant.text,
          onPressed: () {
            context.go('/welcome');
            quiz.reset();
          },
        ),
      ],
    );
  }
}
