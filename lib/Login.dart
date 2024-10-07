import 'package:flutter/material.dart';
import 'package:testsampleproject/AwesomeSignunp.dart';
import 'package:testsampleproject/Models/User.dart';
import 'package:testsampleproject/components/Formfield.dart';
import 'package:testsampleproject/components/LoginButton.dart';


class LoginState extends StatefulWidget {
  const LoginState({super.key});
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginState> {
  String enteredText = '';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin() {
    if(usernameController.text.isEmpty || passwordController.text.isEmpty){
      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No empty fields'),
              actions: [
                TextButton(
                    onPressed: (){
                      enteredText = '';
                      Navigator.of(context).pop();
                    },
                    child: Text('ok')
                )
              ],
            );
          }
      );
    } else {
      User user = User(password: passwordController.text , username: usernameController.text);
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard' , (_) => false , arguments: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            LoginButton(onPressed: handleLogin,),
            const SizedBox(
              height: 20,
            ),
            TextButton(onPressed: () => {
              Navigator.pushNamed(context, '/signup')
            }, child: Text('Create an account'))
          ],
        ),
      ),
    );
  }

}