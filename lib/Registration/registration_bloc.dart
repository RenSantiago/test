import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testsampleproject/Registration/registration_event.dart';
import 'package:testsampleproject/Registration/registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegistrationLoadingState());

      final email = event.email;
      final password = event.password;
      final confirmpassword = event.confirmPassword;
      final firebaseAuth = FirebaseAuth.instance;

      print(password);
      print(confirmpassword);
      if (password != confirmpassword) {
        print("do not match");
        emit(RegistrationErrorState('passwords do not match'));
      }
      try {
        final credentials = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        emit(RegistrationLoadedState());
      } on FirebaseAuthException catch (e) {
        print(e.message);
        emit(RegistrationErrorState(e.message.toString()));
      }
    });
  }
}
