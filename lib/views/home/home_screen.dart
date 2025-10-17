import 'package:course_app/core/utils/util.dart';
import 'package:course_app/providers/user_provider.dart';
import 'package:course_app/views/widgets/extension_widget.dart';
import 'package:flutter/material.dart';
import 'package:course_app/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Xin chào, ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              user?.fullName ?? '',
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
