import 'dart:math' as math;

import 'package:flutter/material.dart';

// عدّلي المسار حسب مكان ملف الروبوت عندك
import 'robot_mascot.dart';

/// الروبوت وهو يلوّح — يُستخدم في الويلكم بيج فقط.
/// بدّلي `RobotMascot(size: ...)` بـ `WavingRobot(size: ...)` هناك.
class WavingRobot extends StatefulWidget {
  const WavingRobot({super.key, this.size = 220});

  final double size;

  @override
  State<WavingRobot> createState() => _WavingRobotState();
}

class _WavingRobotState extends State<WavingRobot>
    with SingleTickerProviderStateMixin {
  // مدة الدورة كاملة: ترفع يدها، تلوّح، تنزلها، وترتاح شوي
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 4200),
  )..repeat();

  static const double _rest = RobotMascotPainter.restArmAngle;

  // اليد مرفوعة للأعلى ومايلة شوي للخارج (0.3 راديان عن العمودي)
  static const double _up = 0.3 - math.pi;

  // مدى التلويح يمين ويسار
  static const double _swing = 0.32;

  double _lerp(double a, double b, double k) => a + (b - a) * k;

  double _angleAt(double t) {
    // 1) رفع اليد
    if (t < 0.14) {
      return _lerp(_rest, _up, Curves.easeInOut.transform(t / 0.14));
    }
    // 2) التلويح: 4 ذبذبات
    if (t < 0.64) {
      final u = (t - 0.14) / 0.50;
      return _up + _swing * math.sin(u * 2 * math.pi * 4);
    }
    // 3) إنزال اليد
    if (t < 0.78) {
      return _lerp(_up, _rest, Curves.easeInOut.transform((t - 0.64) / 0.14));
    }
    // 4) راحة قبل الدورة الجاية
    return _rest;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => RobotMascot(
        size: widget.size,
        rightArmAngle: _angleAt(_controller.value),
      ),
    );
  }
}
