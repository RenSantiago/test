import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testsampleproject/Registration/registration_bloc.dart';
import 'package:testsampleproject/Registration/registration_event.dart';
import 'package:testsampleproject/Registration/registration_state.dart';
import 'package:testsampleproject/Training/components/Formfield.dart';
import 'package:testsampleproject/Training/components/LoginButton.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _registrationBloc = BlocProvider.of<RegistrationBloc>(context);

    void handleSignUp() {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPassController.text.trim();

      _registrationBloc.add(RegisterUserEvent(
          email: email, password: password, confirmPassword: confirmPassword));
    }

    void handleSignInRedirect() {
      Navigator.pop(context);
    }

    Widget RegistrationButtons() {
      return Column(
        children: [
          LoginButton(onPressed: handleSignUp, label: 'Sign up'),
          TextButton(
              onPressed: handleSignInRedirect,
              child: Text('already have an account ? Sign here'))
        ],
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            MyFormField(
              controller: _emailController,
              label: 'email',
              fieldIcon: Icon(Icons.email),
            ),
            MyFormField(
              controller: _passwordController,
              label: 'password',
              obscure: true,
              fieldIcon: Icon(Icons.key),
            ),
            MyFormField(
              controller: _confirmPassController,
              label: 'confirm password',
              obscure: true,
              fieldIcon: Icon(Icons.key_rounded),
            ),
            BlocConsumer<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
              if (state is RegistrationInitialState) {
                return RegistrationButtons();
              } else if (state is RegistrationLoadingState ||
                  state is RegistrationLoadedState) {
                return CircularProgressIndicator();
              } else {
                return RegistrationButtons();
              }
            }, listener: (context, state) {
              if (state is RegistrationLoadedState) {
                Navigator.pushNamed(context, '/login');
              } else if (state is RegistrationErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMessage),
                ));
              }

            })
          ],
        ),
      ),
    );
  }
}
