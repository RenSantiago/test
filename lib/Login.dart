import 'package:flutter/material.dart';
import 'package:testsampleproject/Models/User.dart';
import 'package:testsampleproject/components/Formfield.dart';
import 'package:testsampleproject/components/LoginButton.dart';


class LoginState extends StatefulWidget {
  const LoginState({super.key});
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginState> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin() {
    if(usernameController.text.isEmpty || passwordController.text.isEmpty){
      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('No empty fields'),
              actions: [
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: const Text('ok')
                )
              ],
            );
          }
      );
    }
    else {
      User user = User(
          password: passwordController.text.toString() ,
          username: usernameController.text.toString());

      Navigator
          .pushNamedAndRemoveUntil(context, '/dashboard' , (_) => false ,
          arguments: user);
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
            TextButton(
                onPressed: () => {
              Navigator.pushNamed(context, '/signup')
            },
                child: const Text('Create an account'))
          ],
        ),
      ),
    );
  }

}