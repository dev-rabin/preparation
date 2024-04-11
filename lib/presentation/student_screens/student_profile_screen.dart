// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_bloc.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_event.dart';
import 'package:preparation/logic/cubits/student_data_cubit/student_data_cubit.dart';
import 'package:preparation/logic/cubits/student_data_cubit/student_data_state.dart';
import 'package:preparation/presentation/auth_screen/sign_in_screen.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocBuilder<StudentDataCubit, StudentDataState>(
        builder: (context, state) {
          if (state is StudentDataLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentDataGetSuccessState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Hero(
                    tag: "profile-icon",
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(
                        CupertinoIcons.person,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Student Id : ${state.studentData.studentId}"),
                SizedBox(height: 10),
                Text(
                  "Name: ${state.studentData.name}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  "Email: ${state.studentData.email}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text("Confirm Log Out"),
                            content: Text("Are you sure want to log out ?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<SignOutBloc>(context)
                                      .add(SignOutSuccessEvent());
                                  Navigator.of(dialogContext).pop();
                                  Navigator.of(context).pushReplacement(
                                    CupertinoPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  );
                                },
                                child: Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                child: Text("Yes"),
                              )
                            ],
                          );
                        });
                  },
                  child: Text("Log out"),
                ),
              ],
            );
          } else if (state is StudentDataErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return Container();
        },
      ),
    );
  }
}
