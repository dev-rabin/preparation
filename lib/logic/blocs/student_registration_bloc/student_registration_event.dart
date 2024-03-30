class StudentRegistrationEvent {}

class StudentRegistrationSubmitEvent extends StudentRegistrationEvent{
  String name;
  String email;
  String password;
  // String profile;
  StudentRegistrationSubmitEvent(this.name,this.email,this.password);
}

class StudentFormChangedEvent extends StudentRegistrationEvent{}