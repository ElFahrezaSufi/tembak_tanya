import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import '../widgets/app_logo_badge.dart';

/// Layar pembuka: logo + nama + tagline, lalu otomatis ke layar sambutan.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) context.go('/welcome');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _curve,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1).animate(_curve),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppLogoBadge(size: context.rs(144)),
                SizedBox(height: context.rs(28)),
                Text(
                  'TembakTanya',
                  style: TextStyle(
                    color: p.ink,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: context.rs(10)),
                Text(
                  'Bidik pertanyaan, temukan jawaban.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: p.muted, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
