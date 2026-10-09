import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_palette.dart';
import '../models/question_model.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/app_header.dart';
import '../widgets/app_icon.dart';
import '../widgets/confirm_finish_sheet.dart';
import '../widgets/question_panel.dart';
import '../widgets/quiz_journey.dart';
import '../widgets/quiz_progress.dart';
import '../widgets/tip_card.dart';

/// Satu layar kuis untuk seluruh soal (konten diganti berdasarkan indeks di
/// [QuizProvider]). Tata letak menyesuaikan ukuran layar:
/// ponsel (compact), tablet (medium), browser (expanded).
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final actions = _QuizActions(context, quiz);

    return Scaffold(
      body: SafeArea(
        child: switch (context.screenClass) {
          ScreenClass.compact => _CompactLayout(quiz: quiz, actions: actions),
          ScreenClass.medium => _MediumLayout(quiz: quiz, actions: actions),
          ScreenClass.expanded => _ExpandedLayout(quiz: quiz, actions: actions),
        },
      ),
    );
  }
}

/// Logika interaksi yang dipakai bersama oleh ketiga layout.
class _QuizActions {
  _QuizActions(this.context, this.quiz);

  final BuildContext context;
  final QuizProvider quiz;

  bool get canNext => quiz.currentAnswer != null;
  String get nextLabel => quiz.isLast ? 'Selesai' : 'Berikutnya';

  String get hint {
    final answer = quiz.currentAnswer;
    return answer == null
        ? 'Pilih jawaban untuk melanjutkan.'
        : '${Question.letterOf(answer)} dipilih. Jawaban bisa diubah sebelum selesai.';
  }

  void back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/welcome');
    }
  }

  void _snack(String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> next() async {
    if (!canNext) {
      _snack('Pilih satu jawaban dulu, ya.');
      return;
    }
    if (!quiz.isLast) {
      quiz.next();
      return;
    }
    if (!quiz.allAnswered) {
      final missing = [
        for (var i = 0; i < quiz.total; i++)
          if (!quiz.isAnswered(i)) i + 1,
      ];
      _snack('Masih ada soal yang belum dijawab: ${missing.join(', ')}.');
      quiz.goTo(missing.first - 1);
      return;
    }
    final confirmed = await showConfirmFinishSheet(
      context,
      name: quiz.userName,
      answered: quiz.answeredCount,
      total: quiz.total,
    );
    if (confirmed && context.mounted) {
      quiz.finish();
      context.go('/result');
    }
  }
}

// ============================================================ PONSEL
class _CompactLayout extends StatelessWidget {
  const _CompactLayout({required this.quiz, required this.actions});

