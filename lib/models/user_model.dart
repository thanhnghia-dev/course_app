import 'package:course_app/models/image_model.dart';

class User {
  final String userId;
  final String fullName;
  final String username;
  final String dob;
  final int gender;
  final String role;
  final int? status;
  final ImageModel image;

  User({
    required this.userId,
    required this.fullName,
    required this.username,
    required this.dob,
    required this.gender,
    required this.role,
    this.status,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      username: json['username'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? 0,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      image: json['image'] != null
          ? ImageModel.fromJson(json['image'])
          : ImageModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'username': username,
      'dob': dob,
      'gender': gender,
      'role': role,
      'status': status,
      'image': image,
    };
  }
  
  factory User.empty() {
    return User(
      userId: '',
      fullName: '',
      username: '',
      dob: '',
      gender: 2,
      role: '',
      image: ImageModel.empty(),
    );
  }
}