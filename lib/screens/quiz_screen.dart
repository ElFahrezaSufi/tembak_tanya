import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/quiz_provider.dart';
import '../data/dummy_questions.dart';
import '../widgets/option_card.dart';
import '../widgets/primary_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;

  void _nextQuestion() {
    final provider = context.read<QuizProvider>();
    final currentQuestion = dummyQuestions[_currentIndex];

    // Pastikan user sudah memilih jawaban sebelum lanjut
    if (!provider.isQuestionAnswered(currentQuestion.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih jawaban terlebih dahulu!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_currentIndex < dummyQuestions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _showConfirmationDialog();
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/info.svg',
              width: 24,
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            const Text('Konfirmasi'),
          ],
        ),
        content: const Text('Apakah Anda yakin ingin menyelesaikan kuis ini? Jawaban tidak dapat diubah lagi.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              final provider = context.read<QuizProvider>();
              provider.calculateScore();
              context.go('/result');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Kirim Jawaban'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = dummyQuestions[_currentIndex];
    final provider = context.watch<QuizProvider>();
    
    final isLastQuestion = _currentIndex == dummyQuestions.length - 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            colorFilter: ColorFilter.mode(theme.appBarTheme.iconTheme!.color!, BlendMode.srcIn),
          ),
          onPressed: () {
            if (_currentIndex > 0) {
              setState(() {
                _currentIndex--;
              });
            } else {
              context.go('/');
            }
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/layers.svg',
              width: 20,
              colorFilter: ColorFilter.mode(theme.appBarTheme.iconTheme!.color!, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text('Soal ${_currentIndex + 1} dari ${dummyQuestions.length}'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Indikator Progres (Estetika)
            LinearProgressIndicator(
              value: (_currentIndex + 1) / dummyQuestions.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              minHeight: 4,
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Teks Pertanyaan
                    Text(
                      question.text,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Opsi Jawaban
                    ...List.generate(question.options.length, (index) {
                      final optionLetters = ['A', 'B', 'C', 'D'];
                      final isSelected = provider.getSelectedOption(question.id) == index;
                      
                      return OptionCard(
                        letter: optionLetters[index],
                        text: question.options[index],
                        isSelected: isSelected,
                        onTap: () {
                          provider.answerQuestion(question.id, index);
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            
            // Area Tombol Bawah
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                text: isLastQuestion ? 'Selesaikan Kuis' : 'Soal Berikutnya',
                iconPath: isLastQuestion ? 'assets/icons/check.svg' : 'assets/icons/arrow-right.svg',
                onPressed: _nextQuestion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
