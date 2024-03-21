abstract class SignInEvent {}

class SignInTextChangedEvent extends SignInEvent{
  String? emailValue;
  String? passwordValue;
  SignInTextChangedEvent({this.emailValue,this.passwordValue});
}


class SignInSubmitEvent extends SignInEvent{
  String? email;
  String? password;
  SignInSubmitEvent({this.email,this.password});
}