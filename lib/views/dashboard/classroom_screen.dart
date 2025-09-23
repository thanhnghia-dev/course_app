import 'package:course_app/providers/course_provider.dart';
import 'package:course_app/views/widgets/class_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_app/core/theme/app_colors.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  int? selectedCourseId;

  @override
  void initState() {
    super.initState();
    Provider.of<CourseProvider>(context, listen: false).loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Quản lý Lớp học',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Consumer<CourseProvider>(
                    builder: (context, provider, child) {
                      return DropdownButtonFormField(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        value: selectedCourseId,
                        items: provider.courses
                            .map(
                              (course) => DropdownMenuItem(
                                value: course.id,
                                child: Text(course.name),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedCourseId = val;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: AppColors.primary,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText:
                              '---------------Chọn khóa học----------------',
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: ClassItemsWidget(courseId: selectedCourseId)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
