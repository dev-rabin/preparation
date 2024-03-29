// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_event.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_bloc.dart';
import 'package:preparation/logic/cubits/internet_cubit.dart';
import 'package:preparation/logic/blocs/course_cubit/course_cubit.dart';
import 'package:preparation/logic/blocs/course_cubit/course_state.dart';
import 'package:preparation/presentation/auth_screen/sign_in_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preparation"),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.55,
        elevation: 0,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(),
                  Text("Robin Mandhotia")
                ],
              ),
            ),
            textButton("Home", () {}),
            textButton("Search", () {}),
            textButton("Courses", () {}),
            textButton("Profile", () {}),
            textButton("Log out", () {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Confirm Log Out'),
                    content: Text('Are you sure you want to log out?'),
                    actions:[
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
                                    onTap: () {},
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
                                      state.courses[index].name.toString(),
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
                      return const Text("An error occurred!");
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

  Widget textButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,style: TextStyle(fontSize: 18),),
        style: ButtonStyle(alignment: Alignment.centerLeft),
      ),
    );
  }
}
