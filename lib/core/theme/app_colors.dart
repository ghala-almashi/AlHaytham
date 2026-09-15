import 'package:flutter/material.dart';

/// ألوان الهوية — مصدر واحد لكل الألوان في التطبيق.
class AppColors {
  AppColors._();

  // الألوان الأساسية من الهوية
  static const Color coral = Color(
    0xFFFF9973,
  ); // اللون الرئيسي (الأزرار والتمييز)
  static const Color aqua = Color(
    0xFF2ECFE0,
  ); // اللون الثانوي (تقدّم العيّنة والوسوم)
  static const Color blush = Color(0xFFFFF3F3); // خلفية الشاشات
  static const Color clay = Color(0xFFC4B2AE); // الحدود والنصوص الخافتة

  // ألوان مشتقة للقراءة والتباين
  static const Color ink = Color(0xFF3A2C28); // نص أساسي
  static const Color inkSoft = Color(0xFF7A6560); // نص ثانوي
  static const Color aquaDeep = Color(
    0xFF117C8B,
  ); // نص فوق خلفية الـ aqua الفاتحة
  static const Color danger = Color(0xFFD2553F);
}
