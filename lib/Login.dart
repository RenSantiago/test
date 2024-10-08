import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:testsampleproject/Models/User.dart';
import 'package:testsampleproject/Models/UserEntity.dart';
import 'package:testsampleproject/Models/UserFirestore.dart';
import 'package:testsampleproject/Services/UserFirestoreService.dart';
import 'package:testsampleproject/components/Formfield.dart';
import 'package:testsampleproject/components/LoginButton.dart';
import 'package:testsampleproject/objectbox.g.dart';
import 'package:collection/collection.dart';

class LoginState extends StatefulWidget {
  final Store store;
  const LoginState(this.store);
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginState> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String message = '';
  late final Box<UserEntity> _userBox;
  UserFirestoreService _userFirestoreService = UserFirestoreService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBox = widget.store.box<UserEntity>();
  }

  void handleLogin() async {
  try{
   UserFirestore user = await _userFirestoreService.getUser(usernameController.text);
    if(user.password != passwordController.text) {
      throw();
    };
   Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false , arguments: usernameController.text);
  } catch(err) {
    message = 'invalid credentials';
    _snackBar();
  }
  }

  void _snackBar() {
    var snackBar = SnackBar(
        content: Text(message)
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome' ,
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700
                ),
              ),
              MyFormField(
                  controller: usernameController ,
                  label: 'Username' ,
                  fieldIcon: const Icon(Icons.person)
              ),
              MyFormField(
                  controller: passwordController ,
                  label: 'Password' ,
                  fieldIcon: const Icon(Icons.key),
                  obscure: true
              ),
              const SizedBox(
                height: 20,
              ),
              LoginButton(onPressed: handleLogin,),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/signup')
                  },
                  child: const Text('Create an account'))
            ],
          ),
        ),
      ),
    );
  }

}