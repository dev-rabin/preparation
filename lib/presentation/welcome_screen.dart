// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:preparation/presentation/sign_in/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome to Preparation",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        OutlinedButton(
          child: Text("Sign in"),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => SignInBloc(),
                  child: SignInScreen(),
                ),
              ),
            );
          },
        ),
      ],
    ));
  }
}
