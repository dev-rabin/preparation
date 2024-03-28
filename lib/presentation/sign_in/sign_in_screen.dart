// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/course_cubit/course_cubit.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_event.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:preparation/presentation/homePage.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign in",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: emailController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailValue: emailController.text,
                    passwordValue: passwordController.text));
              },
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: passwordController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailValue: emailController.text,
                    passwordValue: passwordController.text));
              },
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInErrorState) {
                return Text(
                  state.errorMessage!,
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return OutlinedButton(
                onPressed: () {
                  if (state is SignInValidState) {
                    BlocProvider.of<SignInBloc>(context).add(SignInSubmitEvent(
                        email: emailController.text,
                        password: passwordController.text));
                  }
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => CourseCubit(),
                        child: HomePage(),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
