// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:preparation/data/models/student_model.dart';
import 'package:preparation/data/repository/api/api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

API api = API();

class AuthRepository {

  //Login
  Future<void> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw ("Please fill all details properly");
      } else if (EmailValidator.validate(email) == false) {
        throw ("Please enter valid email address!");
      } else if (password.length < 8) {
        throw ("Enter atleast 8 characters or more");
      }
      Response response = await api.sendRequest.post(
        "/login",
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        log("User logged in successfully");
      }
      //JWT Token
      final token = response.data["token"];
      log("Login token ${token}");

      //Shared_preference
      SharedPreferences preference = await SharedPreferences.getInstance();
      await preference.setString("token", token);
      await getStudentData(token);
      return token;


    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.badResponse && ex.response != null) {
        if (ex.response!.data['message'] == 'Invalid password') {
          throw ("Invalid password");
        } else if (ex.response!.data['message'] == "Student not found") {
          throw ("You are not registered! Please register");
        }
      }
    } catch (ex) {
      log("Login error: $ex");
      rethrow;
    }
  }
  //Log out
  Future<void> logOut ()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("token");
    log("Student logout successfully");
    throw("Logout successfully");
  }

  //Get Student data by Token
  Future<StudentModel> getStudentData(String token) async {
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    if (token == null) {
      throw("Token not found!");
    }

    api.sendRequest.options.headers['Authorization'] = token;
    Response response = await api.sendRequest.get("/student");

    if (response.statusCode == 200) {
      log("Student data fetched successfully");
      final Map<String, dynamic> responseData = response.data;
      final Map<String, dynamic> studentData = responseData["data"];
      return StudentModel.fromJson(studentData);
    } else {
      log("Student data not found!");
      throw("Student not found");
    }
  } catch (ex) {
    log("Error during fetching student data: $ex");
    rethrow;
  }
}


 }
