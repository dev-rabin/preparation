abstract class SignInEvent {}

// class SignInTextChangedEvent extends SignInEvent{
//   String? emailValue;
//   String? passwordValue;
//   SignInTextChangedEvent({this.emailValue,this.passwordValue});
// }


class SignInSubmitEvent extends SignInEvent {
  final String email;
  final String password;

  SignInSubmitEvent({required this.email, required this.password});
}

