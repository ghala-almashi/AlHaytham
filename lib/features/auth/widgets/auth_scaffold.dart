import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/waving_robot.dart';

/// الهيكل المشترك لشاشتي الدخول والتسجيل.
///
/// تصميم مسطّح: خلفية بيج موحّدة، الشعار فوق، مكان محجوز للشخصية
/// (الروبوت) تحته، ثم النموذج مباشرة بدون أي بطاقة أو قبة.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.footer,
    this.showBack = false,
    this.mascot,
  });

  /// محتوى النموذج (الحقول والزر).
  final Widget child;

  /// عنوان اختياري فوق النموذج. اتركيه null (الوضع الافتراضي) إذا ما
  /// تبين عنوان يظهر — مثل شاشة إنشاء الحساب الجديدة.
  final String? title;
  final String? subtitle;

  final Widget? footer;
  final bool showBack;

  /// الشخصية (الروبوت) اللي تظهر تحت الشعار.
  /// اتركيها null ويظهر بدالها دائرة مرجانية فاضية كمكان محجوز.
  /// لاحقاً مرّري هنا مثلاً: `const RobotMascot(size: 170)`
  /// أو `const WavingRobot(size: 170)` في شاشة الترحيب.
  final Widget? mascot;

  // عدّلي هذي الأرقام لو تبين الشعار أو مكان الشخصية بحجم مختلف.
  static const String _logoPath = 'images/alhaytham_logo/logo.png';
  static const double _logoHeight = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blush,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showBack) const SizedBox(height: 44),

                  // الشعار
                  Center(
                    child: SizedBox(
                      height: _logoHeight,
                      child: Image.asset(
                        _logoPath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => Text(
                          'الهيثم',
                          style: AppText.heading(28, color: AppColors.aqua),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  // مكان الشخصية — دائرة مرجانية مؤقتة لحين ما تُضاف الروبوت
                  Center(child: const WavingRobot(size: 150)),

                  const SizedBox(height: 26),

                  if ((title ?? '').isNotEmpty) ...[
                    Text(title!, style: AppText.heading(22)),
                    if ((subtitle ?? '').isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(subtitle!, style: AppText.body(13.5)),
                    ],
                    const SizedBox(height: 20),
                  ],

                  child,

                  if (footer != null) ...[const SizedBox(height: 20), footer!],
                ],
              ),
            ),

            if (showBack)
              PositionedDirectional(
                top: 10,
                start: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  color: AppColors.ink,
                  tooltip: 'رجوع',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
