import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const AlHaithamApp());

class AlHaithamApp extends StatelessWidget {
  const AlHaithamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الهيثم',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Cairo'),
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar')],
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: WelcomeScreen(),
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// الألوان
/// ---------------------------------------------------------------------
class AppColors {
  static const creamTop = Color(0xFFFDF1EC);
  static const cream = Color(0xFFFDEEE9);
  static const coral = Color(0xFFEFA285);
  static const teal = Color(0xFF5FBDC4);
  static const tealDeep = Color(0xFF2F7C82);
  static const tealOutline = Color(0xFF3F8A8F);
  static const tagline = Color(0xFFA89D97);
  static const outlineText = Color(0xFF9C8F89);

  static const mascotLight = Color(0xFFE9B492);
  static const mascotMid = Color(0xFFD99A78);
  static const mascotDeep = Color(0xFFC67F5C);
  static const mascotShadow = Color(0xFFA9613F);

  static const glowCore = Color(0xFFFFF0CE);
  static const glowMid = Color(0xFFFFCF93);
  static const glowOuter = Color(0xFFFFB27A);

  static const bulbGlass = Color(0xFFFFF6DC);
  static const bulbGlassEdge = Color(0xFFFFD98C);
  static const bulbMetal = Color(0xFFC9A163);
  static const bulbMetalDeep = Color(0xFF9E7A45);
}

/// ---------------------------------------------------------------------
/// الشاشة الرئيسية
/// ---------------------------------------------------------------------
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية متدرجة
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.creamTop, AppColors.cream],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 28),
                const LogoPlaceholder(),
                const SizedBox(height: 14),
                const Text(
                  'هنا جملة مفتاحية',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tagline,
                  ),
                ),
                const Expanded(child: Center(child: GlowingMascot(size: 190))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 46),
                  child: Column(
                    children: [
                      _PrimaryButton(label: 'تسجيل دخول', onTap: () {}),
                      const SizedBox(height: 16),
                      _OutlineButton(label: 'انشاء حساب', onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LogoPlaceholder extends StatelessWidget {
  const LogoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('images/alhaytham_logo/logo.png', width: 120, height: 120),
      ],
    );
  }
}

/// ---------------------------------------------------------------------
/// الأزرار
/// ---------------------------------------------------------------------
class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.teal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
            side: const BorderSide(color: AppColors.tealDeep, width: 2),
          ),
          elevation: 4,
          shadowColor: AppColors.tealDeep.withValues(alpha: 0.35),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFFDF6F3),
          foregroundColor: AppColors.outlineText,
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          side: const BorderSide(color: AppColors.tealOutline, width: 2),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

/// =======================================================================
/// GlowingMascot — المكوّن القابل لإعادة الاستخدام
/// انسخي هذا القسم كاملاً (حتى نهاية الملف) لاستخدام الشخصية بأي شاشة أخرى
/// =======================================================================
class GlowingMascot extends StatefulWidget {
  final double size;
  const GlowingMascot({super.key, this.size = 190});

  @override
  State<GlowingMascot> createState() => _GlowingMascotState();
}

class _GlowingMascotState extends State<GlowingMascot>
    with TickerProviderStateMixin {
  late final AnimationController _waveCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _floatCtrl;

  @override
  void initState() {
    super.initState();
    _waveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _waveCtrl.dispose();
    _glowCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const aspect = 240 / 210;
    return AnimatedBuilder(
      animation: Listenable.merge([_waveCtrl, _glowCtrl, _floatCtrl]),
      builder: (context, _) {
        final waveAngle = math.sin(_waveCtrl.value * 2 * math.pi) * 0.36;
        final glowT = Curves.easeInOut.transform(_glowCtrl.value);
        final floatY =
            (Curves.easeInOut.transform(_floatCtrl.value) - 0.5) * 10;
        return Transform.translate(
          offset: Offset(0, floatY),
          child: CustomPaint(
            size: Size(widget.size, widget.size * aspect),
            painter: _MascotPainter(waveAngle: waveAngle, glowT: glowT),
          ),
        );
      },
    );
  }
}

class _MascotPainter extends CustomPainter {
  final double waveAngle; // بالراديان، ليد التلويح
  final double glowT; // 0..1 لنبضة التوهّج

  _MascotPainter({required this.waveAngle, required this.glowT});

