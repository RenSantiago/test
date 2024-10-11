abstract class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final String email;
  final String password;
  final String confirmPassword;

  RegisterUserEvent({required this.email , required this.password , required this.confirmPassword});
}