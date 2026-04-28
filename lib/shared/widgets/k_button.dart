import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class KButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool outlined;
  final Color? bg;
  final Color? fg;
  final double height;
  final IconData? icon;

  const KButton({super.key, required this.label, this.onPressed, this.isLoading = false, this.outlined = false, this.bg, this.fg, this.height = 54, this.icon});

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
        : icon != null
            ? Row(mainAxisSize: MainAxisSize.min, children: [Text(label), const SizedBox(width: 8), Icon(icon, size: 18)])
            : Text(label);

    if (outlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity, height), foregroundColor: fg ?? AppColors.primary, side: BorderSide(color: fg ?? AppColors.primary, width: 1.5)),
        child: child,
      );
    }
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, height), backgroundColor: bg ?? AppColors.primary, foregroundColor: fg ?? Colors.white),
      child: child,
    );
  }
}
