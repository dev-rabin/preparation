import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/quiz_question_model.dart';
import 'package:preparation/data/repository/quiz_repository.dart';

abstract class QuizQuestionStates {}

class QuizQuestionInitialState extends QuizQuestionStates{}

class QuizQuestionLoadingState extends QuizQuestionStates{}

class QuizQuestionDataSuccessState extends QuizQuestionStates{
  List<QuizQuestionModel> questions;
  QuizQuestionDataSuccessState(this.questions);
}

class QuizQuestionErrorState extends QuizQuestionStates{
  String errMessage;
  QuizQuestionErrorState(this.errMessage);
}


class QuizQuestionCubit extends Cubit<QuizQuestionStates>{
  final int quizId;
  QuizQuestionCubit(this.quizId) : super(QuizQuestionInitialState()){
    fetchQuizQuestions(quizId);
  }
  QuizRepository quizRepository = QuizRepository();
  void fetchQuizQuestions (int quizId) async{
    try {
      List<QuizQuestionModel> questions = await quizRepository.fetchQuizQuestions(quizId);
      emit(QuizQuestionDataSuccessState(questions));
    } catch (ex) {
      emit(QuizQuestionErrorState(ex.toString()));
    }
  }
}