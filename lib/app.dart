import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/providers/auth_provider.dart';
import 'package:course_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:course_app/views/widgets/navigation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.isAuth) {
        // Logged in → Access NavigationMenu
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NavigationMenu()),
        );
      } else {
        // Not logged in yet → Access LoginScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo-lp.png',
              height: 300,
              width: 300,
            ),
            Text(
              'Tin Học LP',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}