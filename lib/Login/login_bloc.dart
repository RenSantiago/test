import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testsampleproject/Login/login_event.dart';
import 'package:testsampleproject/Login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>((event, emit) async {
      emit(LoginLoadingState());
      final email = event.email;
      final password = event.password;
      final firebaseAuth = FirebaseAuth.instance;
      try {
        final credentials = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        if(credentials.user != null) {
          print(credentials.user!.uid);
          emit(LoginLoadedState());
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState('invalid credentials'));
      }
    });
  }
}