  // نظام إحداثيات ثابت 210 × 240 يُقاس منه كل شيء
  static const canvasSize = Size(210, 240);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(
      size.width / canvasSize.width,
      size.height / canvasSize.height,
    );

    _drawGlow(canvas);
    _drawSparkles(canvas);
    _drawLegs(canvas);
    _drawRestingArm(canvas);
    _drawBody(canvas);
    _drawWavingArm(canvas);
    _drawLightbulbHead(canvas);
    _drawFace(canvas);

    canvas.restore();
  }

  void _drawGlow(Canvas canvas) {
    final center = const Offset(105, 145);
    final pulse = 0.9 + glowT * 0.22; // 0.9 .. 1.12

    // طبقات متعددة تعطي توهّجاً ناعماً وعميقاً بدل هالة باهتة واحدة
    final radii = [118.0 * pulse, 92.0 * pulse, 64.0 * pulse];
    final colors = [
      AppColors.glowOuter.withValues(alpha: 0.16 + glowT * 0.1),
      AppColors.glowMid.withValues(alpha: 0.30 + glowT * 0.16),
      AppColors.glowCore.withValues(alpha: 0.55 + glowT * 0.25),
    ];

    for (var i = 0; i < radii.length; i++) {
      final radius = radii[i];
      final color = colors[i];
      final paint = Paint()
        ..shader = RadialGradient(colors: [color, color.withValues(alpha: 0)])
            .createShader(Rect.fromCircle(center: center, radius: radius))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(center, radius, paint);
    }
  }

  void _drawSparkles(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5 + glowT * 0.5);
    _sparkle(canvas, const Offset(30, 58), 7, paint);
    _sparkle(canvas, const Offset(184, 42), 5.5, paint);
    _sparkle(canvas, const Offset(172, 104), 5, paint);
  }

  void _sparkle(Canvas canvas, Offset c, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      final outer = c + Offset(math.cos(angle), math.sin(angle)) * r;
      final inner =
          c +
          Offset(math.cos(angle + math.pi / 4), math.sin(angle + math.pi / 4)) *
              (r * 0.35);
      if (i == 0) {
        path.moveTo(outer.dx, outer.dy);
      } else {
        path.lineTo(outer.dx, outer.dy);
      }
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawLegs(Canvas canvas) {
    final paint = Paint()
      ..color = AppColors.mascotShadow
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(90, 206), const Offset(85, 236), paint);
    canvas.drawLine(const Offset(120, 206), const Offset(126, 236), paint);
  }

  void _drawBody(Canvas canvas) {
    final center = const Offset(105, 150);
    const radius = 62.0;
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.35, -0.4),
        colors: [
          AppColors.mascotLight,
          AppColors.mascotMid,
          AppColors.mascotDeep,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  /// اليد اليسرى — بوضعية استرخاء ثابتة بجانب الجسم
  void _drawRestingArm(Canvas canvas) {
    final paint = Paint()
      ..color = AppColors.mascotDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(52, 138)
      ..cubicTo(38, 152, 34, 168, 40, 182);
    canvas.drawPath(path, paint);

    final handPaint = Paint()
      ..shader =
          RadialGradient(colors: [AppColors.mascotLight, AppColors.mascotMid])
              .createShader(
                Rect.fromCircle(center: const Offset(41, 184), radius: 10),
              );
    canvas.drawCircle(const Offset(41, 184), 10, handPaint);
  }

  /// اليد اليمنى — تلوّح للمستخدم
  void _drawWavingArm(Canvas canvas) {
    final pivot = const Offset(158, 140);
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(waveAngle);
    canvas.translate(-pivot.dx, -pivot.dy);

    final paint = Paint()
      ..color = AppColors.mascotDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(150, 138)
      ..cubicTo(172, 126, 184, 104, 180, 84);
    canvas.drawPath(path, paint);

    final handPaint = Paint()
      ..shader =
          RadialGradient(colors: [AppColors.mascotLight, AppColors.mascotMid])
              .createShader(
                Rect.fromCircle(center: const Offset(180, 82), radius: 11),
              );
    canvas.drawCircle(const Offset(180, 82), 11, handPaint);

    canvas.restore();
  }

  /// رأس على شكل لمبة إضاءة واضحة: زجاجة + رقبة مضلعة + قاعدة معدنية + أشعة
  void _drawLightbulbHead(Canvas canvas) {
    const bulbCenter = Offset(103, 48);
    const bulbRadius = 17.0;

    // أشعة الضوء المنبعثة — تنبض مع التوهّج
    final rayPaint = Paint()
      ..color = AppColors.glowOuter.withValues(alpha: 0.35 + glowT * 0.45)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (final angle in [-1.0, -0.45, 0.45, 1.0, 3.14 + 0.5, 3.14 - 0.5]) {
      final dir = Offset(math.cos(angle), math.sin(angle));
      final start = bulbCenter + dir * (bulbRadius + 4);
      final end = bulbCenter + dir * (bulbRadius + 4 + 7 + glowT * 4);
      canvas.drawLine(start, end, rayPaint);
    }

    // رقبة اللمبة (تصل الزجاجة بالقاعدة)
    final neckPaint = Paint()..color = AppColors.bulbMetal;
    final neckPath = Path()
      ..moveTo(bulbCenter.dx - 9, 60)
      ..lineTo(bulbCenter.dx + 9, 60)
      ..lineTo(bulbCenter.dx + 6, 78)
      ..lineTo(bulbCenter.dx - 6, 78)
      ..close();
    canvas.drawPath(neckPath, neckPaint);

    // خطوط اللولب المعدني
    final threadPaint = Paint()
      ..color = AppColors.bulbMetalDeep
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(bulbCenter.dx - 8, 65),
      Offset(bulbCenter.dx + 8, 65),
      threadPaint,
    );
    canvas.drawLine(
      Offset(bulbCenter.dx - 7.5, 70),
      Offset(bulbCenter.dx + 7.5, 70),
      threadPaint,
    );
    canvas.drawLine(
      Offset(bulbCenter.dx - 7, 75),
      Offset(bulbCenter.dx + 7, 75),
      threadPaint,
    );

    // العمود الواصل بالجسم
    final stemPaint = Paint()
      ..color = AppColors.mascotDeep
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(bulbCenter.dx, 78),
      const Offset(103, 92),
      stemPaint,
    );

    // زجاجة اللمبة نفسها
    final glassPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.4),
        colors: [Colors.white, AppColors.bulbGlass, AppColors.bulbGlassEdge],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: bulbCenter, radius: bulbRadius));
    canvas.drawCircle(bulbCenter, bulbRadius, glassPaint);

    final glassOutline = Paint()
      ..color = AppColors.mascotDeep.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(bulbCenter, bulbRadius, glassOutline);

    // فتيل بسيط داخل اللمبة
    final filamentPaint = Paint()
      ..color = AppColors.bulbMetalDeep.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final filament = Path()
      ..moveTo(bulbCenter.dx - 5, bulbCenter.dy + 4)
      ..cubicTo(
        bulbCenter.dx - 2,
        bulbCenter.dy - 4,
        bulbCenter.dx + 2,
        bulbCenter.dy + 6,
        bulbCenter.dx + 5,
        bulbCenter.dy - 3,
      );
    canvas.drawPath(filament, filamentPaint);
  }

  void _drawFace(Canvas canvas) {
    final eyePaint = Paint()..color = const Color(0xFF3D2B22);
    canvas.drawCircle(const Offset(85, 150), 5.5, eyePaint);
    canvas.drawCircle(const Offset(122, 150), 5.5, eyePaint);

    final highlightPaint = Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(83, 148), 1.6, highlightPaint);
    canvas.drawCircle(const Offset(120, 148), 1.6, highlightPaint);

    final mouthPaint = Paint()
      ..color = const Color(0xFF3D2B22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final mouth = Path()
      ..moveTo(88, 167)
      ..quadraticBezierTo(103, 177, 118, 167);
    canvas.drawPath(mouth, mouthPaint);

    final blushPaint = Paint()
      ..color = const Color(0xFFE98A63).withValues(alpha: 0.35);
    canvas.save();
    canvas.translate(70, 162);
    canvas.scale(1.4, 0.9);
    canvas.drawCircle(Offset.zero, 6, blushPaint);
    canvas.restore();
    canvas.save();
    canvas.translate(138, 162);
    canvas.scale(1.4, 0.9);
    canvas.drawCircle(Offset.zero, 6, blushPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MascotPainter oldDelegate) {
    return oldDelegate.waveAngle != waveAngle || oldDelegate.glowT != glowT;
  }
}
