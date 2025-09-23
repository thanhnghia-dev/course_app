import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:course_app/core/utils/constant.dart';
import 'package:course_app/models/classroom_model.dart';

class ClassroomService {
  final baseUrl = Constant.api;

  // Get all current classrooms
  Future<List<Classroom>> fetchClassrooms() async {
    final response = await http.get(Uri.parse('$baseUrl/public/classes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Classroom.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  // Get all current classrooms by courseId
  Future<List<Classroom>> fetchClassroomsByCourseId(int courseId) async {
    final response = await http.get(Uri.parse('$baseUrl/public/classes/by-course?courseId=$courseId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Classroom.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load classrooms');
    }
  }

  // Get classroom info by classId
  Future<Classroom> fetchClassroomById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/public/classes/$id'),);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Classroom.fromJson(data);
    } else {
      throw Exception('Failed to load classroom');
    }
  }
}