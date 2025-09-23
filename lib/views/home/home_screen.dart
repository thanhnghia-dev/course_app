import 'package:course_app/core/utils/util.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/services/User_service.dart';
import 'package:course_app/views/widgets/extension_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = await UserService().fetchUserInfo();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Hi, ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              _user?.fullName ?? 'User',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showOverlayToast(context, 'Chưa có thông báo nào!');
            },
            icon: const Icon(Icons.notifications_none, size: 30),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Danh sách tiện ích',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: ExtensionWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

