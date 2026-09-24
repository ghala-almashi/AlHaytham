import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

class AlHaythamButton extends StatelessWidget {
  const AlHaythamButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.soft = false,
    this.height = 56,
    this.textStyle,
  });

  final String label;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final bool soft;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (soft) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            side: const BorderSide(color: AppColors.coral, width: 1.5),
            backgroundColor: AppColors.blush,
            foregroundColor: AppColors.coral,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: AppText.button(14.5, color: AppColors.coral),
          ),
          child: Text(label),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
