import 'package:flutter/material.dart';
import 'package:course_app/views/dashboard/attendance_screen.dart';
import 'package:course_app/views/dashboard/classroom_screen.dart';
import 'package:course_app/views/student/student_screen.dart';
import 'package:course_app/views/dashboard/course_screen.dart';

class ExtensionWidget extends StatelessWidget {
  const ExtensionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<String> titles = [
      'Khóa học',
      'Lớp học',
      'Học viên',
      'Điểm danh',
    ];

    final List<String> icons = [
      'assets/course-icon.png',
      'assets/classroom-icon.png',
      'assets/student-icon.png',
      'assets/attendance-icon.png',
    ];

    final List<Widget> views = [
      const CourseScreen(),
      const ClassroomScreen(),
      const StudentScreen(),
      const AttendanceScreen(),
    ];

    return SizedBox(
      height: 350,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.5,
        ),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => views[index]),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xffFFEAE4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(icons[index], height: 90, width: 90),
                  Text(
                    titles[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
