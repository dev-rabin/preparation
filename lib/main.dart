// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/course_cubit/course_cubit.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_bloc.dart';
import 'package:preparation/logic/cubits/internet_cubit.dart';
import 'package:preparation/presentation/splash_screen.dart';

void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider<CourseCubit>(
          create: (context) => CourseCubit(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Preparation',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
            useMaterial3: true,
          ),
          home: SplashScreen()),
    );
  }
}
