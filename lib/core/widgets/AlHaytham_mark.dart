import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// شعار التطبيق: مربّع بحرف "ب" مع اسم المنصة.
class AlHaythamMark extends StatelessWidget {
  const AlHaythamMark({super.key, this.showWordmark = true});

  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.coral,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            'ب',
            style: AppText.heading(26, color: Colors.white, height: 1),
          ),
        ),
        if (showWordmark) ...[
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('باحث', style: AppText.heading(20, height: 1.2)),
              const SizedBox(height: 2),
              Text(
                'استبيانات بحثية موثوقة',
                style: AppText.body(12, color: AppColors.clay, height: 1.2),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
