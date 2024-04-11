// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/module_cubit/module_cubit.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_event.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_bloc.dart';
import 'package:preparation/logic/cubits/student_data_cubit/student_data_cubit.dart';
import 'package:preparation/logic/cubits/internet_cubit.dart';
import 'package:preparation/logic/cubits/course_cubit/course_cubit.dart';
import 'package:preparation/logic/cubits/course_cubit/course_state.dart';
import 'package:preparation/presentation/auth_screen/sign_in_screen.dart';
import 'package:preparation/presentation/course_screens/course_detail.dart';
import 'package:preparation/presentation/student_screens/student_profile_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preparation"),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        elevation: 0,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Hero(
                    tag: "profile-icon",
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(
                        CupertinoIcons.person,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        (context),
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => StudentDataCubit(),
                            child: StudentProfile(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View profile",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            textButton("Home", Icon(CupertinoIcons.home), () {}),
            textButton("Search", Icon(CupertinoIcons.search), () {}),
            textButton("Courses", Icon(CupertinoIcons.book), () {}),
            textButton("Profile", Icon(CupertinoIcons.person), () {}),
            textButton("Log out", Icon(Icons.logout), () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Confirm Log Out'),
                    content: Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text('No'),
                      ),
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
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              );
            })
          ],
        ),
      ),
      body: BlocConsumer<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state == InternetState.Gained) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Internet connected"),
              backgroundColor: Colors.green,
            ));
          } else if (state == InternetState.Lost) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Internet disconnected"),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state == InternetState.Gained) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      if (state is CourseLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CourseDataSuccesState) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.courses.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Card(
                                  color: Colors.white,
                                  child: ListTile(
                                    onTap: () {
                                      final courseId =
                                          state.courses[index].courseId;
                                      if (courseId != null) {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  ModuleCubit(courseId),
                                              child: CourseDetail(
                                                  courseId: courseId),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    leading: CircleAvatar(
                                      child: Icon(Icons.book_sharp),
                                      foregroundColor: Colors.black87,
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                    trailing: Text(
                                        "Price : ${state.courses[index].price.toString()}"),
                                    subtitle: Text(state
                                        .courses[index].description
                                        .toString()),
                                    title: Text(
                                      state.courses[index].courseName.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Text("An error occurred!");
                    },
                  ),
                ],
              ),
            );
          } else if (state == InternetState.Lost) {
            return const Center(
              child: Text("Offline"),
            );
          } else {
            return const Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.home)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.person)),
            IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.book))
          ],
        ),
      ),
    );
  }

  Widget textButton(String text, Icon icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
