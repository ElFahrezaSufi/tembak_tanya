import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State dibuat sekali di sini (di atas Navigator) agar progres kuis & tema
  // tetap ada saat layar dirotasi atau berpindah halaman.
  final QuizProvider _quiz = QuizProvider();
  final ThemeProvider _theme = ThemeProvider();
  late final GoRouter _router = AppRouter.create(_quiz);

  @override
  void dispose() {
    _router.dispose();
    _quiz.dispose();
    _theme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizProvider>.value(value: _quiz),
        ChangeNotifierProvider<ThemeProvider>.value(value: _theme),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, theme, _) => MaterialApp.router(
          title: 'TembakTanya',
          debugShowCheckedModeBanner: false,
          themeMode: theme.mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: _router,
        ),
      ),
    );
  }
}
