import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool obscure;
  final TextInputType keyboard;
  final String? Function(String?)? validator;

  const KTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.obscure = false,
    this.keyboard = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboard,
      validator: validator,
      style: AppTextStyles.bodyPrimary,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon, color: AppColors.textTertiary, size: 20),
        suffixIcon: suffixIcon != null
            ? GestureDetector(onTap: onSuffixTap, child: Icon(suffixIcon, color: AppColors.textTertiary, size: 20))
            : null,
      ),
    );
  }
}
