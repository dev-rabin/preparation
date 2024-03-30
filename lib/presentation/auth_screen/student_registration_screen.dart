// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_state.dart';
import 'package:preparation/logic/blocs/student_registration_bloc/student-registration_state.dart';
import 'package:preparation/logic/blocs/student_registration_bloc/student_registration_bloc.dart';
import 'package:preparation/logic/blocs/student_registration_bloc/student_registration_event.dart';
import 'package:preparation/presentation/auth_screen/sign_in_screen.dart';

class StudentRegistrationScreen extends StatelessWidget {
  StudentRegistrationScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController profileController = TextEditingController();

  void _registerOnpressed(BuildContext context) {
    BlocProvider.of<StudentRegistrationBloc>(context).add(
        StudentRegistrationSubmitEvent(nameController.text,
            emailController.text, passwordController.text));
    // profileController.text,
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StudentRegistrationBloc, StudentRegistrationState>(
        listener: (context, state) {
          if (state is StudentRegistrationSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => BlocProvider(
                  create: (context) => SignInBloc(),
                  child: SignInScreen(),
                ),
              ),
            );
          } else if (state is StudentRegistrationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register Here",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
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
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Text("FilePicker"),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
              builder: (context, state) {
                if (state is SignInLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () => _registerOnpressed(context),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ?",
                  style: TextStyle(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => SignInBloc(),
                          child: SignInScreen(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Sign in",
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
