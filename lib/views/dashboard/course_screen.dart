import 'package:course_app/views/widgets/course_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Quản lý Khóa học',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: CourseItemsWidget(),
    );
  }
}
