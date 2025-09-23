import 'package:flutter/material.dart';
import 'package:course_app/models/course_model.dart';
import 'package:course_app/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CourseItemsWidget extends StatefulWidget {
  const CourseItemsWidget({super.key});

  @override
  State<CourseItemsWidget> createState() => _CourseItemsWidgetState();
}

class _CourseItemsWidgetState extends State<CourseItemsWidget> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<CourseProvider>(context, listen: false).loadCourses();
  }

  @override
  Widget build(BuildContext context) {
  final courseProvider = Provider.of<CourseProvider>(context);
  final courses = courseProvider.courses;

    return Container(
      height: 600,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final student = courses[index];
            return Column(
              children: [
                buildCardContainer(student),
                if (index < courses.length - 1) const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildCardContainer(Course course) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset('assets/course-icon.png', height: 30, width: 30),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course.courseId,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                course.name,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}