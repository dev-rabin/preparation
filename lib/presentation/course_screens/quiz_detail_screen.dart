import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/logic/cubits/course_cubit/quiz_question_cubit.dart';

class QuizDetailScreen extends StatelessWidget {
  final int quizId;
  const QuizDetailScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions"),
      ),
      body: BlocBuilder<QuizQuestionCubit, QuizQuestionStates>(
        builder: (context, state) {
          if (state is QuizQuestionLoadingState) {
            return const Center(child: CircularProgressIndicator(),);
          } else if(state is QuizQuestionDataSuccessState){
            return ListView.builder(
              itemCount: state.questions.length,
              itemBuilder: (context,index){
                return ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(state.questions[index].questionText.toString()),
                 trailing: TextButton(onPressed: () {
                   
                 },child: const Text("Show options"),),
                );
              });
          }
          return Container();
        }
      ),
    );
  }
}
