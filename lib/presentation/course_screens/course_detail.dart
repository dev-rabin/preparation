// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/lesson_cubit/lesson_cubit.dart';
import 'package:preparation/logic/cubits/module_cubit/module_cubit.dart';
import 'package:preparation/logic/cubits/module_cubit/module_state.dart';
import 'package:preparation/presentation/course_screens/lesson_screeen.dart';

class CourseDetail extends StatelessWidget {
  final int courseId;
  const CourseDetail({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ModuleCubit>(context).fetchModules(courseId);

    return BlocBuilder<ModuleCubit, ModuleStates>(
      builder: (context, state) {
        if (state is ModuleLoadingState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Loading...'),
              centerTitle: true,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ModuleDataSuccessState) {
          final courseName = state.moduleModel.first.courseName;
          return Scaffold(
              appBar: AppBar(
                title: Text(courseName!),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Price : ${state.moduleModel.first.price.toString()}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                ],
              ),
              body: ListView.builder(
                itemCount: state.moduleModel.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state.moduleModel[index].moduleName.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Text(
                      "${state.moduleModel[index].number.toString()}.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          final moduleId = state.moduleModel[index].moduleId;
                          if (moduleId != null) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => LessonCubit(moduleId),
                                  child: LessonScreen(moduleId: moduleId),
                                ),
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.arrow_forward)),
                  );
                },
              ),
              bottomNavigationBar: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.greenAccent,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Enroll Now',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Failed to load modules'),
            ),
            body: Center(
              child: Text('Failed to load modules'),
            ),
          );
        }
      },
    );
  }
}
