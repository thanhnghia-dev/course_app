import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/core/utils/util.dart';
import 'package:course_app/services/user_service.dart';
import 'package:course_app/views/auth/login_screen.dart';
import 'package:course_app/views/widgets/label_with_asterisk_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final UserService _userService = UserService();

  bool _obscureText = true;
  bool _obscureConfText = true;

  Future<void> _saveButton() async {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");

    if (username == null || username.isEmpty) {
      showOverlayToast(context, 'Không tìm thấy tên đăng nhập');
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      showOverlayToast(context, 'Vui lòng nhập đầy đủ mật khẩu');
      return;
    }

    if (password != confirmPassword) {
      showOverlayToast(context, 'Mật khẩu xác nhận không khớp');
      return;
    }

    String? result = await _userService.resetPassword(
      username: username,
      password: password,
    );

    if (result == 'Đổi mật khẩu thành công') {
      showOverlayToast(context, 'Đổi mật khẩu thành công');

      await prefs.clear();

      await Future.delayed(const Duration(seconds: 1));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      showOverlayToast(context, result ?? 'Đổi mật khẩu thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Đặt lại mật khẩu',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelWithAsterisk(label: 'Mật khẩu mới', isRequired: true),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Nhập mật khẩu mới của bạn',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.silverGray,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                const SizedBox(height: 5),
                Text(
                  'Mật khẩu phải bao gồm:\n'
                  '  * 8-20 ký tự\n'
                  '  * Ít nhất một chữ số\n'
                  '  * Ít nhất một chữ viết hoa\n'
                  '  * Ít nhất một ký tự đặc biệt (e.g. !@#&%)\n'
                  '  * Không khoảng trắng',
                  style: TextStyle(
                    color: Color(0xff3F4F4F),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 15),
                const LabelWithAsterisk(label: 'Xác nhận lại mật khẩu', isRequired: true),
                const SizedBox(height: 8),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Nhập lại mật khẩu của bạn',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.silverGray,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfText = !_obscureConfText;
                        });
                      },
                    ),
                  ),
                  obscureText: _obscureConfText,
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: _saveButton,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        'Lưu thay đổi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
