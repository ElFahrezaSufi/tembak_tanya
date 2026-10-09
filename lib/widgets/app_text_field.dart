import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_palette.dart';
import '../utils/responsive.dart';
import 'app_icon.dart';

/// Kolom input bergaya mockup: ikon di kiri, border berubah saat fokus/error.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.iconName,
    this.hasError = false,
    this.onChanged,
    this.onSubmitted,
    this.maxLength = 24,
  });

  final TextEditingController controller;
  final String hintText;
  final String? iconName;
  final bool hasError;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int maxLength;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final focused = _focus.hasFocus;
    final Color borderColor = widget.hasError
        ? p.error
        : focused
            ? p.primary
            : p.border;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      padding: EdgeInsets.symmetric(horizontal: context.rs(16)),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderColor,
          width: (focused || widget.hasError) ? 2 : 1.2,
        ),
      ),
      child: Row(
        children: [
          if (widget.iconName != null) ...[
            AppIcon(widget.iconName!, size: context.rs(20), color: p.muted),
            SizedBox(width: context.rs(12)),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.words,
              inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
              cursorColor: p.primary,
              style: TextStyle(
                color: p.ink,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                hintText: widget.hintText,
                hintStyle: TextStyle(color: p.muted, fontWeight: FontWeight.w400),
                contentPadding: EdgeInsets.symmetric(vertical: context.rs(18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
