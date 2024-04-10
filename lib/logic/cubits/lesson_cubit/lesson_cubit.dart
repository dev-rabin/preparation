import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/lesson_model.dart';
import 'package:preparation/data/repository/lesson_repository.dart';

abstract class LessonStates {}

class LessionInitialState extends LessonStates{}

class LessionDataSuccessState extends LessonStates{
  List<LessonModel> lessons;
  LessionDataSuccessState(this.lessons);
}

class LessonErrorState extends LessonStates{
  String errMessage;
  LessonErrorState(this.errMessage);
}

class LessonDataLoadingState extends LessonStates{}

class LessonCubit extends Cubit<LessonStates>{
final int moduleId;

  LessonCubit(this.moduleId) :super(LessionInitialState()){
    fetchLessons(moduleId);
  }

  LessonRepository lessonRepository = LessonRepository();

  void fetchLessons (int moduleId) async {
    try {
      List<LessonModel> lessons = await lessonRepository.fetchLessons(moduleId);
      emit(LessionDataSuccessState(lessons));
    } catch (ex) {
      emit(LessonErrorState("Lessons not found"));
    }
  }
}