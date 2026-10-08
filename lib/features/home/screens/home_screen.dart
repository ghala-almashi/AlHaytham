import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/survey_card.dart';
import 'surveys_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = '';
  int _tab = 0;

  /// جلب جميع الاستبيانات من Firebase Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> get _surveysStream {
    return FirebaseFirestore.instance.collection('surveys').snapshots();
  }

  Future<void> _getUserName() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        _userName = doc.data()?['name'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blush,

      bottomNavigationBar: _BottomBar(
        current: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),

      body: SafeArea(
        bottom: false,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _surveysStream,
          builder: (context, snapshot) {
            // أثناء تحميل البيانات
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                children: [
                  _GreetingBar(name: _userName),
                  const SizedBox(height: 22),
                  const _EmptyState(),
                ],
              );
            }

            final surveys = snapshot.data?.docs ?? [];

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              children: [
                _GreetingBar(name: _userName),

                const SizedBox(height: 22),

                // عرض الاستبيان المميز إذا كانت الاستبيانات موجودة
                if (surveys.isNotEmpty) ...[
                  // مؤقتًا نعرض أول استبيان
                  // سيتم ربطه بـ FeaturedSurveyCard بعد إنشاء Survey model
                  Text(
                    surveys.first.data()['title'] ?? 'بدون عنوان',
                    style: AppText.heading(17),
                  ),
                  const SizedBox(height: 26),
                ],

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

                const SizedBox(height: 18),

                // لا يوجد استبيانات
                if (surveys.isEmpty)
                  const _EmptyState()
                // يوجد استبيانات
                else
                  ...surveys.map((doc) {
                    doc.data();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: SurveyCard(
                        // مؤقتًا لا نرسل Survey هنا
                        // إلى أن يتم إنشاء Survey.fromFirestore
                        survey: throw UnimplementedError(
                          'Survey.fromFirestore سيتم إضافتها لاحقًا',
                        ),
                      ),
                    );
                  }),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// ترحيب أعلى الشاشة
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
            color: AppColors.aqua.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.person_rounded,
            size: 24,
            color: AppColors.aquaDeep,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('أهلاً $name', style: AppText.heading(17, height: 1.2)),
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

/// شاشة عدم وجود استبيانات
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        children: [
          Icon(Icons.inbox_rounded, size: 34, color: AppColors.clay),
          const SizedBox(height: 14),
          Text(
            'لا يوجد استبيانات مفتوحة',
            textAlign: TextAlign.center,
            style: AppText.heading(15),
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
          top: BorderSide(color: AppColors.clay.withValues(alpha: 0.3)),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: current,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: AppColors.coral,
        unselectedItemColor: AppColors.clay,
        selectedLabelStyle: AppText.body(
          11,
          weight: FontWeight.w700,
          color: AppColors.coral,
        ),
        unselectedLabelStyle: AppText.body(11, color: AppColors.clay),
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SurveysScreen()),
            );
            return;
          }

          if (index == 2) {
            // صفحة أرباحي
          } else if (index == 3) {
            // صفحة حسابي
          }

          onChanged(index);
        },
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
