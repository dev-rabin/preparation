abstract class SignInState {}

class SignInInitialState extends SignInState{}

class SignInErrorState extends SignInState{
  String? errorMessage;
  SignInErrorState( {this.errorMessage});
}

class SignInValidState extends SignInState{}

class SignInLoadingState extends SignInState{}