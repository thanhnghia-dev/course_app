import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/providers/auth_provider.dart';
import 'package:course_app/services/User_service.dart';
import 'package:course_app/views/auth/change_password_screen.dart';
import 'package:course_app/views/auth/login_screen.dart';
import 'package:course_app/views/profile/edit_profile_screen.dart';
import 'package:course_app/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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

  // Logout Button
  void _logoutButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.red,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Bạn có chắc muốn đăng xuất?',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Đóng'),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.silverGray),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: const Text('Đóng'),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();

              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppColors.primary),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: const Text(
              'Đồng ý',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _user == null
          ? const Center(child: CircularProgressIndicator()) // loading
          : Stack(
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileCard(context, _user!),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: AppColors.borderContainer,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _buildMenuItem(
                                      icon: Icons.person_outline,
                                      title: 'Chỉnh sửa hồ sơ',
                                      onTap: () {
                                        if (_user != null) {
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  EditProfileScreen(user: _user!),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    _buildMenuItem(
                                      icon: Icons.key,
                                      title: 'Thay đổi mật khẩu',
                                      onTap: () {
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const ChangePasswordScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    _buildMenuItem(
                                      icon: Icons.logout,
                                      title: 'Đăng xuất',
                                      onTap: _logoutButton,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProfileCard(BuildContext context, User user) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: AppColors.borderContainer, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
             CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 35,
                backgroundImage: NetworkImage(
                  user.image.url.isNotEmpty
                      ? user.image.url
                      : 'https://static.vecteezy.com/system/resources/thumbnails/024/983/914/small/simple-user-default-icon-free-png.png',
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.role == 'ADMIN' ? 'Quản trị viên' : 'Giảng viên',
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Xem thông tin cá nhân',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
