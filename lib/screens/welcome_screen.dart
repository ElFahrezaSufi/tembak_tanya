import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/quiz_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Simpan nama ke state management (Provider)
      context.read<QuizProvider>().setUserName(_nameController.text.trim());
      // Navigasi ke halaman kuis
      context.go('/quiz');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo Aplikasi
                  SvgPicture.asset(
                    'assets/images/icon_aplikasi.svg',
                    height: 120,
                  ),
                  const SizedBox(height: 40),
                  
                  // Teks Sambutan
                  Text(
                    'Selamat Datang!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sebelum mulai, beri tahu kami nama Anda.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Input Nama (Reusable Widget)
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Masukkan nama Anda...',
                    iconPath: 'assets/icons/user-round.svg',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  
                  // Tombol Mulai (Reusable Widget)
                  PrimaryButton(
                    text: 'Mulai Kuis',
                    iconPath: 'assets/icons/arrow-right.svg',
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
