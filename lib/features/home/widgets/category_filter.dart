import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// شريط تصفية الاستبيانات حسب المجال.
class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.fields,
    required this.selected,
    required this.onChanged,
  });

  final List<String> fields;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: fields.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final field = fields[index];
          final isSelected = field == selected;
          return GestureDetector(
            onTap: () => onChanged(field),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.ink : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? AppColors.ink
                      : AppColors.clay.withValues(alpha: 0.45),
                ),
              ),
              child: Text(
                field,
                style: AppText.body(
                  13,
                  weight: FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.inkSoft,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
