import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------
/// الويدجت العام — هذا كل ما تحتاجينه لاستدعاء الشخصية
/// ---------------------------------------------------------------------
class RobotMascot extends StatelessWidget {
  /// عرض الشخصية بالبكسل — يُحسب الارتفاع تلقائياً بنفس نسبة الرسمة الأصلية
  final double size;

  /// زاوية الذراع اليمنى (للتلويح فقط — تُستخدم في الويلكم بيج).
  /// null = الذراع ثابتة، وهذا الوضع الافتراضي في باقي الشاشات.
  final double? rightArmAngle;

  const RobotMascot({super.key, this.size = 220, this.rightArmAngle});

  @override
  Widget build(BuildContext context) {
    final ratio =
        RobotMascotPainter.canvasSize.height /
        RobotMascotPainter.canvasSize.width;
    return SizedBox(
      width: size,
      height: size * ratio,
      child: CustomPaint(
        painter: RobotMascotPainter(rightArmAngle: rightArmAngle),
      ),
    );
  }
}

/// ---------------------------------------------------------------------
/// الرسّام — كل تفاصيل الشخصية الهندسية هنا
/// ---------------------------------------------------------------------
class RobotMascotPainter extends CustomPainter {
  /// زاوية الذراع اليمنى حول الكتف بالراديان، مقيسة من وضع التدلّي للأسفل.
  /// null = الوضع الثابت [restArmAngle].
  final double? rightArmAngle;

  const RobotMascotPainter({this.rightArmAngle});

  // الألوان
  static const Color accent = Color(0xFFFF9973);
  static const Color face = Color.fromARGB(255, 27, 35, 38);
  static const Color white = Color(0xFFFFF3F3);
  static const Color shadowColor = Color(0xFFB9B4C2);

  // نظام إحداثيات ثابت تُقاس منه كل الأشكال
  static const canvasSize = Size(220, 280);

  /// زاوية الذراع اليمنى في الوضع العادي (نفس الشكل القديم)
  static const double restArmAngle = 0.32;

  /// مكان كتف الذراع اليمنى (نقطة الدوران)
  static const Offset _rightShoulder = Offset(205.86, 164.27);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(
      size.width / canvasSize.width,
      size.height / canvasSize.height,
    );

    _drawLegs(canvas);
    _drawArms(canvas);
    _drawHeadWithBulb(canvas);
    _drawFace(canvas);

    canvas.restore();
  }

  // ---------------------------------------------------------------

  // ---------------------------------------------------------------
  /// الأرجل: قدمان متصلتان بقوس واحد (قطعة واحدة)
  void _drawLegs(Canvas canvas) {
    final paint = Paint()..color = accent;

    // القدمان
    final leftFoot = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(90, 220), width: 24, height: 50),
      const Radius.circular(12),
    );
    final rightFoot = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(130, 220), width: 24, height: 50),
      const Radius.circular(12),
    );
    canvas.drawRRect(leftFoot, paint);
    canvas.drawRRect(rightFoot, paint);
  }

  // ---------------------------------------------------------------
  /// الذراعان الجانبيتان: اليسرى ثابتة دائماً، واليمنى تدور حول الكتف
  void _drawArms(Canvas canvas) {
    final paint = Paint()..color = accent;

    // اليسرى — ثابتة
    _drawRotatedCapsule(
      canvas,
      center: const Offset(22, 188),
      width: 23,
      height: 50,
      radius: 13,
      angle: -0.32,
      paint: paint,
    );

    // اليمنى — تتدلّى من الكتف وتدور حوله.
    // بدون rightArmAngle تطلع بنفس الشكل القديم تماماً.
    canvas.save();
    canvas.translate(_rightShoulder.dx, _rightShoulder.dy);
    canvas.rotate(rightArmAngle ?? restArmAngle);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-11.5, 0, 23, 50),
        const Radius.circular(13),
      ),
      paint,
    );
    canvas.restore();
  }

  void _drawRotatedCapsule(
    Canvas canvas, {
    required Offset center,
    required double width,
    required double height,
    required double radius,
    required double angle,
    required Paint paint,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: width, height: height),
      Radius.circular(radius),
    );
    canvas.drawRRect(rrect, paint);
    canvas.restore();
  }

  // ---------------------------------------------------------------
  /// الرأس + نتوء اللمبة المتصل به بسلاسة أعلى الرأس
  void _drawHeadWithBulb(Canvas canvas) {
    final paint = Paint()..color = accent;

    // جسم الرأس (شكل مربّع مستدير الزوايا كثيراً ليقارب الدائرية)
    final head = RRect.fromRectAndRadius(
      Rect.fromLTRB(30, 55, 190, 215),
      const Radius.circular(56),
    );
    canvas.drawRRect(head, paint);

    // زجاجة اللمبة أعلى الرأس
    canvas.drawCircle(const Offset(155, 37), 20, paint);
  }

  // ---------------------------------------------------------------
  /// لوحة الوجه الدائرية + العينان + الابتسامة
  void _drawFace(Canvas canvas) {
    final facePaint = Paint()..color = const Color(0xFF626266);

    final face = RRect.fromRectAndRadius(
      Rect.fromLTRB(55, 80, 165, 190),
      const Radius.circular(35),
    );

    canvas.drawRRect(face, facePaint);

    final eyePaint = Paint()..color = const Color(0xFFF8F5F5);
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(85, 130), width: 26, height: 26),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(135, 130), width: 26, height: 26),
      eyePaint,
    );

    final mouth = Path()
      ..moveTo(100, 150)
      ..quadraticBezierTo(110, 165, 120, 150);

    canvas.drawPath(mouth, eyePaint);
  }

  // لازم تقارن الزاوية، وإلا ما بيعاد الرسم أثناء الحركة
  @override
  bool shouldRepaint(covariant RobotMascotPainter oldDelegate) =>
      oldDelegate.rightArmAngle != rightArmAngle;
}
