import 'package:course_app/views/widgets/attendance_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Lịch sử điểm danh',
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
          _buildStatisticHeading(),
          
          Expanded(child: SingleChildScrollView(child: AttendanceItemsWidget())),
        ],
      ),
    );
  }

  Widget _buildStatisticHeading() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderSearch, width: 1),
      ),
      child: Row(
        children: [
          Text(
            '48',
          ),
        ],
      ),
    );
  }
}
