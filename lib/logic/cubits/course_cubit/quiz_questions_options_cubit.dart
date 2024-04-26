import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/quiz_question_options_model.dart';
import 'package:preparation/data/repository/quiz_repository.dart';

abstract class QuestionOptionsStates{}

class QuestionOptionsInitialState extends QuestionOptionsStates{}

class QuestionOptionsLoadingState extends QuestionOptionsStates{}

class QuestionOptionsDataSuccessState extends QuestionOptionsStates{
  List<QuizQuestionOptionsModel> options;
  QuestionOptionsDataSuccessState(this.options);
}

class QuestionOptionsErrorState extends QuestionOptionsStates{
  String errorMessage;
  QuestionOptionsErrorState(this.errorMessage);
}

class QuestionOptions extends Cubit<QuestionOptionsStates> {
  final int questionId;
  QuestionOptions(this.questionId) : super(QuestionOptionsInitialState()){
    fetchQuestionOptions(questionId);
  }

  QuizRepository quizRepository = QuizRepository();
  void fetchQuestionOptions (questionId) async {
    try {
      List<QuizQuestionOptionsModel> options = await quizRepository.fetchQuizQuestionOptions(questionId);
    emit(QuestionOptionsDataSuccessState(options));
    } catch (ex) {
      emit(QuestionOptionsErrorState(ex.toString()));
    }
  }
  
}


