class QuizQuestionOptionsModel {
  int? optionsId;
  int? questionId;
  String? optionText;
  int? isCorrectOption;

  QuizQuestionOptionsModel(
      {this.optionsId, this.questionId, this.optionText, this.isCorrectOption});

  QuizQuestionOptionsModel.fromJson(Map<String, dynamic> json) {
    optionsId = json['options_id'];
    questionId = json['question_id'];
    optionText = json['option_text'];
    isCorrectOption = json['is_correct_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['options_id'] = optionsId;
    data['question_id'] = questionId;
    data['option_text'] = optionText;
    data['is_correct_option'] = isCorrectOption;
    return data;
  }
}
