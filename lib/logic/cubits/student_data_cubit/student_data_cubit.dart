import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/student_model.dart';
import 'package:preparation/data/repository/auth_repository.dart';
import 'package:preparation/logic/cubits/student_data_cubit/student_data_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDataCubit extends Cubit<StudentDataState> {
  
  StudentDataCubit() : super(StudentDataLoadingState()){
    fetchStudentData();
  }

  AuthRepository authRepository = AuthRepository();

  void fetchStudentData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString('token');

      if (token == null) {
        throw("Token not found!");
      }
      StudentModel studentData = await authRepository.getStudentData(token);
      emit(StudentDataGetSuccessState(studentData));
    } catch (ex) {
      emit(StudentDataErrorState(ex.toString()));
    }
  }
}
