import 'package:course_app/models/course_model.dart';
import 'package:course_app/services/course_service.dart';
import 'package:flutter/material.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  Course? _course;
  bool _isLoading = false;

  List<Course> get courses => _courses;
  Course? get course => _course;
  bool get isLoading => _isLoading;

  // Load all courses
  Future<void> loadCourses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _courses = await CourseService().fetchCourses();
    } catch (e) {
      _courses = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load course by classId
  Future<void> loadCourse(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _course = await CourseService().fetchCourseById(id);
    } catch (e) {
      _course = null;
    }

    _isLoading = false;
    notifyListeners();
  }

}
