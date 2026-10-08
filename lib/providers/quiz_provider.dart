import 'package:flutter/foundation.dart';
import '../models/question_model.dart';
import '../data/dummy_questions.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _score = 0;
  
  // State untuk melacak jawaban user. Key: questionId, Value: selectedOptionIndex
  final Map<String, int> _userAnswers = {};

  // Getters
  String get userName => _userName;
  int get score => _score;
  Map<String, int> get userAnswers => _userAnswers;
  
  // Method untuk set nama user
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  // Method untuk menjawab pertanyaan
  void answerQuestion(String questionId, int optionIndex) {
    _userAnswers[questionId] = optionIndex;
    notifyListeners();
  }

  // Cek apakah suatu soal sudah dijawab
  bool isQuestionAnswered(String questionId) {
    return _userAnswers.containsKey(questionId);
  }

  // Mengambil jawaban untuk suatu soal
  int? getSelectedOption(String questionId) {
    return _userAnswers[questionId];
  }

  // Menghitung total skor berdasarkan jawaban yang benar
  void calculateScore() {
    int total = 0;
    for (var question in dummyQuestions) {
      if (_userAnswers[question.id] == question.correctOptionIndex) {
        total += 20; // Asumsi 5 soal, masing-masing 20 poin
      }
    }
    _score = total;
    notifyListeners();
  }

  // Reset progress (saat mau "Main Lagi")
  void resetQuiz() {
    _userName = '';
    _score = 0;
    _userAnswers.clear();
    notifyListeners();
  }
}
