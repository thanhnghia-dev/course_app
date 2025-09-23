import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/core/utils/util.dart';
import 'package:course_app/views/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final usernameController = TextEditingController();

  void _confirmButton() async {
    String username = usernameController.text.trim();
    final prefs = await SharedPreferences.getInstance();
    
    if (username.isEmpty) {
      showOverlayToast(context, 'Vui lòng nhập Tên đăng nhập!');
    } else {
      await prefs.setString("username", username);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Quên mật khẩu',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tên đăng nhập',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Nhập tên đăng nhập của bạn',
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _confirmButton,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            'Xác nhận',
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
        ],
      ),
    );
  }
}
