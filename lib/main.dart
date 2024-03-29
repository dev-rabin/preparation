// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/course_cubit/course_cubit.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_bloc.dart';
import 'package:preparation/logic/cubits/internet_cubit.dart';
import 'package:preparation/presentation/home_page.dart';
import 'package:preparation/presentation/auth_screen/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(),
        ),
        BlocProvider<SignOutBloc>(
          create: (context) => SignOutBloc(),
        ),
        BlocProvider<CourseCubit>(create: (context) => CourseCubit()),
        BlocProvider(create: (context) => SignInBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Preparation',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: checkIfLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              if (snapshot.data == true) {
                return HomePage();
              } else {
                return SignInScreen();
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> checkIfLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    return token != null;
  }
}
