// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Log out"),elevation: 1,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Are you sure want to logout ?"),
            ElevatedButton(onPressed: (){
            }, child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}