import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/models/lesson_model.dart';
import 'package:preparation/data/repository/lesson_repository.dart';
import 'package:video_player/video_player.dart';

//events
abstract class LessonEvent {}

class LessonFetchEvent extends LessonEvent {}

class LessonVideoPlayEvent extends LessonEvent {
  final String videoUrl;
  LessonVideoPlayEvent(this.videoUrl);
}

// States
abstract class LessonState {}

class LessonInitialState extends LessonState {}

class LessonLoadingState extends LessonState {}

class LessonDataSuccessState extends LessonState {
  final List<LessonModel> lessons;
  LessonDataSuccessState(this.lessons);
}

class LessonVideoPlayingState extends LessonState {
  final VideoPlayerController videoController;
  LessonVideoPlayingState(this.videoController);
}

class LessonErrorState extends LessonState {
  final String errorMessage;
  LessonErrorState(this.errorMessage);
}


//Bloc
class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final int moduleId;
  LessonRepository lessonRepository = LessonRepository();
  late VideoPlayerController _videoPlayerController;

  LessonBloc(this.moduleId) : super(LessonInitialState()) {
    on<LessonFetchEvent>((event, emit) async {
      emit(LessonLoadingState());
      try {
        final List<LessonModel> lessons =
            await lessonRepository.fetchLessons(moduleId);
        emit(LessonDataSuccessState(lessons));
      } catch (ex) {
        emit(LessonErrorState("Lessons not found"));
      }
    });
    on<LessonVideoPlayEvent>((event, emit) {
      try {
        _videoPlayerController = VideoPlayerController.network(event.videoUrl);
        emit(LessonVideoPlayingState(_videoPlayerController));
        log("Video is playing...");
      } catch (ex) {
        emit(LessonErrorState("Failed to play video : $ex"));
        log("Error video is not playing : $ex");
      }
    });
  }
  @override
  Future<void> close() {
    _videoPlayerController.dispose();
    log("video is disclose");
    return super.close();
  }
}
