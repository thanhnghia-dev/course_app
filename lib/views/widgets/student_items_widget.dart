import 'package:course_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:course_app/models/student_model.dart';
import 'package:course_app/providers/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:course_app/views/student/student_info_screen.dart';

class StudentItemsWidget extends StatefulWidget {
  final int? classroomId;

  const StudentItemsWidget({super.key, this.classroomId});

  @override
  State<StudentItemsWidget> createState() => _StudentItemsWidgetState();
}

class _StudentItemsWidgetState extends State<StudentItemsWidget> {
  final TextEditingController searchController = TextEditingController();
  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    if (widget.classroomId != null) {
      context.read<StudentProvider>().loadStudentsByClassroom(widget.classroomId!);
    }
  }

  @override
  void didUpdateWidget(StudentItemsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.classroomId != widget.classroomId && widget.classroomId != null) {
      context.read<StudentProvider>().loadStudentsByClassroom(widget.classroomId!);
    }
  }

  void _filterStudents(String query, List<Student> allStudents) {
    if (query.isEmpty) {
      setState(() {
        filteredStudents = allStudents;
      });
      return;
    }

    final results = allStudents.where((student) {
      final name = student.fullName.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredStudents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    final students = studentProvider.students;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          final allStudents = provider.students;
          
          final studentsToShow = filteredStudents.isEmpty && searchController.text.isEmpty
              ? allStudents
              : filteredStudents;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Tìm kiếm học viên...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) => _filterStudents(value, allStudents),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SizedBox(
                  height: 600,
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : studentsToShow.isEmpty
                      ? const Center(
                          child: Text(
                            "Không có học viên nào",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: studentsToShow.length,
                          itemBuilder: (context, index) {
                            final student = studentsToShow[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StudentInfoScreen(student: student),
                                      ),
                                    );
                                  },
                                  child: buildCardContainer(student),
                                ),
                                if (index < students.length - 1)
                                  const Divider(),
                              ],
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCardContainer(Student student) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset('assets/student-icon.png', height: 30, width: 30),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      student.studentId,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                    Icon(Icons.info_outline, color: Colors.green[600]),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  student.fullName,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}