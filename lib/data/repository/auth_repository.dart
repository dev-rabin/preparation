import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:preparation/data/repository/api/api.dart';
import 'package:email_validator/email_validator.dart';

API api = API();

// class InvalidPasswordException implements Exception {
//   final String message;

//   InvalidPasswordException(this.message);
// }

class AuthRepository {
  Future<void> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw ("Please fill all details properly");
      }else if(EmailValidator.validate(email) == false){
        throw ("Please enter valid email address!");
      }else if(password.length < 8){
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
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.badResponse && ex.response != null) {
        if (ex.response!.data['message'] == 'Invalid password') {
          throw ("Invalid password");
        } else if(ex.response!.data['message'] == "Student not found"){
          throw ("You are not registered! Please register");
        }
      }
    } catch (ex) {
      log("Login error: $ex");
      rethrow;
    }
  }
}
