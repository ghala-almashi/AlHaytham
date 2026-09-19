import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/alhaytham_button.dart';
import '../models/survey.dart';
import 'field_pill.dart';
import 'sample_meter.dart';

/// بطاقة استبيان في القائمة.
class SurveyCard extends StatelessWidget {
  const SurveyCard({super.key, required this.survey, this.onStart});

  final Survey survey;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.clay.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FieldPill(field: survey.field),
              const Spacer(),
              Text(
                '${survey.reward} ر.س',
                style: AppText.heading(16, color: AppColors.coral),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            survey.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.heading(15.5, height: 1.5),
          ),
          const SizedBox(height: 6),
          Text(
            '${survey.researcher}، ${survey.organization}',
            style: AppText.body(12.5, color: AppColors.clay),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _MetaItem(
                icon: Icons.schedule_rounded,
                text: '${survey.minutes} دقائق',
              ),
              const SizedBox(width: 18),
              _MetaItem(
                icon: Icons.help_outline_rounded,
                text: '${survey.questions} سؤال',
              ),
            ],
          ),
          const SizedBox(height: 16),
          SampleMeter(
            ratio: survey.fillRatio,
            percent: survey.fillPercent,
            remaining: survey.remaining,
          ),
          const SizedBox(height: 16),
          AlHaythamButton(
            label: 'شارك في الاستبيان',
            soft: true,
            height: 46,
            onPressed: onStart ?? () {},
          ),
        ],
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.clay),
        const SizedBox(width: 6),
        Text(text, style: AppText.body(12.5, color: AppColors.inkSoft)),
      ],
    );
  }
}
