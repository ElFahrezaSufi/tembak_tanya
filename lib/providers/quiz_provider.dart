import 'package:flutter/foundation.dart';

import '../data/dummy_questions.dart';
import '../models/question_model.dart';

/// State kuis: nama, jawaban, soal aktif, dan status selesai.
///
/// Disimpan di Provider (di atas Navigator) sehingga progres tidak hilang
/// saat layar dirotasi atau pengguna berpindah halaman.
class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question>? questions})
      : questions = List.unmodifiable(questions ?? dummyQuestions) {
    _answers = List<int?>.filled(this.questions.length, null);
  }

  final List<Question> questions;

  String _userName = '';
  int _currentIndex = 0;
  bool _finished = false;
  late List<int?> _answers;

  // ---------------------------------------------------------------- getters
  String get userName => _userName;
  int get currentIndex => _currentIndex;
  bool get isFinished => _finished;
  int get total => questions.length;
  Question get currentQuestion => questions[_currentIndex];
  List<int?> get answers => List.unmodifiable(_answers);

  int get answeredCount => _answers.where((a) => a != null).length;
  bool get allAnswered => answeredCount == total;
  bool get isFirst => _currentIndex == 0;
  bool get isLast => _currentIndex == total - 1;

  /// Ada sesi yang sedang berjalan (sudah ada jawaban, belum selesai).
  bool get hasActiveSession =>
      _userName.isNotEmpty && !_finished && answeredCount > 0;

  int? answerAt(int index) => _answers[index];
  bool isAnswered(int index) => _answers[index] != null;
  int? get currentAnswer => _answers[_currentIndex];

  // ------------------------------------------------------------ hasil / skor
  bool isCorrect(int index) =>
      _answers[index] == questions[index].correctOptionIndex;

  int get correctCount =>
      List.generate(total, (i) => i).where(isCorrect).length;
  int get wrongCount => total - correctCount;

  /// Skor 0-100 = benar / total x 100.
  int get score => total == 0 ? 0 : (correctCount * 100 / total).round();

  /// Nomor soal (basis 1) yang dijawab salah.
  List<int> get wrongQuestionNumbers => [
        for (var i = 0; i < total; i++)
          if (!isCorrect(i)) i + 1,
      ];

  // ------------------------------------------------------------------ aksi
  /// Mulai sesi baru dengan nama pengguna.
  void startSession(String name) {
    _userName = name.trim();
    _resetProgress();
    notifyListeners();
  }

  void selectOption(int option) => selectOptionAt(_currentIndex, option);

  void selectOptionAt(int questionIndex, int option) {
    if (_finished) return; // setelah selesai jawaban dikunci
    if (questionIndex < 0 || questionIndex >= total) return;
    _answers[questionIndex] = option;
    notifyListeners();
  }

  void goTo(int index) {
    if (index < 0 || index >= total || index == _currentIndex) return;
    _currentIndex = index;
    notifyListeners();
  }

  void next() => goTo(_currentIndex + 1);
  void previous() => goTo(_currentIndex - 1);

  /// Tandai kuis selesai. Hanya berhasil jika semua soal sudah dijawab.
  bool finish() {
    if (!allAnswered) return false;
    _finished = true;
    notifyListeners();
    return true;
  }

  /// "Coba lagi": nama dipertahankan, jawaban direset.
  void retry() {
    _resetProgress();
    notifyListeners();
  }

  /// Kembali ke beranda: hapus semuanya.
  void reset() {
    _userName = '';
    _resetProgress();
    notifyListeners();
  }

  void _resetProgress() {
    _answers = List<int?>.filled(total, null);
    _currentIndex = 0;
    _finished = false;
  }
}
