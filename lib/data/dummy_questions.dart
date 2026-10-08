import '../models/question_model.dart';

final List<Question> dummyQuestions = [
  const Question(
    id: 'q1',
    text: 'Apa kepanjangan dari widget "Stateless" dalam Flutter?',
    options: [
      'Widget yang selalu berubah-ubah bentuk',
      'Widget yang statis dan tidak memiliki state internal',
      'Widget yang mengambil data dari database',
      'Widget yang hanya bisa digunakan sekali'
    ],
    correctOptionIndex: 1,
  ),
  const Question(
    id: 'q2',
    text: 'Bahasa pemrograman utama yang digunakan untuk membuat aplikasi Flutter adalah?',
    options: [
      'Java',
      'Kotlin',
      'Dart',
      'Swift'
    ],
    correctOptionIndex: 2,
  ),
  const Question(
    id: 'q3',
    text: 'Manakah dari berikut ini yang BUKAN merupakan jenis widget di Flutter?',
    options: [
      'Container',
      'Scaffold',
      'Activity',
      'Text'
    ],
    correctOptionIndex: 2,
  ),
  const Question(
    id: 'q4',
    text: 'Untuk mengubah ukuran elemen agar fleksibel dan tidak terjadi overflow, widget apa yang sebaiknya digunakan di dalam Column/Row?',
    options: [
      'Flexible atau Expanded',
      'SizedBox',
      'Padding',
      'Align'
    ],
    correctOptionIndex: 0,
  ),
  const Question(
    id: 'q5',
    text: 'Apa fungsi utama dari "State Management" dalam pembuatan aplikasi?',
    options: [
      'Mengelola database lokal di memori HP',
      'Mengatur agar memori tidak penuh',
      'Mengelola status UI dan data agar tersinkronisasi antar layar',
      'Mendesain antarmuka aplikasi'
    ],
    correctOptionIndex: 2,
  ),
];
