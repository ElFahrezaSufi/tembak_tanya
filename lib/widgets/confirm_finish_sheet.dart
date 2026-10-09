import 'package:flutter/material.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_button.dart';
import 'app_icon.dart';

/// Menampilkan sheet konfirmasi "Siap lihat hasilnya?".
/// Mengembalikan `true` jika pengguna memilih menyelesaikan kuis.
Future<bool> showConfirmFinishSheet(
  BuildContext context, {
  required String name,
  required int answered,
  required int total,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: 520),
    builder: (_) => ConfirmFinishSheet(name: name, answered: answered, total: total),
  );
  return result ?? false;
}

class ConfirmFinishSheet extends StatelessWidget {
  const ConfirmFinishSheet({
    super.key,
    required this.name,
    required this.answered,
    required this.total,
  });

  final String name;
  final int answered;
  final int total;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final pad = context.rs(24);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.rs(64),
              height: context.rs(64),
              decoration: BoxDecoration(
                color: p.accentSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: AppIcon('clipboard-check', size: context.rs(30), color: p.primary),
            ),
            SizedBox(height: context.rs(20)),
            Text(
              'Siap lihat hasilnya?',
              style: TextStyle(
                color: p.ink,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: context.rs(10)),
            Text(
              'Semua $total soal sudah terjawab. Periksa lagi atau akhiri kuis untuk melihat skor $name.',
              style: TextStyle(color: p.muted, fontSize: 15, height: 1.45),
            ),
            SizedBox(height: context.rs(18)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.rs(16),
                vertical: context.rs(14),
              ),
              decoration: BoxDecoration(
                color: p.tint,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  AppIcon('check', size: context.rs(18), color: p.primary),
                  SizedBox(width: context.rs(10)),
                  Text(
                    '$answered/$total soal terjawab',
                    style: TextStyle(
                      color: p.primary,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.rs(14)),
            Text(
              'Setelah selesai, jawaban tidak bisa diubah.',
              style: TextStyle(color: p.muted, fontSize: 13),
            ),
            SizedBox(height: context.rs(18)),
            AppButton(
              label: 'Ya, selesaikan kuis',
              onPressed: () => Navigator.of(context).pop(true),
            ),
            SizedBox(height: context.rs(12)),
            AppButton(
              label: 'Kembali periksa',
              variant: AppButtonVariant.secondary,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}
