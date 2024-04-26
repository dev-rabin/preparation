class QuizQuestionModel {
  int? questionId;
  int? quizId;
  String? questionText;
  String? questionType;
  String? createdAt;

  QuizQuestionModel(
      {this.questionId,
      this.quizId,
      this.questionText,
      this.questionType,
      this.createdAt});

  QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    quizId = json['quiz_id'];
    questionText = json['question_text'];
    questionType = json['question_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['quiz_id'] = quizId;
    data['question_text'] = questionText;
    data['question_type'] = questionType;
    data['created_at'] = createdAt;
    return data;
  }
}
