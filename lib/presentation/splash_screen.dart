// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:preparation/presentation/home_page.dart';
import 'package:preparation/presentation/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) {
          return FutureBuilder<bool>(
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
                  return WelcomeScreen();
                }
              }
            },
          );
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/online-learning.png",
              width: 200,
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "Preparation",
                  textStyle:
                      TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                  speed: Duration(milliseconds: 70),
                  textAlign: TextAlign.center,
                  curve: Easing.linear,
                )
              ],
              totalRepeatCount: 2,
              pause: Duration(milliseconds: 50),
            )
          ],
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
