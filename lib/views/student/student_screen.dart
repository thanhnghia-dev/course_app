import 'package:course_app/views/widgets/student_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/providers/classroom_provider.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  int? selectedClassroomId;

  @override
  void initState() {
    super.initState();
    Provider.of<ClassroomProvider>(context, listen: false).loadClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Quản lý Học viên',
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Consumer<ClassroomProvider>(
              builder: (context, provider, child) {
                return DropdownButtonFormField<int>(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  value: selectedClassroomId,
                  items: provider.classrooms
                      .map(
                        (classroom) => DropdownMenuItem<int>(
                          value: classroom.id,
                          child: Text(classroom.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedClassroomId = val;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: AppColors.primary,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: '---------------Chọn lớp học----------------',
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: StudentItemsWidget(classroomId: selectedClassroomId),
          ),
        ],
      ),
    );
  }
}
