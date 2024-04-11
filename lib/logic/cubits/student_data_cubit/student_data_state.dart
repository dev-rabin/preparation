import 'package:preparation/data/models/student_model.dart';

abstract class StudentDataState {}

class StudentDataGetSuccessState extends StudentDataState{
  StudentModel studentData;
  StudentDataGetSuccessState(this.studentData);
}
class StudentDataErrorState extends StudentDataState{
  String errorMessage;
  StudentDataErrorState(this.errorMessage);
}

class StudentDataLoadingState extends StudentDataState{}