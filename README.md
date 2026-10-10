# TembakTanya

Aplikasi kuis pilihan ganda berbasis Flutter — **UTS Lab 5 Pemrograman Mobile**.

## Identitas Mahasiswa

| | |
|---|---|
| **Nama** | El Fahreza Sufi |
| **NIM** | 241401042 |
| **Lab** | PM 5 |

## Informasi Aplikasi

**Nama Aplikasi:** TembakTanya

**Deskripsi singkat:** TembakTanya adalah aplikasi kuis pilihan ganda untuk menguji pemahaman dasar Flutter. Pengguna memasukkan nama, menjawab 10 soal pilihan ganda satu per satu, lalu melihat skor akhir beserta pembahasan tiap soal. Tidak memerlukan akun, database, maupun koneksi internet.

### Fitur

- **Splash screen** dengan logo dan tagline.
- **Input nama** dengan validasi (nama kosong ditolak, pesan error ditampilkan).
- **10 soal dasar Flutter**; satu layar kuis yang kontennya berganti (bukan satu file per soal).
- **Progres bersegmen** + jumlah soal terjawab; jawaban bisa diubah dan soal bisa dikunjungi ulang sebelum selesai.
- **Konfirmasi selesai** (bottom sheet) hanya muncul saat 10/10 soal terjawab.
- **Skor akhir** (cincin skor animasi, jumlah benar/salah).
- **Tinjau jawaban**: pembahasan benar/salah tiap soal, navigasi nomor soal, soal salah ditandai.
- **Coba lagi** / **Kembali ke beranda**, serta **Lanjutkan sesi** jika kuis belum selesai.
- **Progres tidak hilang** saat layar dirotasi atau berpindah halaman (state di Provider).
- **Dark / Light mode** (bonus) dengan tombol toggle.
- **Adaptive & responsive** (bonus): layout ponsel, tablet (sidebar + kartu soal), dan browser (3 kolom).

### Pemenuhan Kriteria Wajib

| # | Kriteria | Implementasi |
|---|---|---|
| 1 | StatelessWidget & StatefulWidget | `SplashScreen`, `WelcomeScreen`, `ReviewScreen`, `AppTextField` (Stateful); sebagian besar widget lain Stateless |
| 2 | ≥ 2 halaman + navigasi | Splash, Sambutan, Kuis, Hasil, Tinjau — `go_router` (`lib/config/routes.dart`) |
| 3 | Widget reusable di file terpisah | `lib/widgets/` (`AppButton`, `AppTextField`, `OptionCard`, `QuizProgress`, `QuestionNavigator`, `StatTile`, `ScoreRing`, dst.) |
| 4 | Aset gambar / ikon | `assets/images/icon_aplikasi.svg`, `assets/icons/*.svg` (flutter_svg) |
| 5 | Font kustom | Inter (`assets/fonts/`, didaftarkan di `pubspec.yaml`) |
| 6 | Ukuran UI dinamis | `lib/utils/responsive.dart` (breakpoint + skala), `LayoutBuilder`, `Expanded/Flexible`, `MediaQuery` |
| 7 | State management | `provider` — `QuizProvider`, `ThemeProvider` |
| 8 | Tanpa database | Data soal lokal di `lib/data/dummy_questions.dart` |
| 9 | GitHub | Riwayat commit per fitur |
| 10 | Desain | Tampilan Mockup aplikasi dibuat menggunakan Figma |

## Struktur Proyek

```
assets/{fonts,icons,images}/  # tempat menyimpan fonts, icons, dan logo aplikasi
docs/{hp,tablet,web}/         # tempat menyimpan dokumentasi screenshot untuk setiap halaman
lib/
├── main.dart                 # entry point + provider + router
├── config/                   # app_theme, app_palette, routes
├── data/                     # dummy_questions (10 soal)
├── models/                   # Question
├── providers/                # QuizProvider, ThemeProvider
├── screens/                  # splash, welcome, quiz, result, review
├── utils/                    # responsive helper
└── widgets/                  # komponen reusable
test/                         # unit test provider + widget test alur aplikasi
```

## Menjalankan

```bash
flutter pub get
flutter run            # perangkat / emulator (HP, Tablet)
flutter run -d chrome  # tampilan web browser
flutter test
```

## Dokumentasi

### Credit Aset

- **Font:** [Inter](https://rsms.me/inter/) — SIL Open Font License 1.1.
- **Ikon UI:** [Lucide](https://lucide.dev/) — lisensi ISC.
- **Logo / ilustrasi:** dibuat sendiri pada mockup Figma (target + tanda tanya); ilustrasi sambutan disusun dari logo tersebut dan ikon Lucide.

### Screenshot Tiap Halaman

Seluruh dokumentasi screenshot untuk setiap halaman bisa dilihat pada direktori folder docs (/hp, /tablet, /web) atau bisa juga dilihat melalui folder Google Drive berikut:

https://drive.google.com/drive/folders/1NBItVGnb7o3_LlJx9c0hN3LpFqUCvYU9?usp=drive_link

### Mockup / Prototype

Berikut adalah link Figma untuk desain mockup aplikasi TembakTanya:

https://www.figma.com/design/2NZGoAMXkI0NeZ1sesHIwm/Aplikasi-TembakTanya?node-id=0-1&t=JgrppzKgvwr0bV3x-1
