import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/lesson_bloc/lesson_bloc.dart';
import 'package:video_player/video_player.dart';

class LessonScreen extends StatefulWidget {
  final int moduleId;

  const LessonScreen({super.key, required this.moduleId});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late LessonBloc _lessonBloc;

  @override
  void initState() {
    super.initState();
    _lessonBloc = BlocProvider.of<LessonBloc>(context);
    _lessonBloc.add(LessonFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonBloc, LessonState>(
      listener: (context, state) {
        if (state is LessonErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LessonLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LessonDataSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Lessons"),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: state.lessons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    "${state.lessons[index].number.toString()}.",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  title: Text(state.lessons[index].name.toString()),
                  subtitle: Text(state.lessons[index].lessonDetails.toString()),
                  onTap: () {
                    _lessonBloc.add(
                      LessonVideoPlayEvent("http:/192.168.1.4:5000/api/${state.lessons[index].videoUrl}"),
                    );
                  },
                  trailing: const Icon(Icons.play_arrow, color: Colors.greenAccent),
                );
              },
            ),
          );
        } else if (state is LessonVideoPlayingState) {
          return Scaffold(
            appBar: AppBar(
              title:const Text("Video Player"),
              centerTitle: true,
            ),
            body: Center(
              child: AspectRatio(
                aspectRatio: state.videoController.value.aspectRatio,
                child: VideoPlayer(state.videoController),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
