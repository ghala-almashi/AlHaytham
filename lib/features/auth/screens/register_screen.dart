import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/AlHaytham_button.dart';
import '../../../core/widgets/AlHaytham_text_field.dart';
import '../../home/screens/home_screen.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  static const _ageGroups = ['18 - 24', '25 - 34', '35 - 44', '45 فأكثر'];
  static const _genders = ['أنثى', 'ذكر'];

  String _ageGroup = _ageGroups.first;
  String _gender = _genders.first;
  bool _agreed = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _register() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
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
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: true,
      title: 'سجّل كمشارك',
      subtitle: 'دقيقة وحدة وتبدأ تشارك في بحوث حقيقية وتكسب مقابلها.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AlHaythamTextField(
              controller: _name,
              label: 'الاسم',
              hint: 'الاسم الأول والأخير',
              icon: Icons.person_outline_rounded,
              validator: (value) =>
                  (value?.trim().isEmpty ?? true) ? 'اكتب اسمك' : null,
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
              validator: (value) =>
                  value != _password.text ? 'كلمتا المرور ما تطابقن' : null,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.blush,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الفئة العمرية',
                    style: AppText.heading(13, weight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  _ChoiceRow(
                    options: _ageGroups,
                    selected: _ageGroup,
                    onSelect: (v) => setState(() => _ageGroup = v),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'الجنس',
                    style: AppText.heading(13, weight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  _ChoiceRow(
                    options: _genders,
                    selected: _gender,
                    onSelect: (v) => setState(() => _gender = v),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'نستخدم هذي المعلومات عشان نرشّح لك الاستبيانات اللي تنطبق عليك فقط.',
                    style: AppText.body(12.5, color: AppColors.inkSoft),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
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
            AlHaythamButton(label: 'إنشاء الحساب', onPressed: _register),
          ],
        ),
      ),
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
    );
  }
}

/// صفّ خيارات قصيرة (الفئة العمرية / الجنس).
class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final isSelected = option == selected;
        return GestureDetector(
          onTap: () => onSelect(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.coral : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.coral
                    : AppColors.clay.withOpacity(0.5),
              ),
            ),
            child: Text(
              option,
              style: AppText.body(
                13,
                weight: FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.inkSoft,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
