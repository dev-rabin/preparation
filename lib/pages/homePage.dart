// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/blocs/internet_bloc/internet_bloc.dart';
import 'package:preparation/blocs/internet_bloc/internet_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preparation"),
        leading: Drawer(
          child: Icon(
            Icons.menu,
          ),
        ),
      ),
      body: BlocBuilder<InternetBloc, InternetStates>(
        builder: (context, state) {
        if (state is InternetGainedState) {
          return Center(child: Text("Online"));
        } else if (state is InterLostState){
          return Center(child: Text("Offline"));
        } else {
          return Center(child: Text("Loading..."));
        }
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.assignment,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.data_object_sharp,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu_book,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu_open,
              )),
        ],
      ),
    );
  }
}
