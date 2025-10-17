import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/services/User_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  String formatDate(String dob) {
    try {
      final date = DateTime.parse(dob);
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    } catch (e) {
      return dob;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
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
          : Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(child: buildProfileContainer(_user!)),
            ),
    );
  }

  Widget buildProfileContainer(User user) {
    return Column(
      children: [
        _buildProfileItem(
          icon: Icons.badge_outlined,
          title: 'Mã người dùng',
          value: user.userId,
        ),
        _divider(),
        _buildProfileItem(
          icon: Icons.person_outline,
          title: 'Họ và tên',
          value: user.fullName,
        ),
        _divider(),
        _buildProfileItem(
          icon: Icons.verified_user_outlined,
          title: 'Tên đăng nhập',
          value: user.username,
        ),
        _divider(),
        _buildProfileItem(
          icon: Icons.calendar_today_outlined,
          title: 'Ngày sinh',
          value: formatDate(user.dob),
        ),
        _divider(),
        _buildProfileItem(
          icon: Icons.people_outline_rounded,
          title: 'Giới tính',
          value: user.gender == 1 ? 'Nam' : 'Nữ',
        ),
        _divider(),
        _buildProfileItem(
          icon: Icons.portrait_outlined,
          title: 'Chức vụ',
          value: user.role == 'ADMIN' ? 'Quản trị viên' : 'Giảng viên',
        ),
        _divider(),
        _buildProfileItem(
          icon: Icons.info_outline,
          title: 'Trạng thái',
          value: user.status == 1 ? 'Đang hoạt động' : 'Ngừng hoạt động',
          color: user.status == 1 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.black45),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: AppColors.silverGray, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: color ?? Colors.black,
                fontSize: 16,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _divider() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Divider(color: AppColors.shadow),
  );
}
