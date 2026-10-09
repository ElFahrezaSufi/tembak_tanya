import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_icon.dart';

/// Kartu kuning berisi tips (ikon bohlam + teks).
class TipCard extends StatelessWidget {
  const TipCard({super.key, required this.message, this.title, this.footnote});

  final String? title;
  final String message;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.rs(18)),
      decoration: BoxDecoration(
        color: p.accentSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon('lightbulb', size: context.rs(22), color: p.primary),
          SizedBox(height: context.rs(12)),
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
                color: p.ink,
                fontSize: 18,
                height: 1.3,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: context.rs(10)),
          ],
          Text(
            message,
            style: TextStyle(color: p.ink, fontSize: 13.5, height: 1.45),
          ),
          if (footnote != null) ...[
            SizedBox(height: context.rs(14)),
            Text(
              footnote!,
              style: TextStyle(color: p.muted, fontSize: 12, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}
