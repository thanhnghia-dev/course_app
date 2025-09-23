import 'package:flutter/material.dart';
import 'package:course_app/models/classroom_model.dart';
import 'package:course_app/providers/classroom_provider.dart';
import 'package:provider/provider.dart';

class ClassItemsWidget extends StatefulWidget {
  final int? courseId;

  const ClassItemsWidget({super.key, this.courseId});

  @override
  State<ClassItemsWidget> createState() => _ClassItemsWidgetState();
}

class _ClassItemsWidgetState extends State<ClassItemsWidget> {
  
  @override
  void initState() {
    super.initState();
    if (widget.courseId != null) {
      context.read<ClassroomProvider>().loadClassroomsByCourse(widget.courseId!);
    }
  }

  @override
  void didUpdateWidget(ClassItemsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.courseId != widget.courseId && widget.courseId != null) {
      context.read<ClassroomProvider>().loadClassroomsByCourse(widget.courseId!);
    }
  }

  String formatDate(String dob) {
    try {
      final date = DateTime.parse(dob);
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    } catch (e) {
      return dob;
    }
  }

  // Class info dialog
  void _displayDetailDialog(Classroom classroom) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Thông tin lớp học',
          style: TextStyle(
            color: Colors.red,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMenuItem(title: 'Mã lớp', data: classroom.classId),
            _buildMenuItem(title: 'Tên lớp', data: classroom.name),
            _buildMenuItem(title: 'Ngày khai giảng', data: formatDate(classroom.startDate)),
            _buildMenuItem(title: 'Ngày kết thúc', data: formatDate(classroom.endDate)),
            _buildMenuItem(title: 'Ngày thi', data: formatDate(classroom.examDate)),
            _buildMenuItem(
              title: 'Trạng thái',
              data: classroom.status == 1 ? 'Đang diễn ra' : 'Kết thúc',
              color: classroom.status == 1 ? Colors.green : Colors.red,
            ),
          ].map((item) => Column(
            children: [
              item,
              const Divider(height: 1),
            ],
          )).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classroomProvider = Provider.of<ClassroomProvider>(context);
    final classrooms = classroomProvider.classrooms.reversed.toList();

    if (classroomProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (classrooms.isEmpty) {
      return const Center(
        child: Text(
          "Không có lớp học nào cho khóa này",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Container(
      height: 600,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: classrooms.length,
          itemBuilder: (context, index) {
            final classroom = classrooms[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () => _displayDetailDialog(classroom),
                  child: buildCardContainer(classroom),
                ),
                if (index < classrooms.length - 1) const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildCardContainer(Classroom classroom) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset('assets/classroom-icon.png', height: 30, width: 30),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      classroom.classId,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.info_outline, color: Colors.green[600]),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  classroom.name,
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
  
  Widget _buildMenuItem({required String title, required String data, Color? color}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      trailing: Text(
        data,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}