import 'dart:convert';
import 'dart:developer'; // Import the 'dart:developer' library

import 'package:dio/dio.dart';
import 'package:preparation/data/models/course_model.dart';
import 'package:preparation/data/repository/api/api.dart';

API api = API();

class CourseRepository {
  Future<List<CourseModel>> fetchCourses() async {
    try {
      Response response = await api.sendRequest.get("/courses");
      if (response.statusCode == 200) {
        log("Data fetched successfully");
        final List<dynamic> courseData = response.data['data'];
        List<CourseModel> courses = courseData.map((courseMap) => CourseModel.fromJson(courseMap)).toList();
        return courses;
      } else {
        log("Failed to fetch courses: ${response.statusCode}");
        throw Exception("Failed to fetch courses: ${response.statusCode}");
      }
    } catch (ex) {
      log("Fetch courses error: $ex");
      throw ex;
    }
  }
}
