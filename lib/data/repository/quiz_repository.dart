import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:preparation/data/models/quiz_model.dart';
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
}