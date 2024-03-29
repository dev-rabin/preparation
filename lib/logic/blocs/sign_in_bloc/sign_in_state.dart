abstract class SignInState {}

class SignInInitialState extends SignInState{}

class SignInErrorState extends SignInState{
  String? errorMessage;
  SignInErrorState( {this.errorMessage});
}

class SignInSuccessState extends SignInState{
  String signinSuccesMessage;
  SignInSuccessState(this.signinSuccesMessage);
}

class SignInLoadingState extends SignInState{}