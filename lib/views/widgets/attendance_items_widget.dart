import 'package:course_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AttendanceItemsWidget extends StatefulWidget {
  const AttendanceItemsWidget({super.key});

  @override
  State<AttendanceItemsWidget> createState() => _AttendanceItemsWidgetState();
}

class _AttendanceItemsWidgetState extends State<AttendanceItemsWidget> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final courses = 12;

    return Container(
      height: 700,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: courses,
        itemBuilder: (context, index) {
          return Column(
            children: [
              buildCardContainer(),
            ],
          );
        },
      ),
    );
  }

  Widget buildCardContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 3,
        color: Colors.white,
        shadowColor: const Color(0xff303F4F4F),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.shadow, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 13, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'Họ và tên',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_month, size: 16, color: Colors.blueAccent),
                  SizedBox(width: 5),
                  Text(
                    'dd-mm-yyyy hh:mm:ss',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.silverGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
