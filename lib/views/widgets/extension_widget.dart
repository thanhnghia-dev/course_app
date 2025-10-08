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

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.65, // or 0.45
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 600 ? 3 : 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: screenWidth > 600 ? 1.3 : 1.2,
        ),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return _AnimatedGridItem(
            title: titles[index],
            iconPath: icons[index],
            destination: views[index],
            screenWidth: screenWidth,
          );
        },
      ),
    );
  }
}

class _AnimatedGridItem extends StatefulWidget {
  final String title;
  final String iconPath;
  final Widget destination;
  final double screenWidth;

  const _AnimatedGridItem({
    required this.title,
    required this.iconPath,
    required this.destination,
    required this.screenWidth,
  });

  @override
  State<_AnimatedGridItem> createState() => _AnimatedGridItemState();
}

class _AnimatedGridItemState extends State<_AnimatedGridItem> {
  bool _isPressed = false;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xffFFEAE4);
    final hoverColor = const Color(0xffFFD5C6);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: _isPressed ? (Matrix4.identity()..scale(0.96)) : Matrix4.identity(),
        curve: Curves.easeOut,
        child: Material(
          color: _isHovering ? hoverColor : baseColor,
          borderRadius: BorderRadius.circular(12),
          elevation: _isPressed ? 0 : 2,
          shadowColor: Colors.black26,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: Colors.orange.withOpacity(0.25),
            highlightColor: Colors.orange.withOpacity(0.1),
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapCancel: () => setState(() => _isPressed = false),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => widget.destination),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 3,
                    child: Image.asset(
                      widget.iconPath,
                      fit: BoxFit.contain,
                      width: widget.screenWidth * 0.22,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: widget.screenWidth * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
