import 'package:flutter/material.dart';

class AddSurveyScreen extends StatelessWidget {
  const AddSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اضافة استبيان جديد')),
      body: const Center(child: Text('صفحة الاضافة')),
    );
  }
}
