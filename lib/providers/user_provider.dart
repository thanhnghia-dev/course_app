import 'package:flutter/material.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  // Load User info
  Future<void> getUserInfo() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await UserService().fetchUserInfo();
    } catch (e) {
      _user = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}