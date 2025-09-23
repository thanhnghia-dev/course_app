import 'package:course_app/views/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Lịch công tác',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CalendarWidget(),
    );
  }
}
