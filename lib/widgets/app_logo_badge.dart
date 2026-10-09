import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Logo TembakTanya (aset `assets/images/icon_aplikasi.svg`).
class AppLogoBadge extends StatelessWidget {
  const AppLogoBadge({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/icon_aplikasi.svg',
      width: size,
      height: size,
      semanticsLabel: 'Logo TembakTanya',
    );
  }
}
