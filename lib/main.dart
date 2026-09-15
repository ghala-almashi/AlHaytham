import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';

void main() => runApp(const BahethApp());

class BahethApp extends StatelessWidget {
  const BahethApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'باحث',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
      // التطبيق كامل من اليمين لليسار
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
