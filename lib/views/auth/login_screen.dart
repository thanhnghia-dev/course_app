import 'package:course_app/core/utils/util.dart';
import 'package:course_app/views/auth/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/providers/auth_provider.dart';
import 'package:course_app/views/widgets/navigation_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  Future<void> _loginButton() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showOverlayToast(context, "Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.login(username, password);

      if (authProvider.isAuth) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const NavigationMenu()),
          );
        }
      } else {
        showOverlayToast(
          context,
          "Sai tên đăng nhập hoặc mật khẩu.",
        );
      }
    } catch (e) {
      showOverlayToast(context, "Đăng nhập thất bại!");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Tin Học LP',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 23,
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nhập tên đăng nhập',
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Mật khẩu',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Nhập mật khẩu',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.silverGray,
                            ),
                            onPressed: () =>
                                setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const ForgotPasswordScreen()),
                              );
                            },
                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? Center(child: const CircularProgressIndicator())
                          : GestureDetector(
                              onTap: _loginButton,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Đăng nhập',
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
      ),
    );
  }
}
