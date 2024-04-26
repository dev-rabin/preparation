import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/quiz_cubit.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quizzes"),
        ),
        body: BlocBuilder<QuizCubit, QuizStates>(
          builder: (context, state) {
            if (state is QuizLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuizDataSuccessState) {
              return ListView.builder(
                itemCount: state.quiz.length,
                itemBuilder: (context, index) {
                 return ListTile(
                  leading: Text((index + 1).toString(),style:const TextStyle(fontSize: 16),),
                    title: Text(state.quiz[index].quizName.toString()),
                    subtitle: Text(state.quiz[index].quizDescription.toString()),
                 );
                },
              );
            }
            return Container();
          },
        ));
  }
}
