// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/lesson_cubit/lesson_cubit.dart';
import 'package:video_player/video_player.dart';

class LessonScreen extends StatefulWidget {
  final int moduleId;
  
  const LessonScreen({super.key, required this.moduleId});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller
    _controller = VideoPlayerController.network('');
    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the video player controller when the widget is disposed
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lessons"),
        centerTitle: true,
      ),
      body: BlocBuilder<LessonCubit, LessonStates>(
        builder: (context, state) {
          if (state is LessonDataLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LessionDataSuccessState) {
            return ListView.builder(
              itemCount: state.lessons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    "${state.lessons[index].number.toString()}.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  title: Text(state.lessons[index].name.toString()),
                  subtitle: Text(state.lessons[index].lessonDetails.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow, color: Colors.greenAccent),
                    onPressed: () {
                      // Play video when the play button is pressed
                      _controller = VideoPlayerController.networkUrl(Uri.parse("http://192.168.1.5:5000/api/${state.lessons[index].videoUrl}"));
                      _controller.initialize().then((_) {
                        setState(() {
                          // Start playing the video
                          _controller.play();
                        });
                      });
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
