# TembakTanya

Aplikasi kuis pilihan ganda berbasis Flutter — **UTS Lab Pemrograman Mobile** (Semester Ganjil T.A. 2026/2027).

## Identitas Mahasiswa

| | |
|---|---|
| **Nama** | `[ISI NAMA LENGKAP]` |
| **NIM** | `[ISI NIM]` |
| **Lab** | PM 5 |

## Informasi Aplikasi

**Nama Aplikasi:** TembakTanya

**Deskripsi singkat:** TembakTanya adalah kuis lokal untuk menguji pemahaman dasar Flutter. Pengguna memasukkan nama, menjawab 10 soal pilihan ganda satu per satu, lalu melihat skor akhir beserta pembahasan tiap soal. Tidak memerlukan akun, database, maupun koneksi internet.

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

## Struktur Proyek

```
lib/
├── main.dart                 # entry point + provider + router
├── config/                   # app_theme, app_palette, routes
├── data/                     # dummy_questions (10 soal)
├── models/                   # Question
├── providers/                # QuizProvider, ThemeProvider
├── screens/                  # splash, welcome, quiz, result, review
├── utils/                    # responsive helper
└── widgets/                  # komponen reusable
assets/{fonts,icons,images}/
test/                         # unit test provider + widget test alur aplikasi
```

## Menjalankan

```bash
flutter pub get
flutter run            # perangkat / emulator
flutter run -d chrome  # tampilan browser
flutter test
```

## Dokumentasi

### Credit Aset

- **Font:** [Inter](https://rsms.me/inter/) — SIL Open Font License 1.1.
- **Ikon UI:** [Lucide](https://lucide.dev/) — lisensi ISC.
- **Logo / ilustrasi:** dibuat sendiri pada mockup Figma (target + tanda tanya); ilustrasi sambutan disusun dari logo tersebut dan ikon Lucide.

### Screenshot Tiap Halaman

> Ganti dengan screenshot dari emulator/perangkat (simpan di `docs/screenshots/`).

| Halaman | Screenshot |
|---|---|
| Splash | `docs/screenshots/01_splash.png` |
| Sambutan (+ validasi) | `docs/screenshots/02_welcome.png` |
| Kuis | `docs/screenshots/03_quiz.png` |
| Konfirmasi selesai | `docs/screenshots/04_confirm.png` |
| Hasil | `docs/screenshots/05_result.png` |
| Tinjau jawaban | `docs/screenshots/06_review.png` |
| Mode gelap | `docs/screenshots/07_dark.png` |
| Tablet / Browser | `docs/screenshots/08_tablet.png`, `docs/screenshots/09_browser.png` |

### Mockup / Prototype

`[ISI LINK FIGMA MOCKUP]`
