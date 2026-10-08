import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// TODO: Nanti import screen-screen yang dibuat
// import '../screens/welcome_screen.dart';
// import '../screens/quiz_screen.dart';
// import '../screens/result_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PlaceholderScreen(title: 'Welcome Screen'), // Ganti jadi WelcomeScreen
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => const PlaceholderScreen(title: 'Quiz Screen'), // Ganti jadi QuizScreen
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) => const PlaceholderScreen(title: 'Result Screen'), // Ganti jadi ResultScreen
      ),
    ],
  );
}

// Widget Placeholder sementara sebelum screen asli dibuat
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: Theme.of(context).textTheme.headlineMedium)),
    );
  }
}
