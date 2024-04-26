class QuizModel {
  int? quizId;
  int? courseId;
  String? quizName;
  String? quizDescription;
  String? createdAt;

  QuizModel(
      {this.quizId,
      this.courseId,
      this.quizName,
      this.quizDescription,
      this.createdAt});

  QuizModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    courseId = json['course_id'];
    quizName = json['quiz_name'];
    quizDescription = json['quiz_description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quiz_id'] = quizId;
    data['course_id'] = courseId;
    data['quiz_name'] = quizName;
    data['quiz_description'] = quizDescription;
    data['created_at'] = createdAt;
    return data;
  }
}