  final QuizProvider quiz;
  final _QuizActions actions;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final question = quiz.currentQuestion;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.rs(24),
        context.rs(16),
        context.rs(24),
        context.rs(12),
      ),
      child: Column(
        children: [
          AppHeader(title: 'Dasar Flutter', onBack: actions.back),
          SizedBox(height: context.rs(20)),
          QuizProgress(
            current: quiz.currentIndex,
            answered: [for (var i = 0; i < quiz.total; i++) quiz.isAnswered(i)],
          ),
          SizedBox(height: context.rs(20)),
          Expanded(
            child: SingleChildScrollView(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                layoutBuilder: (current, previous) => Stack(
                  alignment: Alignment.topCenter,
                  children: [...previous, ?current],
                ),
                child: Column(
                  key: ValueKey(quiz.currentIndex),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    QuestionTitle(question: question),
                    SizedBox(height: context.rs(10)),
                    Text(
                      'Pilih satu jawaban yang paling tepat.',
                      style: TextStyle(color: p.muted, fontSize: 14),
                    ),
                    SizedBox(height: context.rs(18)),
                    OptionList(
                      question: question,
                      selectedIndex: quiz.currentAnswer,
                      onSelect: quiz.selectOption,
                    ),
                    SizedBox(height: context.rs(8)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: context.rs(8)),
          QuizActionBar(
            hint: actions.hint,
            canGoBack: !quiz.isFirst,
            canGoNext: actions.canNext,
            nextLabel: actions.nextLabel,
            onPrevious: quiz.previous,
            onNext: actions.next,
          ),
          SizedBox(height: context.rs(12)),
          Text(
            'Pemain: ${quiz.userName} · Tidak ada batas waktu',
            textAlign: TextAlign.center,
            style: TextStyle(color: p.muted, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

// ============================================================ TABLET
class _MediumLayout extends StatelessWidget {
  const _MediumLayout({required this.quiz, required this.actions});

  final QuizProvider quiz;
  final _QuizActions actions;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final name = quiz.userName;
    final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const AppHeader(title: 'TembakTanya'),
              const SizedBox(height: 28),
              LayoutBuilder(
                builder: (context, c) {
                  final sidebar = (c.maxWidth * 0.28).clamp(240.0, 330.0).toDouble();
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: sidebar,
                        child: AppCard(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: p.accentSoft,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      initial,
                                      style: TextStyle(
                                        color: p.ink,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: p.ink,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Sesi belajar',
                                          style: TextStyle(color: p.muted, fontSize: 12.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 22),
                              Text(
                                'Dasar Flutter',
                                style: TextStyle(
                                  color: p.ink,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 18),
                              QuizJourney(quiz: quiz),
                              const SizedBox(height: 18),
                              const TipCard(
                                message:
                                    'Tidak perlu terburu-buru. Kamu bisa kembali dan mengubah jawaban sebelum selesai.',
                              ),
                              const SizedBox(height: 12),
                              AppButton(
                                label: 'Kembali ke beranda',
                                variant: AppButtonVariant.text,
                                onPressed: actions.back,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _MainQuestionCard(
                          quiz: quiz,
                          actions: actions,
                          columns: 2,
                          padding: 28,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================ BROWSER
class _ExpandedLayout extends StatelessWidget {
  const _ExpandedLayout({required this.quiz, required this.actions});

  final QuizProvider quiz;
  final _QuizActions actions;

  static const double _maxWidth = 1344;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
          decoration: BoxDecoration(
            color: p.card,
            border: Border(bottom: BorderSide(color: p.border)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxWidth),
              child: const AppHeader(title: 'TembakTanya'),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(48, 36, 48, 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saatnya mengenal Flutter lebih dekat.',
                                style: TextStyle(
                                  color: p.ink,
                                  fontSize: 34,
                                  height: 1.2,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Dasar Flutter · Sesi ${quiz.userName} · Tidak ada batas waktu',
                                style: TextStyle(color: p.muted, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: p.accentSoft,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppIcon('user-round', size: 16, color: p.ink),
                              const SizedBox(width: 8),
                              Text(
                                quiz.userName,
                                style: TextStyle(
                                  color: p.ink,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 29,
                          child: AppCard(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Perjalanan kuismu',
                                  style: TextStyle(
                                    color: p.ink,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                QuizJourney(quiz: quiz, expandedNote: true),
                                const SizedBox(height: 18),
                                AppButton(
                                  label: 'Kembali ke beranda',
                                  variant: AppButtonVariant.tonal,
                                  onPressed: actions.back,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 78,
                          child: _MainQuestionCard(
                            quiz: quiz,
                            actions: actions,
                            columns: 1,
                            padding: 32,
                          ),
                        ),
                        const SizedBox(width: 24),
                        const Expanded(
                          flex: 22,
                          child: TipCard(
                            title: 'Belajar tanpa terburu-buru.',
                            message:
                                'Kamu boleh kembali ke soal sebelumnya dan mengganti pilihan sebelum menyelesaikan kuis.',
                            footnote:
                                'Pembahasan dan jawaban yang benar tersedia setelah kuis selesai.',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Kartu soal untuk layout tablet & browser.
class _MainQuestionCard extends StatelessWidget {
  const _MainQuestionCard({
    required this.quiz,
    required this.actions,
    required this.columns,
    required this.padding,
  });

  final QuizProvider quiz;
  final _QuizActions actions;
  final int columns;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final question = quiz.currentQuestion;

    return AppCard(
      radius: 28,
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Soal ${quiz.currentIndex + 1} dari ${quiz.total}',
                  style: TextStyle(
                    color: p.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  question.category,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: p.muted,
                    fontSize: 12,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          QuestionTitle(question: question, showCategory: false, fontSize: 28),
          const SizedBox(height: 14),
          Text(
            'Pilih satu jawaban yang paling tepat.',
            style: TextStyle(color: p.muted, fontSize: 15),
          ),
          const SizedBox(height: 22),
          OptionList(
            question: question,
            selectedIndex: quiz.currentAnswer,
            onSelect: quiz.selectOption,
            columns: columns,
          ),
          const SizedBox(height: 20),
          QuizActionBar(
            hint: actions.hint,
            centerHint: false,
            canGoBack: !quiz.isFirst,
            canGoNext: actions.canNext,
            nextLabel: actions.nextLabel,
            onPrevious: quiz.previous,
            onNext: actions.next,
          ),
        ],
      ),
    );
  }
}
