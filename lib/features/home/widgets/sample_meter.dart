import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// مؤشّر اكتمال العيّنة — العنصر المميّز لبطاقة الاستبيان.
class SampleMeter extends StatelessWidget {
  const SampleMeter({
    super.key,
    required this.ratio,
    required this.percent,
    required this.remaining,
  });

  final double ratio;
  final int percent;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 6,
            backgroundColor: AppColors.clay.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.aqua),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'اكتمل $percent٪ من العيّنة، باقي $remaining مشارك',
          style: AppText.body(12, color: AppColors.inkSoft),
        ),
      ],
    );
  }
}
