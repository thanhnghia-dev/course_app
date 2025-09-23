import 'dart:convert';

import 'package:course_app/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:course_app/core/utils/constant.dart';

class CourseService {
  final baseUrl = Constant.api;

  // Get all courses
  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/public/courses'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Get course info by courseId
  Future<Course> fetchCourseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/public/courses/$id'),);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Course.fromJson(data);
    } else {
      throw Exception('Failed to load course');
    }
  }
}