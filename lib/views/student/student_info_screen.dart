import 'package:course_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';

class StudentInfoScreen extends StatefulWidget {
  final dynamic student;

  const StudentInfoScreen({super.key, required this.student});

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final student = widget.student;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Thông tin học viên',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Expanded(
        child: Container(
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.network(
                    '${Constant.barcode}/${student.studentId}',
                    height: 120,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height: 20),
                buildInfoContainer(student),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoContainer(dynamic student) {
    
    Map<String, dynamic> getStatus(int status) {
      switch (status) {
        case 1:
          return {'text': 'Đang học', 'color': Colors.orange};
        case 2:
          return {'text': 'Hoàn thành', 'color': Colors.green};
        default:
          return {'text': 'Nghỉ học ngang', 'color': Colors.red};
      }
    }

    final status = getStatus(student.status);

    return Column(
      children: [
        _buildMenuItem(title: 'Mã HV', data: student.studentId),
        _buildMenuItem(title: 'Họ và tên', data: student.fullName),
        _buildMenuItem(title: 'Ngày sinh', data: formatDate(student.dob)),
        _buildMenuItem(title: 'Nơi sinh', data: student.birthPlace),
        _buildMenuItem(
          title: 'Giới tính',
          data: student.gender == 1 ? 'Nam' : 'Nữ',
        ),
        _buildMenuItem(title: 'Số điện thoại', data: student.phoneNumber),
        _buildMenuItem(title: 'Số CCCD', data: student.citizenId),
        _buildMenuItem(
          title: 'Trạng thái',
          data: status['text'],
          color: status['color'],
        ),
      ].map((item) => Column(
        children: [
          item,
          const Divider(height: 1),
        ],
      )).toList(),
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
          color: color,
        ),
      ),
    );
  }
}
