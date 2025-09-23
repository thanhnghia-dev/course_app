import 'package:course_app/models/classroom_model.dart';

class Student {
  final String studentId;
  final String firstName;
  final String lastName;
  final String fullName;
  final String phoneNumber;
  final String dob;
  final String birthPlace;
  final int gender;
  final String citizenId;
  final int status;
  final Classroom classroom;

  Student({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.phoneNumber,
    required this.dob,
    required this.birthPlace,
    required this.gender,
    required this.citizenId,
    required this.status,
    required this.classroom,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '${json['lastName']} ${json['firstName']}',
      phoneNumber: json['phoneNumber'] ?? '',
      dob: json['dob'] ?? '',
      birthPlace: json['birthPlace'] ?? '',
      gender: json['gender'] ?? '',
      citizenId: json['citizenId'] ?? '',
      status: json['status'] ?? '',
      classroom: json['classroom'] != null
          ? Classroom.fromJson(json['classroom'])
          : Classroom.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'birthPlace': birthPlace,
      'gender': gender,
      'citizenId': citizenId,
      'status': status,
      'classroom': classroom.toJson(),
    };
  }
}