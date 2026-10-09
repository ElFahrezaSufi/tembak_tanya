import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import 'question_navigator.dart';
import 'quiz_progress.dart';

/// Ringkasan "perjalanan kuis": progres + grid nomor + keterangan.
/// Dipakai di sidebar tablet dan kartu kiri browser.
class QuizJourney extends StatelessWidget {
  const QuizJourney({
    super.key,
    required this.quiz,
    this.expandedNote = false,
  });

  final QuizProvider quiz;

  /// Teks keterangan versi browser ("Nomor lain belum dijawab.").
  final bool expandedNote;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final current = quiz.currentIndex;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuizProgress(
          current: current,
          answered: [for (var i = 0; i < quiz.total; i++) quiz.isAnswered(i)],
        ),
        SizedBox(height: context.rs(16)),
        QuestionNavigator(
          total: quiz.total,
          onSelect: quiz.goTo,
          stateOf: (i) {
            if (i == current) return NavChipState.current;
            return quiz.isAnswered(i)
                ? NavChipState.answered
                : NavChipState.unanswered;
          },
        ),
        SizedBox(height: context.rs(14)),
        Text(
          _note(),
          style: TextStyle(color: p.muted, fontSize: 12.5, height: 1.4),
        ),
      ],
    );
  }

  String _note() {
    final answeredOthers = [
      for (var i = 0; i < quiz.total; i++)
        if (i != quiz.currentIndex && quiz.isAnswered(i)) i + 1,
    ];
    final opened = '${quiz.currentIndex + 1} sedang dibuka';
    final tail = expandedNote
        ? 'Nomor lain belum dijawab.'
        : 'Pilih nomor untuk berpindah soal.';
    if (answeredOthers.isEmpty) return 'Belum ada soal lain yang terjawab · $opened. $tail';
    return '${_ranges(answeredOthers)} terjawab · $opened. $tail';
  }

  /// [1,2,3,5] -> "1–3, 5"
  static String _ranges(List<int> nums) {
    final parts = <String>[];
    var start = nums.first;
    var prev = nums.first;
    for (var i = 1; i <= nums.length; i++) {
      final n = i < nums.length ? nums[i] : null;
      if (n != null && n == prev + 1) {
        prev = n;
        continue;
      }
      parts.add(start == prev ? '$start' : '$start–$prev');
      if (n != null) {
        start = n;
        prev = n;
      }
    }
    return parts.join(', ');
  }
}
