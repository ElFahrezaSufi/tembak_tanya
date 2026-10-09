import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../models/question_model.dart';
import '../utils/responsive.dart';
import 'app_button.dart';
import 'option_card.dart';

/// Kategori kecil (huruf kapital) + teks soal.
class QuestionTitle extends StatelessWidget {
  const QuestionTitle({
    super.key,
    required this.question,
    this.showCategory = true,
    this.fontSize = 24,
  });

  final Question question;
  final bool showCategory;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showCategory) ...[
          Text(
            question.category,
            style: TextStyle(
              color: p.muted,
              fontSize: 11.5,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: context.rs(10)),
        ],
        Text(
          question.text,
          style: TextStyle(
            color: p.ink,
            fontSize: fontSize,
            height: 1.28,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

/// Daftar opsi jawaban dalam 1 atau 2 kolom.
class OptionList extends StatelessWidget {
  const OptionList({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.onSelect,
    this.columns = 1,
  });

  final Question question;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;
  final int columns;

  @override
  Widget build(BuildContext context) {
    final gap = context.rs(12);
    final count = question.options.length;
    final rows = <Widget>[];

    for (var start = 0; start < count; start += columns) {
      final cells = <Widget>[];
      for (var i = start; i < start + columns; i++) {
        if (i > start) cells.add(SizedBox(width: gap));
        cells.add(
          Expanded(
            child: i < count
                ? OptionCard(
                    letter: Question.letterOf(i),
                    text: question.options[i],
                    isSelected: selectedIndex == i,
                    onTap: () => onSelect(i),
                  )
                : const SizedBox.shrink(),
          ),
        );
      }
      if (rows.isNotEmpty) rows.add(SizedBox(height: gap));
      rows.add(IntrinsicHeight(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: cells),
      ));
    }

    return Column(children: rows);
  }
}

/// Teks petunjuk + tombol Sebelumnya / Berikutnya.
class QuizActionBar extends StatelessWidget {
  const QuizActionBar({
    super.key,
    required this.hint,
    required this.canGoBack,
    required this.canGoNext,
    required this.nextLabel,
    required this.onPrevious,
    required this.onNext,
    this.centerHint = true,
  });

  final String hint;
  final bool canGoBack;
  final bool canGoNext;
  final String nextLabel;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool centerHint;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment:
          centerHint ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: Text(
            hint,
            key: ValueKey(hint),
            textAlign: centerHint ? TextAlign.center : TextAlign.start,
            style: TextStyle(color: p.muted, fontSize: 13),
          ),
        ),
        SizedBox(height: context.rs(14)),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Sebelumnya',
                variant: AppButtonVariant.secondary,
                dimmed: !canGoBack,
                onPressed: canGoBack ? onPrevious : null,
              ),
            ),
            SizedBox(width: context.rs(12)),
            Expanded(
              child: AppButton(
                label: nextLabel,
                dimmed: !canGoNext,
                onPressed: onNext,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
