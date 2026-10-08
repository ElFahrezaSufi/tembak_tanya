import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionCard extends StatelessWidget {
  final String letter; // 'A', 'B', 'C', 'D'
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    
    // Warna untuk state terpilih dan tidak terpilih
    final Color borderColor = isSelected 
        ? theme.primaryColor 
        : (isDarkMode ? Colors.grey[700]! : Colors.grey[300]!);
    
    final Color bgColor = isSelected
        ? theme.primaryColor.withOpacity(0.1) // Efek highlight
        : (isDarkMode ? Colors.grey[850]! : Colors.white);
        
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Animasi estetik perpindahan state
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1.5),
        ),
        child: Row(
          children: [
            // Lingkaran huruf opsi (A/B/C/D)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : (isDarkMode ? Colors.grey[700] : Colors.grey[200]),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSelected ? Colors.white : (isDarkMode ? Colors.grey[300] : Colors.grey[700]),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Teks jawaban
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            
            // Ikon checklist kalau dipilih
            if (isSelected)
              SvgPicture.asset(
                'assets/icons/circle-check.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
              ),
          ],
        ),
      ),
    );
  }
}
