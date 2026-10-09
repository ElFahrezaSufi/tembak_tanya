import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_palette.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/app_button.dart';
import '../widgets/app_header.dart';
import '../widgets/question_navigator.dart';
import '../widgets/review_answer_card.dart';

/// Tinjau jawaban: grid nomor (soal salah ditandai) dan kartu pembahasan.
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late final List<GlobalKey> _cardKeys;

  @override
  void initState() {
    super.initState();
    final quiz = context.read<QuizProvider>();
    _cardKeys = List.generate(quiz.total, (_) => GlobalKey());
  }

  void _scrollTo(int index, {bool animate = true}) {
    if (index < 0 || index >= _cardKeys.length) return;
    final target = _cardKeys[index].currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      alignment: 0.02,
      duration: animate ? const Duration(milliseconds: 320) : Duration.zero,
      curve: Curves.easeOutCubic,
    );
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/result');
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final quiz = context.read<QuizProvider>();
    final wrong = quiz.wrongQuestionNumbers;
    final isWide = context.screenClass != ScreenClass.compact;

    final wrongNote = wrong.isEmpty
        ? 'Semua jawabanmu benar · Semua ${quiz.total} soal bisa ditinjau'
        : 'Soal salah: ${_join(wrong)} · Semua ${quiz.total} soal bisa ditinjau';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 32 : context.rs(24),
            vertical: isWide ? 24 : context.rs(16),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isWide ? 760 : 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppHeader(title: 'Tinjau jawaban', onBack: _back),
                  SizedBox(height: context.rs(24)),
                  Text(
                    'Pahami setiap jawaban.',
                    style: TextStyle(
                      color: p.ink,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: context.rs(8)),
                  Text(
                    '${quiz.userName} · ${quiz.correctCount} benar, ${quiz.wrongCount} salah. '
                    'Pilih nomor soal untuk melihat pembahasannya.',
                    style: TextStyle(color: p.muted, fontSize: 14, height: 1.45),
                  ),
                  SizedBox(height: context.rs(18)),
                  QuestionNavigator(
                    total: quiz.total,
                    aspectRatio: 1.45,
                    onSelect: _scrollTo,
                    stateOf: (i) => quiz.isCorrect(i)
                        ? NavChipState.answered
                        : NavChipState.wrong,
                  ),
                  SizedBox(height: context.rs(14)),
                  Text(wrongNote, style: TextStyle(color: p.muted, fontSize: 12.5)),
                  SizedBox(height: context.rs(18)),
                  for (var i = 0; i < quiz.total; i++) ...[
                    KeyedSubtree(
                      key: _cardKeys[i],
                      child: ReviewAnswerCard(
                        number: i + 1,
                        question: quiz.questions[i],
                        selectedIndex: quiz.answerAt(i),
                      ),
                    ),
                    SizedBox(height: context.rs(16)),
                  ],
                  AppButton(
                    label: 'Kembali ke hasil',
                    onPressed: _back,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// [4, 7] -> "4 dan 7", [1, 4, 7] -> "1, 4 dan 7"
  static String _join(List<int> nums) {
    if (nums.length == 1) return '${nums.first}';
    final head = nums.sublist(0, nums.length - 1).join(', ');
    return '$head dan ${nums.last}';
  }
}
