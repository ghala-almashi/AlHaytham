import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/baheth_mark.dart';

/// الهيكل المشترك لشاشتي الدخول والتسجيل.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.footer,
    this.showBack = false,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? footer;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blush,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showBack)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    // السهم يشير لليمين لأن الواجهة من اليمين لليسار
                    icon: const Icon(Icons.arrow_forward_rounded),
                    color: AppColors.ink,
                    tooltip: 'رجوع',
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              const BahethMark(),
              const SizedBox(height: 28),
              Text(title, style: AppText.heading(26)),
              const SizedBox(height: 8),
              Text(subtitle, style: AppText.body(14)),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.clay.withOpacity(0.3)),
                ),
                child: child,
              ),
              if (footer != null) ...[
                const SizedBox(height: 20),
                footer!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
