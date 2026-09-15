import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../data/dummy_surveys.dart';
import '../models/survey.dart';
import '../widgets/category_filter.dart';
import '../widgets/featured_survey_card.dart';
import '../widgets/survey_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _field = surveyFields.first;
  int _tab = 0;

  List<Survey> get _visibleSurveys {
    if (_field == surveyFields.first) return dummySurveys;
    return dummySurveys.where((s) => s.field == _field).toList();
  }

  @override
  Widget build(BuildContext context) {
    final surveys = _visibleSurveys;

    return Scaffold(
      backgroundColor: AppColors.blush,
      bottomNavigationBar: _BottomBar(
        current: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            const _GreetingBar(name: 'نورة'),
            const SizedBox(height: 18),
            const _SearchField(),
            const SizedBox(height: 22),
            const FeaturedSurveyCard(survey: featuredSurvey),
            const SizedBox(height: 26),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('استبيانات مفتوحة', style: AppText.heading(17)),
                const Spacer(),
                Text(
                  '${surveys.length} متاح لك',
                  style: AppText.body(12.5, color: AppColors.clay),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CategoryFilter(
              fields: surveyFields,
              selected: _field,
              onChanged: (value) => setState(() => _field = value),
            ),
            const SizedBox(height: 18),
            if (surveys.isEmpty)
              const _EmptyState()
            else
              ...surveys.map(
                (survey) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: SurveyCard(survey: survey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ترحيب أعلى الشاشة مع الصورة الرمزية والتنبيهات.
class _GreetingBar extends StatelessWidget {
  const _GreetingBar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.aqua.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            name.substring(0, 1),
            style: AppText.heading(18, color: AppColors.aquaDeep, height: 1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('أهلاً $name', style: AppText.heading(17, height: 1.2)),
              const SizedBox(height: 4),
              Text(
                'عندك 5 استبيانات تناسب ملفك اليوم',
                style: AppText.body(12.5, height: 1.2),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          tooltip: 'التنبيهات',
          icon: const Icon(Icons.notifications_none_rounded),
          color: AppColors.ink,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppText.body(14, color: AppColors.ink),
      decoration: const InputDecoration(
        hintText: 'دوّر على استبيان أو مجال',
        prefixIcon: Icon(Icons.search_rounded, size: 20, color: AppColors.clay),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.clay.withOpacity(0.28)),
      ),
      child: Column(
        children: [
          Icon(Icons.inbox_rounded, size: 34, color: AppColors.clay),
          const SizedBox(height: 14),
          Text(
            'ما فيه استبيانات مفتوحة في هذا المجال',
            textAlign: TextAlign.center,
            style: AppText.heading(15),
          ),
          const SizedBox(height: 8),
          Text(
            'جرّب مجال ثاني، أو فعّل التنبيهات ونخبرك أول ما ينزل استبيان جديد.',
            textAlign: TextAlign.center,
            style: AppText.body(13),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.current, required this.onChanged});

  final int current;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.clay.withOpacity(0.3)),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: current,
        onTap: onChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: AppColors.coral,
        unselectedItemColor: AppColors.clay,
        selectedLabelStyle:
            AppText.body(11, weight: FontWeight.w700, color: AppColors.coral),
        unselectedLabelStyle: AppText.body(11, color: AppColors.clay),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'استبياناتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'أرباحي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}
