// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/course_cubit/course_cubit.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_event.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:preparation/logic/blocs/student_registration_bloc/student_registration_bloc.dart';
import 'package:preparation/presentation/auth_screen/student_registration_screen.dart';
import 'package:preparation/presentation/home_page.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _onSignInPressed(BuildContext context) {
    BlocProvider.of<SignInBloc>(context).add(
      SignInSubmitEvent(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => CourseCubit(),
                  child: HomePage(),
                ),
              ),
            );
          } else if (state is SignInErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign in",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                autofocus: true,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInLoadingState) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () => _onSignInPressed(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not registred ?",
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => StudentRegistrationBloc(),
                          child: StudentRegistrationScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
