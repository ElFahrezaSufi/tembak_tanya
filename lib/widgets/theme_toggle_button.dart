import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_palette.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive.dart';
import 'app_icon.dart';

/// Tombol bulat bergaris untuk mengganti tema terang/gelap.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final size = context.rs(42);

    return Tooltip(
      message: isDark ? 'Mode terang' : 'Mode gelap',
      child: Material(
        color: Colors.transparent,
        shape: CircleBorder(side: BorderSide(color: p.border)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => context.read<ThemeProvider>().toggle(brightness),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) => RotationTransition(
                  turns: Tween(begin: 0.75, end: 1.0).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: AppIcon(
                  isDark ? 'sun' : 'moon',
                  key: ValueKey(isDark),
                  size: context.rs(20),
                  color: p.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
