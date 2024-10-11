abstract class RegistrationState {}

class RegistrationInitialState extends RegistrationState {}

class RegistrationLoadingState extends RegistrationState {}

class RegistrationLoadedState extends RegistrationState {}

class RegistrationErrorState extends RegistrationState {
  final String errorMessage;
  RegistrationErrorState(this.errorMessage);
}