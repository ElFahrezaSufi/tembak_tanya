import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_icon.dart';
import 'app_logo_badge.dart';
import 'theme_toggle_button.dart';

/// Header layar: [logo | tombol kembali] + judul + toggle tema.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.onBack});

  final String title;

  /// Jika diisi, tombol kembali tampil menggantikan logo.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final box = context.rs(40);

    return Row(
      children: [
        if (onBack != null)
          Tooltip(
            message: 'Kembali',
            child: Material(
              color: p.tint,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onBack,
                child: SizedBox(
                  width: box,
                  height: box,
                  child: Center(
                    child: AppIcon('arrow-left', size: context.rs(20), color: p.primary),
                  ),
                ),
              ),
            ),
          )
        else
          AppLogoBadge(size: box),
        SizedBox(width: context.rs(12)),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: p.ink,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const ThemeToggleButton(),
      ],
    );
  }
}
