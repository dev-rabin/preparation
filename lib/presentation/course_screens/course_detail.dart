// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/module_cubit/module_cubit.dart';
import 'package:preparation/logic/cubits/module_cubit/module_state.dart';

class CourseDetail extends StatelessWidget {
  final int courseId;
  const CourseDetail({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ModuleCubit>(context).fetchModules(courseId);
    return Scaffold(
      body: BlocBuilder<ModuleCubit, ModuleStates>(
        builder: (context, state) {
          if (state is ModuleLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ModuleDataSuccessState) {
            return ListView.builder(
              itemCount: state.moduleModel.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.moduleModel[index].name.toString()),
                  leading:Text(state.moduleModel[index].number.toString()),
                  trailing: Text(state.moduleModel[index].video_url.toString()),
                );
              },
            );
          } else {
            return Center(
              child: Text('Failed to load modules'),
            );
          }
        },
      ),
    );
  }
}
