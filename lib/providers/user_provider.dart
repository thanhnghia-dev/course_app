import 'package:flutter/material.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/services/user_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  // Get User Information
  Future<void> getUserInfo() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await UserService().fetchUserInfo();
    } catch (e) {
      debugPrint('Lỗi khi tải thông tin user: $e');
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user after being edited
  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

}
