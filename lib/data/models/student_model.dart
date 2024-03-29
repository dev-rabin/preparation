class StudentModel {
  int? studentId;
  String? name;
  String? email;
  String? profile;

  StudentModel({this.studentId, this.name, this.email, this.profile});

  StudentModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    name = json['name'];
    email = json['email'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'name': name,
      'email': email,
      'profile': profile,
    };
  }
}
