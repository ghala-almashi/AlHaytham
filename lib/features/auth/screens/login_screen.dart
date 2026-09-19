import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/alhaytham_button.dart';
import '../../../core/widgets/alhaytham_text_field.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/auth_scaffold.dart';
import 'register_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _remember = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? 'حدث خطأ ما')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'أهلاً فيك مرة ثانية',
      subtitle: 'سجّل دخولك عشان تكمّل الاستبيانات اللي تناسب ملفك.',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ما عندك حساب؟', style: AppText.body(13.5)),
          TextButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
            child: const Text('أنشئ حساب مشارك'),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AlHaythamTextField(
              controller: _email,
              label: 'البريد الإلكتروني',
              hint: 'name@example.com',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'اكتب بريدك الإلكتروني';
                if (!text.contains('@') || !text.contains('.')) {
                  return 'البريد غير مكتمل، تأكد منه';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            AlHaythamTextField(
              controller: _password,
              label: 'كلمة المرور',
              hint: 'أدخل كلمة المرور',
              icon: Icons.lock_outline_rounded,
              obscure: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if ((value ?? '').isEmpty) return 'اكتب كلمة المرور';
                if ((value ?? '').length < 8) {
                  return 'كلمة المرور 8 أحرف على الأقل';
                }
                return null;
              },
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Checkbox(
                  value: _remember,
                  onChanged: (v) => setState(() => _remember = v ?? false),
                ),
                Text('خلّني مسجّل', style: AppText.body(13)),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('نسيت كلمة المرور؟'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            AlHaythamButton(label: 'تسجيل الدخول', onPressed: _login),
          ],
        ),
      ),
    );
  }
}
