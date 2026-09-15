import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../models/survey.dart';

/// بطاقة الاستبيان اللي عيّنته قاربت تكتمل — أبرز عنصر في الشاشة.
class FeaturedSurveyCard extends StatelessWidget {
  const FeaturedSurveyCard({super.key, required this.survey, this.onStart});

  final Survey survey;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          const Positioned.fill(child: ColoredBox(color: AppColors.coral)),
          PositionedDirectional(
            top: -46,
            start: -34,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.schedule_rounded,
                          size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        'يقفل بعد ${survey.closesIn ?? 'قليل'}',
                        style: AppText.body(11.5,
                            weight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  survey.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.heading(18, color: Colors.white, height: 1.45),
                ),
                const SizedBox(height: 8),
                Text(
                  'باقي ${survey.remaining} مشارك فقط لاكتمال العيّنة',
                  style: AppText.body(13, color: Colors.white.withOpacity(0.9)),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      '${survey.reward} ر.س',
                      style: AppText.heading(20, color: Colors.white),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: onStart ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.coral,
                        elevation: 0,
                        minimumSize: const Size(120, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: AppText.heading(14.5),
                      ),
                      child: const Text('ابدأ الحين'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
