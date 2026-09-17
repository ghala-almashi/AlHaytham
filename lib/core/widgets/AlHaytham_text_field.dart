import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// حقل إدخال بعنوان ثابت فوقه، مع إظهار/إخفاء كلمة المرور.
class AlHaythamTextField extends StatefulWidget {
  const AlHaythamTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscure = false,
    this.keyboardType,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  @override
  State<AlHaythamTextField> createState() => _AlHaythamTextFieldState();
}

class _AlHaythamTextFieldState extends State<AlHaythamTextField> {
  late bool _hidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppText.heading(13, weight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: _hidden,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          style: AppText.body(15, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(widget.icon, size: 20, color: AppColors.clay),
            suffixIcon: widget.obscure
                ? IconButton(
                    onPressed: () => setState(() => _hidden = !_hidden),
                    icon: Icon(
                      _hidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: AppColors.clay,
                    ),
                    tooltip: _hidden
                        ? 'إظهار كلمة المرور'
                        : 'إخفاء كلمة المرور',
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
