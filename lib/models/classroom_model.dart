import 'package:course_app/models/course_model.dart';

class Classroom {
  final int id;
  final String classId;
  final String name;
  final String startDate;
  final String endDate;
  final String examDate;
  final int status;
  final Course course;

  Classroom({
    required this.id,
    required this.classId,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.examDate,
    required this.status,
    required this.course,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'] ?? 0,
      classId: json['classId'] ?? '',
      name: json['name'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      examDate: json['examDate'] ?? '',
      status: json['status'] ?? '',
      course: json['course'] != null
          ? Course.fromJson(json['course'])
          : Course.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'classId': classId,
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'examDate': examDate,
      'status': status,
      'course': course,
    };
  }
  
  factory Classroom.empty() {
    return Classroom(
      id: 0,
      classId: '',
      name: '',
      startDate: '',
      endDate: '',
      examDate: '',
      status: 2,
      course: Course.empty(),
    );
  }
}