import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// وسم مجال الاستبيان.
class FieldPill extends StatelessWidget {
  const FieldPill({super.key, required this.field});

  final String field;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.aqua.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        field,
        style: AppText.body(11.5, weight: FontWeight.w700, color: AppColors.aquaDeep),
      ),
    );
  }
}
