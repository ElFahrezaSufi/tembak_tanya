import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String? iconPath; // Path untuk ikon SVG (opsional)

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    // Agar tombol mengambil lebar penuh, kita bungkus dengan SizedBox
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (iconPath != null) ...[
              const SizedBox(width: 12),
              SvgPicture.asset(
                iconPath!,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
