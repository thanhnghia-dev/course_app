import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:course_app/core/utils/constant.dart';
import 'package:course_app/models/student_model.dart';

class StudentService {
  final baseUrl = Constant.api;

  // Get all current Students
  Future<List<Student>> fetchStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/public/students'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Students');
    }
  }

  // Get all Students by classId
  Future<List<Student>> fetchStudentsByClassId(int classId) async {
    final response = await http.get(Uri.parse('$baseUrl/public/students/by-class?classId=$classId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Student.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Students');
    }
  }

}