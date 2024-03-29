// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preparation/data/repository/auth_repository.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_event.dart';
import 'package:preparation/logic/blocs/sign_out_bloc/sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent,SignOutState>{
  AuthRepository authRepository = AuthRepository();
  SignOutBloc():super(SignOutInitialState()){
    on<SignOutSuccessEvent>((event, emit) async{
      emit(SignOutLoadingState());
      try {
      await authRepository.logOut();
       emit(SignOutSuccessState("Log out successfully"));
      } catch (ex) {
        emit(SignOutErrorState("Log out failed ${ex}"));
      }
    } );
  }
}