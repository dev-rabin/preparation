import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/quiz_model.dart';
import 'package:preparation/data/repository/quiz_repository.dart';

abstract class QuizStates {}

class QuizInitialState extends QuizStates{}

class QuizLoadingState extends QuizStates{}

class QuizDataSuccessState extends QuizStates{
 List<QuizModel> quiz;
   QuizDataSuccessState(this.quiz);
}

class QuizErrorState extends QuizStates{
  String errMessage;
  QuizErrorState(this.errMessage);
}


class QuizCubit extends Cubit<QuizStates>{
  QuizCubit() : super(QuizInitialState()){
    fetchQuiz();
  }

  QuizRepository quizRepository = QuizRepository();

  void fetchQuiz () async {
    try {
      List<QuizModel> quiz = await quizRepository.fetchQuiz();
      emit(QuizDataSuccessState(quiz));
    } catch (ex) {
      emit(QuizErrorState(ex.toString()));
    }
  }
}