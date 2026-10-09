import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_card.dart';
import 'app_icon.dart';

/// Kotak statistik: ikon + angka besar + keterangan (Benar/Salah dari N soal).
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.iconName,
    required this.value,
    required this.label,
  });

  final String iconName;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AppCard(
      radius: 20,
      padding: EdgeInsets.all(context.rs(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(iconName, size: context.rs(20), color: p.primary),
          SizedBox(height: context.rs(10)),
          Text(
            '$value',
            style: TextStyle(
              color: p.ink,
              fontSize: 30,
              height: 1.1,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: context.rs(4)),
          Text(label, style: TextStyle(color: p.muted, fontSize: 13)),
        ],
      ),
    );
  }
}
