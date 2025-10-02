import 'package:course_app/core/theme/app_colors.dart';
import 'package:course_app/core/utils/util.dart';
import 'package:course_app/models/user_model.dart';
import 'package:course_app/views/widgets/label_with_asterisk_widget.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final User? user;

  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();

  String? selectedGender;
  final List<String> genders = ['Nam', 'Nữ', 'Khác'];
  final Map<int, String> genderMap = {0: 'Nữ', 1: 'Nam', 2: 'Khác'};

  @override
  void initState() {
    super.initState();
    // Load User info
    final user = widget.user;
    nameController.text = user?.fullName ?? '';
    dobController.text = user?.dob ?? '';
    selectedGender = genderMap[user?.gender ?? -1];
    genderController.text = selectedGender ?? '';
  }

  // Save data button
  Future<void> _saveButton() async {
    String fullName = nameController.text.trim();
    String dob = dobController.text.trim();
    String gender = genderController.text.trim();

    if (fullName.isEmpty && dob.isEmpty && gender.isEmpty) {
      showOverlayToast(context, 'Vui lòng nhập đầy đủ thông tin');
      return;
    }
    
  }

  // Select day of birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("vi"),
    );

    if (picked != null) {
      setState(() {
        dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 50,
                          backgroundImage: NetworkImage(
                            "https://static.vecteezy.com/system/resources/thumbnails/024/983/914/small/simple-user-default-icon-free-png.png",
                          ),
                        ),
                    
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              // TODO: mở dialog chọn ảnh hoặc xử lý edit avatar
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                    
                  // Form edit
                  const LabelWithAsterisk(
                    label: 'Họ và tên',
                    isRequired: true,
                  ),
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
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),

                  const LabelWithAsterisk(
                    label: 'Ngày sinh',
                    isRequired: true,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: dobController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                      hintText:'---------------Chọn ngày sinh---------------',
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 15),

                  const LabelWithAsterisk(
                    label: 'Giới tính',
                    isRequired: true,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField(
                    value: selectedGender,
                    items: genders
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text(e)),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedGender = val as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: AppColors.primary,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText:'---------------Chọn giới tính---------------',
                    ),
                  ),
                  const SizedBox(height: 25),

                  GestureDetector(
                    onTap: _saveButton,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
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
      ),
    );
  }
}
