import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:preparation/data/models/lesson_model.dart';
import 'package:preparation/data/repository/api/api.dart';

API api = API();

class LessonRepository{
  Future<List<LessonModel>> fetchLessons (int moduleId) async{
    try {
      Response response = await api.sendRequest.get("/lesson/$moduleId");
    if (response.statusCode == 200) {
      final List<dynamic> lessonData = response.data["data"];
      List<LessonModel> lessons = lessonData.map((lessonMap) =>LessonModel.fromJson(lessonMap)).toList();
      return lessons;
    }else{
        log("failed to fetch lessons");
        throw Exception("failed to fetch lessons:${response.statusMessage}");
      }
    } catch (ex) {
      log("Fetch lessons error: $ex");
      rethrow;
    }
  }
}