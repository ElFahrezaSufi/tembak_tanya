import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_palette.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/app_header.dart';
import '../widgets/app_icon.dart';
import '../widgets/app_text_field.dart';
import '../widgets/hero_illustration.dart';
import '../widgets/resume_session_card.dart';

/// Layar sambutan: ilustrasi, input nama (validasi), dan lanjutkan sesi.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    final quiz = context.read<QuizProvider>();
    if (quiz.hasActiveSession) _nameController.text = quiz.userName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _name => _nameController.text.trim();

  void _start() {
    if (_name.isEmpty) {
      setState(() => _showError = true);
      return;
    }
    context.read<QuizProvider>().startSession(_name);
    context.push('/quiz');
  }

  void _resume() => context.push('/quiz');

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final canResume = quiz.hasActiveSession &&
        _name.toLowerCase() == quiz.userName.toLowerCase();
    final isWide = context.screenClass != ScreenClass.compact;

    final form = _NameForm(
      controller: _nameController,
      showError: _showError,
      isEmpty: _name.isEmpty,
      onChanged: (_) => setState(() => _showError = false),
      onStart: _start,
      resume: canResume
          ? ResumeSessionCard(
              name: quiz.userName,
              answered: quiz.answeredCount,
              total: quiz.total,
              onTap: _resume,
            )
          : null,
    );

    return Scaffold(
      body: SafeArea(
        child: isWide
            ? _wideBody(context, form)
            : _compactBody(context, form),
      ),
    );
  }

  Widget _compactBody(BuildContext context, Widget form) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              context.rs(24),
              context.rs(16),
              context.rs(24),
              context.rs(16),
            ),
            child: Column(
              children: [
                const AppHeader(title: 'TembakTanya'),
                SizedBox(height: context.rs(24)),
                const _Intro(),
                const Spacer(),
                SizedBox(height: context.rs(24)),
                form,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _wideBody(BuildContext context, Widget form) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            children: [
              const AppHeader(title: 'TembakTanya'),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(child: _Intro(heroFraction: 0.4)),
                  const SizedBox(width: 48),
                  Expanded(
                    child: AppCard(
                      radius: 28,
                      padding: const EdgeInsets.all(28),
                      child: form,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ilustrasi + judul + deskripsi + meta (10 soal • Dasar Flutter).
class _Intro extends StatelessWidget {
  const _Intro({this.heroFraction = 0.5});

  /// Ukuran hero sebagai pecahan dari lebar layar (dibatasi 160–300).
  final double heroFraction;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final width = MediaQuery.sizeOf(context).width;
    final hero = (width * heroFraction).clamp(160.0, 300.0).toDouble();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeroIllustration(size: hero),
        SizedBox(height: context.rs(20)),
        Text(
          'Sedikit kuis,\nbanyak paham.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: p.ink,
            fontSize: 30,
            height: 1.25,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: context.rs(14)),
        Text(
          'Uji pemahaman dasar Flutter kamu.\nBelajar santai, satu soal setiap langkah.',
          textAlign: TextAlign.center,
          style: TextStyle(color: p.muted, fontSize: 15, height: 1.45),
        ),
        SizedBox(height: context.rs(16)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon('layers', size: context.rs(18), color: p.primary),
            const SizedBox(width: 8),
            Text('10 soal', style: TextStyle(color: p.muted, fontSize: 13.5)),
            const SizedBox(width: 10),
            Text('•', style: TextStyle(color: p.muted, fontSize: 13.5)),
            const SizedBox(width: 10),
            Text('Dasar Flutter', style: TextStyle(color: p.muted, fontSize: 13.5)),
          ],
        ),
      ],
    );
  }
}

/// Label, input nama, pesan bantuan/error, tombol mulai, dan kartu lanjut sesi.
class _NameForm extends StatelessWidget {
  const _NameForm({
    required this.controller,
    required this.showError,
    required this.isEmpty,
    required this.onChanged,
    required this.onStart,
    this.resume,
  });

  final TextEditingController controller;
  final bool showError;
  final bool isEmpty;
  final ValueChanged<String> onChanged;
  final VoidCallback onStart;
  final Widget? resume;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Siapa nama kamu?',
          style: TextStyle(
            color: p.ink,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: context.rs(12)),
        AppTextField(
          controller: controller,
          hintText: 'Masukkan nama kamu',
          iconName: 'user-round',
          hasError: showError,
          onChanged: onChanged,
          onSubmitted: (_) => onStart(),
        ),
        SizedBox(height: context.rs(10)),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: Text(
            showError
                ? 'Nama belum diisi. Tulis namamu dulu, ya.'
                : 'Nama ini akan muncul di hasil kuismu.',
            key: ValueKey(showError),
            style: TextStyle(
              color: showError ? p.error : p.muted,
              fontSize: 13,
            ),
          ),
        ),
        SizedBox(height: context.rs(14)),
        AppButton(
          label: 'Mulai kuis',
          icon: 'arrow-right',
          dimmed: isEmpty,
          onPressed: onStart,
        ),
        if (resume != null) ...[
          SizedBox(height: context.rs(12)),
          resume!,
        ],
        SizedBox(height: context.rs(14)),
        Center(
          child: Text(
            'Tanpa akun. Cukup nama dan rasa ingin tahu.',
            textAlign: TextAlign.center,
            style: TextStyle(color: p.muted, fontSize: 12.5),
          ),
        ),
      ],
    );
  }
}
