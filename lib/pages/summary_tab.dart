import 'package:flutter/material.dart';
import 'package:student_checkin_app/store/app_store.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: ListenableBuilder(
          listenable: studentsChanged,
          builder: (context, child) {
            return Text('All of students ${students.length}');
          }),
    );
  }
}
