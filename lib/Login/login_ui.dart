import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testsampleproject/Login/login_bloc.dart';
import 'package:testsampleproject/Login/login_event.dart';
import 'package:testsampleproject/Login/login_state.dart';
import 'package:testsampleproject/Training/components/Formfield.dart';
import 'package:testsampleproject/Training/components/LoginButton.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    final _loginbloc = BlocProvider.of<LoginBloc>(context);

    void handleLogin() {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      _loginbloc.add(LoginUserEvent(email: email, password: password));
    }

    Widget LoginButtons() => Column(
          children: [
            LoginButton(
              onPressed: handleLogin,
              label: 'Sign in',
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () => {Navigator.pushNamed(context, '/signup')},
                child: const Text('Create an account'))
          ],
        );

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),
              MyFormField(
                controller: _emailController,
                label: 'Email',
                fieldIcon: const Icon(Icons.email),
              ),
              MyFormField(
                  controller: _passwordController,
                  label: 'Password',
                  fieldIcon: const Icon(Icons.key),
                  obscure: true),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginInitialState) {
                  return LoginButtons();
                } else if (state is LoginLoadingState) {
                  return CircularProgressIndicator();
                } else {
                  return LoginButtons();
                }
              }, listener: (context, state) {
                if (state is LoginLoadedState) {
                  Navigator.pushNamed(context, '/dashboard');
                } else if (state is LoginErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage),
                  ));
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
