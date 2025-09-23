import 'package:flutter/material.dart';
import 'package:course_app/models/student_model.dart';
import 'package:course_app/services/student_service.dart';

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];
  Student? _student;
  bool _isLoading = false;

  List<Student> get students => _students;
  Student? get student => _student;
  bool get isLoading => _isLoading;

  // Load all Students
  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _students = await StudentService().fetchStudents();
    } catch (e) {
      _students = [];
    }

    _isLoading = false;
    notifyListeners();
  }
  
  // Load all Students by classroom
  Future<void> loadStudentsByClassroom(int classId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _students = await StudentService().fetchStudentsByClassId(classId);
    } catch (e) {
      _students = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}