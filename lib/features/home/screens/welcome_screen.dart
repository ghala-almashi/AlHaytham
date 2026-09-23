import 'package:alhaytham/core/theme/app_colors.dart';
import 'package:alhaytham/features/auth/screens/login_screen.dart';
import 'package:alhaytham/features/auth/screens/register_screen.dart';

import '../../../core/widgets/alhaytham_button.dart';

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

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  Center(
                    child: Image.asset(
                      'images/alhaytham_logo/logo.png',
                      width: 320,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'مرحبًا بك في تطبيق الهيثم',
                      style: TextStyle(
                        color: AppColors.inkSoft,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // ignore: avoid_print
                  const SizedBox(height: 200),
                  SizedBox(
                    width: 300,
                    child: AlHaythamButton(
                      label: 'إنشاء حساب جديد',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      soft: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: AlHaythamButton(
                      label: 'تسجيل الدخول',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
