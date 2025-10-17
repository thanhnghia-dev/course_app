import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/core/utils/util.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/providers/user_provider.dart';
import 'package:course_app/services/user_service.dart';
import 'package:course_app/views/widgets/label_with_asterisk_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final User? user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final dobController = TextEditingController();

  String? selectedGender;
  final List<String> genders = ['Nam', 'Nữ', 'Khác'];
  final Map<String, int> genderValueMap = {'Nữ': 0, 'Nam': 1, 'Khác': 2};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = widget.user;
    nameController.text = user?.fullName ?? '';
    usernameController.text = user?.username ?? '';

    // ✅ Change date in SQL (yyyy-MM-dd) to dd/MM/yyyy
    if (user?.dob != null && user!.dob.isNotEmpty) {
      try {
        final parsedDate = DateFormat('yyyy-MM-dd').parse(user.dob);
        dobController.text = DateFormat('dd/MM/yyyy').format(parsedDate);
      } catch (e) {
        dobController.text = user.dob;
      }
    }

    // ✅ Map gender from int to string
    if (user?.gender != null) {
      switch (user!.gender) {
        case 0:
          selectedGender = 'Nữ';
          break;
        case 1:
          selectedGender = 'Nam';
          break;
        case 2:
          selectedGender = 'Khác';
          break;
      }
    }
  }

  // Save Data Button
  Future<void> _saveButton() async {
    String fullName = nameController.text.trim();
    String dobInput = dobController.text.trim();
    String gender = selectedGender ?? '';

    if (fullName.isEmpty || dobInput.isEmpty || gender.isEmpty) {
      showOverlayToast(context, 'Vui lòng nhập đầy đủ thông tin');
      return;
    }

    // Change gender to int
    int genderInt = switch (gender) {
      'Nam' => 1,
      'Nữ' => 0,
      _ => 2,
    };

    // Change dob dd/MM/yyyy -> yyyy-MM-ddTHH:mm:ss
    String formattedDob;
    try {
      final parsedDate = DateFormat("dd/MM/yyyy").parse(dobInput);
      formattedDob = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(parsedDate);
    } catch (e) {
      showOverlayToast(context, "Ngày sinh không hợp lệ (dd/MM/yyyy)");
      return;
    }

    final userService = UserService();

    final message = await userService.updateProfile(
      fullName: fullName,
      dob: formattedDob,
      gender: genderInt,
    );

    showOverlayToast(context, message ?? "Đã xảy ra lỗi");

    if (message?.contains("thành công") ?? false) {
      try {
        final updatedUser = await userService.fetchUserInfo();
        if (mounted) {
          context.read<UserProvider>().updateUser(updatedUser);
        }
        Navigator.pop(context, true);
      } catch (e) {
        showOverlayToast(
          context,
          "Cập nhật thành công nhưng không lấy được thông tin mới",
        );
      }
    }
  }

  // Keep displaying date type dd/MM/yyyy when choosing
  Future<void> _selectDate(BuildContext context) async {
    DateTime? initialDate;
    try {
      initialDate = DateFormat('dd/MM/yyyy').parse(dobController.text);
    } catch (_) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("vi"),
    );

    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 50,
                          backgroundImage: NetworkImage(
                            widget.user?.image.url.isNotEmpty == true
                                ? widget.user!.image.url
                                : 'https://www.seekpng.com/png/full/966-9665317_placeholder-image-person-jpg.png',
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              showOverlayToast(context, "Chức năng đang phát triển. Vui lòng thử lại sau!");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(Icons.edit, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const LabelWithAsterisk(label: 'Họ và tên', isRequired: true),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Nhập họ và tên của bạn',
                    ),
                  ),
                  const SizedBox(height: 15),
                  const LabelWithAsterisk(label: 'Tên đăng nhập', isRequired: true),
                  const SizedBox(height: 8),
                  TextField(
                    controller: usernameController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const LabelWithAsterisk(label: 'Ngày sinh', isRequired: true),
                  const SizedBox(height: 8),
                  TextField(
                    controller: dobController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                      hintText: '---------------Chọn ngày sinh---------------',
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 15),
                  const LabelWithAsterisk(label: 'Giới tính', isRequired: true),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    items: genders.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (val) {
                      setState(() => selectedGender = val);
                    },
                    icon: const Icon(Icons.arrow_drop_down_circle, color: AppColors.primary),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: '---------------Chọn giới tính---------------',
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: isLoading ? null : _saveButton,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: isLoading ? Colors.grey : AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
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
      ),
    );
  }
}
