class Course {
  final int id;
  final String courseId;
  final String name;

  Course({
    required this.id,
    required this.courseId,
    required this.name,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] ?? 0,
      courseId: json['courseId'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'name': name,
    };
  }
  
  factory Course.empty() {
    return Course(id: 0, courseId: '', name: '');
  }
}