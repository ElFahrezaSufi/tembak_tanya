import '../models/question_model.dart';

/// Dataset lokal (dummy): 10 soal dasar Flutter. Tanpa database.
const List<Question> dummyQuestions = [
  Question(
    id: 'q1',
    category: 'BAHASA PEMROGRAMAN',
    text: 'Bahasa utama apa yang digunakan untuk membuat aplikasi Flutter?',
    options: ['Java', 'Dart', 'Kotlin', 'Swift'],
    correctOptionIndex: 1,
    explanation: 'Flutter menggunakan Dart untuk logika dan deklarasi UI.',
  ),
  Question(
    id: 'q2',
    category: 'WIDGET DASAR',
    text: 'Widget apa yang cocok untuk tampilan tanpa state yang berubah?',
    options: ['StatefulWidget', 'Scaffold', 'StatelessWidget', 'Navigator'],
    correctOptionIndex: 2,
    explanation: 'StatelessWidget tidak menyimpan state yang dapat berubah.',
  ),
  Question(
    id: 'q3',
    category: 'WIDGET & INTERAKSI',
    text:
        'Widget mana yang digunakan untuk UI yang dapat berubah saat pengguna berinteraksi?',
    options: ['StatelessWidget', 'StatefulWidget', 'Container', 'MaterialApp'],
    correctOptionIndex: 1,
    explanation:
        'StatefulWidget memiliki State yang dapat berubah. Saat state diperbarui melalui setState(), tampilan dapat dibangun ulang.',
  ),
  Question(
    id: 'q4',
    category: 'STATE',
    text: 'Metode apa yang memberi tahu Flutter bahwa state berubah?',
    options: ['build()', 'setState()', 'runApp()', 'dispose()'],
    correctOptionIndex: 1,
    explanation:
        'setState() menandai perubahan state dan menjadwalkan pembangunan ulang UI. build() menggambarkan tampilan, bukan memberi tahu perubahan state.',
  ),
  Question(
    id: 'q5',
    category: 'LAYOUT',
    text: 'Widget apa yang menyusun anak secara vertikal?',
    options: ['Row', 'Stack', 'Column', 'Padding'],
    correctOptionIndex: 2,
    explanation: 'Column menyusun widget pada sumbu vertikal.',
  ),
  Question(
    id: 'q6',
    category: 'STRUKTUR HALAMAN',
    text: 'Widget apa yang menyediakan struktur halaman Material?',
    options: ['Text', 'Scaffold', 'SizedBox', 'Icon'],
    correctOptionIndex: 1,
    explanation:
        'Scaffold menyediakan area seperti appBar, body, dan tombol mengambang.',
  ),
  Question(
    id: 'q7',
    category: 'NAVIGASI',
    text: 'Apa yang digunakan untuk membuka halaman baru pada Navigator?',
    options: ['Navigator.pop()', 'setState()', 'Navigator.push()', 'hot reload'],
    correctOptionIndex: 2,
    explanation:
        'push() menambahkan rute baru; pop() kembali ke rute sebelumnya.',
  ),
  Question(
    id: 'q8',
    category: 'LAYOUT',
    text: 'Widget apa yang membuat daftar panjang dapat digulir?',
    options: ['ListView', 'Center', 'Text', 'Row'],
    correctOptionIndex: 0,
    explanation: 'ListView menampilkan anak dalam daftar yang dapat digulir.',
  ),
  Question(
    id: 'q9',
    category: 'KONFIGURASI PROYEK',
    text: 'Di file mana aset dan font kustom Flutter didaftarkan?',
    options: ['main.dart', 'README.md', 'pubspec.yaml', 'analysis_options.yaml'],
    correctOptionIndex: 2,
    explanation: 'pubspec.yaml mendeklarasikan aset, font, dan dependensi proyek.',
  ),
  Question(
    id: 'q10',
    category: 'ALAT PENGEMBANGAN',
    text: 'Apa fungsi hot reload saat mengembangkan aplikasi?',
    options: [
      'Menghapus data pengguna',
      'Memperbarui UI tanpa mengulang aplikasi',
      'Membuat database',
      'Mengunggah ke toko aplikasi',
    ],
    correctOptionIndex: 1,
    explanation:
        'Hot reload menerapkan perubahan kode dan umumnya mempertahankan state.',
  ),
];
