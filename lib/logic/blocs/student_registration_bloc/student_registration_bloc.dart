// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/repository/auth_repository.dart';
import 'package:preparation/logic/blocs/student_registration_bloc/student-registration_state.dart';
import 'package:preparation/logic/blocs/student_registration_bloc/student_registration_event.dart';

class StudentRegistrationBloc extends Bloc<StudentRegistrationEvent, StudentRegistrationState>{

AuthRepository authRepository = AuthRepository();
  StudentRegistrationBloc() : super(StudentRegistrationInitialState()){
    on<StudentRegistrationSubmitEvent>((event, emit)async {
      emit(StudentRegistrationLoadingState());
      try {
        await authRepository.studentRegistration(event.name,event.email,event.password);
        emit(StudentRegistrationSuccessState("Student registred successfully"));
      } catch (ex) {
        emit(StudentRegistrationErrorState(ex.toString()));
        throw("Error : ${ex}");
      }
    });
  }
}