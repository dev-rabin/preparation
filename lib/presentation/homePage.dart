// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/cubits/internet_cubit.dart';

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
          elevation: 0,
          child: Icon(
            Icons.menu,
          ),
        ),
      ),
      body: BlocConsumer<InternetCubit,InternetState>(
        listener: (context, state) {
          if (state == InternetState.Gained) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Internet connected"),
              backgroundColor: Colors.green,
            ));
          } else if (state == InternetState.Lost) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Internet disconnected"),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state == InternetState.Gained) {
            return Center(child: Text("Online"));
          } else if (state == InternetState.Lost) {
            return Center(
              child: Text("Offline"),
            );
          } else {
            return Center(
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
}
