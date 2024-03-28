import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/course_model.dart';
import 'package:preparation/data/repository/course_repository.dart';
import 'package:preparation/logic/blocs/course_cubit/course_state.dart';

class CourseCubit extends Cubit<CourseState>{
  CourseCubit() : super(CourseLoadingState()){
    fetchCourses();
  }

  CourseRepository courseRepository = CourseRepository();

  void fetchCourses () async{
    try {
     List<CourseModel> courses = await courseRepository.fetchCourses();
     emit(CourseDataSuccesState(courses));
    } catch (e) {
      emit(CourseDataErrorState(e.toString()));
    }
  }
}