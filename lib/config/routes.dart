import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../providers/quiz_provider.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';
import '../screens/review_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';

/// Konfigurasi navigasi (go_router).
///
/// Alur: `/` splash → `/welcome` → `/quiz` → `/result` → `/review`.
/// [redirect] menjaga agar halaman kuis/hasil tidak terbuka tanpa sesi
/// (mis. saat reload di browser).
class AppRouter {
  AppRouter._();

  static GoRouter create(QuizProvider quiz) {
    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final path = state.matchedLocation;
        if (path == '/quiz') {
          if (quiz.userName.isEmpty) return '/welcome';
          if (quiz.isFinished) return '/result';
        }
        if ((path == '/result' || path == '/review') && !quiz.isFinished) {
          return '/welcome';
        }
        return null;
      },
      routes: [
        GoRoute(path: '/', pageBuilder: (c, s) => _page(s, const SplashScreen())),
        GoRoute(path: '/welcome', pageBuilder: (c, s) => _page(s, const WelcomeScreen())),
        GoRoute(path: '/quiz', pageBuilder: (c, s) => _page(s, const QuizScreen())),
        GoRoute(path: '/result', pageBuilder: (c, s) => _page(s, const ResultScreen())),
        GoRoute(path: '/review', pageBuilder: (c, s) => _page(s, const ReviewScreen())),
      ],
    );
  }

  /// Transisi fade-slide halus antar halaman.
  static CustomTransitionPage<void> _page(GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 320),
      transitionsBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
