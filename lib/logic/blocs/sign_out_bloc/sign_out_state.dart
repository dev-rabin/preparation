abstract class SignOutState {}

class SignOutInitialState extends SignOutState{}

class SignOutLoadingState extends SignOutState{}

class SignOutSuccessState extends SignOutState{
  String signOutMessage;
  SignOutSuccessState(this.signOutMessage);
}

class SignOutErrorState extends SignOutState{
  String signOutErrorMessage;
  SignOutErrorState(this.signOutErrorMessage);
}