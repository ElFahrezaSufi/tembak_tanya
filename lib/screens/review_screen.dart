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

/// Tinjau jawaban: grid nomor (soal salah ditandai), kartu pembahasan, dan
/// tombol Soal sebelumnya / berikutnya.
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late final List<GlobalKey> _cardKeys;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    final quiz = context.read<QuizProvider>();
    _cardKeys = List.generate(quiz.total, (_) => GlobalKey());
    // Nomor terpilih awal = soal salah pertama (jika ada); halaman tetap dibuka dari atas.
    final wrong = quiz.wrongQuestionNumbers;
    if (wrong.isNotEmpty) _selected = wrong.first - 1;
  }

  void _select(int index) {
    final total = _cardKeys.length;
    if (index < 0 || index >= total) return;
    setState(() => _selected = index);
    _scrollTo(index);
  }

  void _scrollTo(int index, {bool animate = true}) {
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
                    onSelect: _select,
                    stateOf: (i) {
                      if (i == _selected) return NavChipState.current;
                      return quiz.isCorrect(i)
                          ? NavChipState.answered
                          : NavChipState.wrong;
                    },
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
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Soal sebelumnya',
                          variant: AppButtonVariant.secondary,
                          dimmed: _selected == 0,
                          onPressed: _selected == 0 ? null : () => _select(_selected - 1),
                        ),
                      ),
                      SizedBox(width: context.rs(12)),
                      Expanded(
                        child: AppButton(
                          label: 'Soal berikutnya',
                          dimmed: _selected == quiz.total - 1,
                          onPressed: _selected == quiz.total - 1
                              ? null
                              : () => _select(_selected + 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.rs(8)),
                  AppButton(
                    label: 'Kembali ke hasil',
                    variant: AppButtonVariant.text,
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
