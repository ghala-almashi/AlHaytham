import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/alhaytham_button.dart';
import '../../../core/widgets/alhaytham_text_field.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _agreed = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ink,
          content: Text(
            'وافق على شروط المشاركة عشان نكمل',
            style: AppText.body(13.5, color: Colors.white),
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _email.text.trim(),
            password: _password.text,
          );

      final user = userCredential.user;
      final firstName = _firstName.text.trim();
      final lastName = _lastName.text.trim();

      if (user != null) {
        await user.updateDisplayName('$firstName $lastName'.trim());

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': _email.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'هذا البريد الإلكتروني مسجل مسبقًا';
          break;

        case 'invalid-email':
          message = 'البريد الإلكتروني غير صحيح';
          break;

        case 'weak-password':
          message = 'كلمة المرور ضعيفة، اختر كلمة مرور أقوى';
          break;

        case 'operation-not-allowed':
          message = 'تسجيل الدخول بالبريد الإلكتروني غير مفعّل في Firebase';
          break;

        case 'network-request-failed':
          message = 'تأكد من اتصال الإنترنت وحاول مرة ثانية';
          break;

        default:
          message = 'حدث خطأ أثناء إنشاء الحساب، حاول مرة ثانية';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ink,
          content: Text(
            message,
            style: AppText.body(13.5, color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.ink,
          content: Text(
            'حدث خطأ غير متوقع، حاول مرة ثانية',
            style: AppText.body(13.5, color: Colors.white),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: true,
      // بدون title/subtitle — مطابقة للتصميم الجديد اللي ما فيه عنوان فوق النموذج.
      // مكان الروبوت يجيك افتراضياً دائرة مرجانية؛ لما يصير عندك الملف
      // مرّري: mascot: const RobotMascot(size: 170),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('عندك حساب؟', style: AppText.body(13.5)),
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('سجّل دخولك'),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // الاسم الأول والأخير بصفّ واحد
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AlHaythamTextField(
                    controller: _firstName,
                    label: 'الاسم الأول',
                    hint: '',
                    icon: Icons.person_outline_rounded,
                    validator: (value) => (value?.trim().isEmpty ?? true)
                        ? 'اكتب اسمك الأول'
                        : null,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: AlHaythamTextField(
                    controller: _lastName,
                    label: 'الاسم الأخير',
                    hint: '',
                    icon: Icons.person_outline_rounded,
                    validator: (value) => (value?.trim().isEmpty ?? true)
                        ? 'اكتب اسمك الأخير'
                        : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            AlHaythamTextField(
              controller: _email,
              label: 'البريد الإلكتروني',
              hint: 'name@example.com',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final text = value?.trim() ?? '';

                if (text.isEmpty) {
                  return 'اكتب بريدك الإلكتروني';
                }

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
              hint: '8 أحرف على الأقل',
              icon: Icons.lock_outline_rounded,
              obscure: true,
              validator: (value) {
                if ((value ?? '').length < 8) {
                  return 'كلمة المرور 8 أحرف على الأقل';
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            AlHaythamTextField(
              controller: _confirm,
              label: 'تأكيد كلمة المرور',
              hint: 'أعد كتابة كلمة المرور',
              icon: Icons.lock_outline_rounded,
              obscure: true,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value != _password.text) {
                  return 'كلمتا المرور غير متطابقة';
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) {
                    setState(() {
                      _agreed = v ?? false;
                    });
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'أوافق على شروط المشاركة وسياسة الخصوصية، وإجاباتي تُستخدم لأغراض بحثية فقط.',
                      style: AppText.body(12.5, height: 1.5),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            AlHaythamButtonAqua(
              label: _isLoading ? 'جاري إنشاء الحساب...' : 'إنشاء الحساب',
              onPressed: _isLoading ? null : _register,
            ),
          ],
        ),
      ),
    );
  }
}
