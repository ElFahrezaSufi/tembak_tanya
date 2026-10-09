import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tembak_tanya/data/dummy_questions.dart';
import 'package:tembak_tanya/main.dart';
import 'package:tembak_tanya/providers/quiz_provider.dart';

/// Jawaban demo "Alya" dari handoff mockup: salah hanya di soal 4 dan 7.
const demoAnswers = [1, 2, 1, 0, 2, 1, 0, 0, 2, 1];

void main() {
  group('QuizProvider', () {
    test('menghitung skor 80 untuk jawaban demo', () {
      final quiz = QuizProvider()..startSession('Alya');
      for (var i = 0; i < demoAnswers.length; i++) {
        quiz.selectOptionAt(i, demoAnswers[i]);
      }
      expect(quiz.allAnswered, isTrue);
      expect(quiz.finish(), isTrue);
      expect(quiz.correctCount, 8);
      expect(quiz.wrongCount, 2);
      expect(quiz.score, 80);
      expect(quiz.wrongQuestionNumbers, [4, 7]);
    });

    test('tidak bisa selesai jika belum semua terjawab & jawaban terkunci', () {
      final quiz = QuizProvider()..startSession('Alya');
      quiz.selectOption(0);
      expect(quiz.finish(), isFalse);
      expect(quiz.hasActiveSession, isTrue);

      for (var i = 0; i < quiz.total; i++) {
        quiz.selectOptionAt(i, 0);
      }
      quiz.finish();
      quiz.selectOptionAt(0, 3);
      expect(quiz.answerAt(0), 0); // tidak berubah setelah selesai
    });

    test('retry menjaga nama tetapi mereset progres', () {
      final quiz = QuizProvider()..startSession('Alya');
      quiz.selectOption(1);
      quiz.retry();
      expect(quiz.userName, 'Alya');
      expect(quiz.answeredCount, 0);
      expect(quiz.currentIndex, 0);
    });
  });

  testWidgets('alur lengkap: splash → nama → kuis → konfirmasi → hasil → tinjau',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 2580); // 400 x 860 dp
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    // Splash
    expect(find.text('TembakTanya'), findsOneWidget);
    expect(find.text('Bidik pertanyaan, temukan jawaban.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Welcome: validasi nama kosong
    expect(find.text('Sedikit kuis,\nbanyak paham.'), findsOneWidget);
    await tester.tap(find.text('Mulai kuis'));
    await tester.pumpAndSettle();
    expect(find.text('Nama belum diisi. Tulis namamu dulu, ya.'), findsOneWidget);

    // Isi nama lalu mulai
    await tester.enterText(find.byType(TextField), 'Alya');
    await tester.pump();
    await tester.tap(find.text('Mulai kuis'));
    await tester.pumpAndSettle();
    expect(find.text('Soal 1 dari 10'), findsOneWidget);

    // Tombol berikutnya tidak berpindah sebelum ada jawaban
    await tester.tap(find.text('Berikutnya'));
    await tester.pumpAndSettle();
    expect(find.text('Soal 1 dari 10'), findsOneWidget);

    // Jawab 10 soal
    for (var i = 0; i < 10; i++) {
      final q = dummyQuestions[i];
      await tester.tap(find.text(q.options[demoAnswers[i]]));
      await tester.pumpAndSettle();
      await tester.tap(find.text(i == 9 ? 'Selesai' : 'Berikutnya'));
      await tester.pumpAndSettle();
    }

    // Sheet konfirmasi
    expect(find.text('Siap lihat hasilnya?'), findsOneWidget);
    expect(find.text('10/10 soal terjawab'), findsOneWidget);
    await tester.tap(find.text('Ya, selesaikan kuis'));
    await tester.pumpAndSettle();

    // Hasil
    expect(find.text('Kerja bagus, Alya!'), findsOneWidget);
    expect(find.text('80'), findsOneWidget);
    expect(find.text('Benar dari 10 soal'), findsOneWidget);

    // Tinjau jawaban
    await tester.tap(find.text('Tinjau jawaban'));
    await tester.pumpAndSettle();
    expect(find.text('Pahami setiap jawaban.'), findsOneWidget);
    expect(find.text('Soal salah: 4 dan 7 · Semua 10 soal bisa ditinjau'),
        findsOneWidget);
  });
}
