import 'package:preparation/data/models/course_model.dart';

abstract class CourseState {}

class CourseLoadingState extends CourseState{}

class CourseDataSuccesState extends CourseState {
 List<CourseModel> courses;
  CourseDataSuccesState(this.courses);
}

class CourseDataErrorState extends CourseState{
 String errorMessage;
  CourseDataErrorState(this.errorMessage);
}