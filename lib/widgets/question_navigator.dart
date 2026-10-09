import 'package:flutter/material.dart';

import '../config/app_palette.dart';

/// Status satu tombol nomor soal.
enum NavChipState { unanswered, answered, current, wrong }

/// Grid nomor soal. Dipakai di sidebar kuis (tablet/browser) dan halaman tinjau.
class QuestionNavigator extends StatelessWidget {
  const QuestionNavigator({
    super.key,
    required this.total,
    required this.stateOf,
    required this.onSelect,
    this.columns = 5,
    this.aspectRatio = 1.1,
    this.spacing = 8,
  });

  final int total;
  final NavChipState Function(int index) stateOf;
  final ValueChanged<int> onSelect;
  final int columns;
  final double aspectRatio;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: total,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, i) => _NavChip(
        number: i + 1,
        state: stateOf(i),
        onTap: () => onSelect(i),
      ),
    );
  }
}

class _NavChip extends StatelessWidget {
  const _NavChip({
    required this.number,
    required this.state,
    required this.onTap,
  });

  final int number;
  final NavChipState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    Color bg;
    Color fg;
    Color border;
    switch (state) {
      case NavChipState.current:
        bg = p.primary;
        fg = p.onPrimary;
        border = p.primary;
      case NavChipState.answered:
        bg = p.tint;
        fg = p.primary;
        border = p.tint;
      case NavChipState.wrong:
        bg = p.errorBg;
        fg = p.error;
        border = p.error;
      case NavChipState.unanswered:
        bg = p.card;
        fg = p.primary;
        border = p.border;
    }
    final radius = BorderRadius.circular(12);

    return Semantics(
      button: true,
      selected: state == NavChipState.current,
      label: 'Soal $number',
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: Border.all(color: border),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: radius,
            onTap: onTap,
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  color: fg,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
