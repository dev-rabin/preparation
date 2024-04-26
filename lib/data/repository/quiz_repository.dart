import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:preparation/data/models/quiz_model.dart';
import 'package:preparation/data/models/quiz_question_model.dart';
import 'package:preparation/data/models/quiz_question_options_model.dart';
import 'package:preparation/data/repository/api/api.dart';

API api = API();

class QuizRepository {
  Future<List<QuizModel>> fetchQuiz () async {
    try {
      Response response = await api.sendRequest.get("/quizzes");
      if (response.statusCode == 200) {
        log("Quiz fetched successfully");
        final List<dynamic> quizData = response.data['data'];
        List<QuizModel> quiz = quizData.map((quizMap) => QuizModel.fromJson(quizMap)).toList();
        return quiz;
      } else{
        log("Failed to fetch quiz: ${response.statusMessage}");
        throw Exception("Failed to fetch quiz: ${response.statusMessage}");
      }
    } catch (ex) {
      log("Fetch quiz error: $ex");
      rethrow;
    }
  }

  Future fetchQuizQuestions (int quizId) async {
    try {
      Response response = await api.sendRequest.get("/quizzes/$quizId");
      if (response.statusCode == 200) {
          final List<dynamic> questionsData = response.data['data'];
      List<QuizQuestionModel> questions = questionsData.map((questionsMap) => QuizQuestionModel.fromJson(questionsMap)).toList();
      return questions;
      } else {
        log("Failed to fetch quiz questions: ${response.statusMessage}");
        throw Exception("Failed to fetch quiz questions: ${response.statusMessage}");
      }
    
    } catch (ex) {
      log("Fetch quiz questions error: $ex");
      rethrow;
    }
  }

  Future fetchQuizQuestionOptions (int questionId) async{
    try {
      Response response = await api.sendRequest.get("/quizzes/questionoptions/$questionId");
      if (response.statusCode == 200) {
      final List<dynamic> optionsData = response.data['data'];
      List<QuizQuestionOptionsModel> options = optionsData.map((optionsMap) => QuizQuestionOptionsModel.fromJson(optionsMap)).toList();
      return options;
      }
      else {
        log("Failed to fetch quiz questions options: ${response.statusMessage}");
        throw Exception("Failed to fetch quiz questions options: ${response.statusMessage}");
      }
    } catch (ex) {
      log("Error during fetching questions options $ex");
      rethrow;
    }
  }
}