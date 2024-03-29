
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/repository/auth_repository.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_event.dart';
import 'package:preparation/logic/blocs/sign_in_bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent,SignInState>{
  AuthRepository authRepository = AuthRepository();
  SignInBloc() : super(SignInInitialState()){
    
    // on<SignInTextChangedEvent>((event, emit) {
    //   if(EmailValidator.validate(event.emailValue!) == false){
    //     emit(SignInErrorState(errorMessage: "Please fill valid email address!"));
    //   } else if(event.passwordValue!.length < 8){
    //     emit(SignInErrorState(errorMessage: "Atleast fill 7 characters!"));
    //   } else{
    //     emit(SignInSuccessState("Student sign in successfully"));
    //   }
    // });

    on<SignInSubmitEvent>((event, emit) async{
      emit(SignInLoadingState());
      try {
        await authRepository.login(event.email, event.password);
        emit(SignInSuccessState("Student sign in successfully"));
      } catch (ex) {
        emit(SignInErrorState(errorMessage: ex.toString()));
      }
    });
  }
}