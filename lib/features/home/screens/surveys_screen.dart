import 'package:flutter/material.dart';

import 'add_survey_screen.dart';

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('استبياناتي')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('صفحة استبياناتي'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSurveyScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('إضافة استبيان جديد'),
            ),
          ],
        ),
      ),
    );
  }
}
