/// Satu soal pilihan ganda.
class Question {
  final String id;

  /// Label kategori kecil di atas soal, mis. "WIDGET & INTERAKSI".
  final String category;
  final String text;
  final List<String> options;
  final int correctOptionIndex;

  /// Pembahasan yang ditampilkan di halaman "Tinjau jawaban".
  final String explanation;

  const Question({
    required this.id,
    required this.category,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });

  /// Huruf opsi: 0 -> A, 1 -> B, dst.
  static String letterOf(int index) => String.fromCharCode(65 + index);
}
