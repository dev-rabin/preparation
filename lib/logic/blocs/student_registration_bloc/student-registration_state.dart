// ignore_for_file: file_names

abstract class StudentRegistrationState {}

class StudentRegistrationInitialState extends StudentRegistrationState{}


class StudentRegistrationSuccessState extends StudentRegistrationState{
  String successMessage;
  StudentRegistrationSuccessState(this.successMessage);
}


class StudentRegistrationErrorState extends StudentRegistrationState{
  String errorMessage;
  StudentRegistrationErrorState(this.errorMessage);
}


class StudentRegistrationLoadingState extends StudentRegistrationState{}