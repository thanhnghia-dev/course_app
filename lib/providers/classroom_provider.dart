import 'package:flutter/material.dart';
import 'package:course_app/models/classroom_model.dart';
import 'package:course_app/services/classroom_service.dart';

class ClassroomProvider with ChangeNotifier {
  List<Classroom> _classrooms = [];
  Classroom? _classroom;
  bool _isLoading = false;

  List<Classroom> get classrooms => _classrooms;
  Classroom? get classroom => _classroom;
  bool get isLoading => _isLoading;

  // Load all classrooms
  Future<void> loadClassrooms() async {
    _isLoading = true;
    notifyListeners();

    try {
      _classrooms = await ClassroomService().fetchClassrooms();
    } catch (e) {
      _classrooms = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load all classrooms by course
  Future<void> loadClassroomsByCourse(int courseId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _classrooms = await ClassroomService().fetchClassroomsByCourseId(courseId);
    } catch (e) {
      _classrooms = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load classroom by classId
  Future<void> loadClassroomInfo(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _classroom = await ClassroomService().fetchClassroomById(id);
    } catch (e) {
      _classroom = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}