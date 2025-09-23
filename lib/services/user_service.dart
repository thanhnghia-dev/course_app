import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:course_app/core/utils/constant.dart';
import 'package:course_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final baseUrl = Constant.api;

  // Get User info
  Future<User> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("No token found");
    }

    final response = await http.get(
      Uri.parse('$baseUrl/public/users/user-info'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load User');
    }
  }

  // Change password
  Future<String?> changePassword({required String newPassword}) async {
    var dio = Dio();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("No token found");
    }

    FormData formData = FormData.fromMap({"password": newPassword});

    try {
      var response = await dio.put(
        "$baseUrl/public/users/change-password",
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Đổi mật khẩu thành công";
      } else {
        return "Đổi mật khẩu thất bại. Mã lỗi: ${response.statusCode} - ${response.data}";
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.response?.data ?? e.message}");
      return "Dio error: ${e.response?.data ?? e.message}";
    } catch (e) {
      debugPrint("Other error: $e");
      return "Other error: $e";
    }
  }
  
  // Reset password
  Future<String?> resetPassword({
    required String username,
    required String password,
  }) async {
    var dio = Dio();

    FormData formData = FormData.fromMap({
      "password": password,
    });

    try {
      var response = await dio.put(
        "$baseUrl/public/users/reset-password?username=$username",
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          headers: {"Accept": "*/*"},
        ),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Đổi mật khẩu thành công";
      } else {
        return "Đổi mật khẩu thất bại. Mã lỗi: ${response.statusCode} - ${response.data}";
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.response?.data ?? e.message}");
      return "Dio error: ${e.response?.data ?? e.message}";
    } catch (e) {
      debugPrint("Other error: $e");
      return "Other error: $e";
    }
  }

}
