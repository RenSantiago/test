import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'FORM STATE',
        home: LoginState(),
    );
    }
}

class LoginState extends StatefulWidget {
  const LoginState({super.key});
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginState> {
  String enteredText = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      )
  );

  Padding Function({TextEditingController? controller, String? label, Icon? fieldIcon, bool? obscure})
  FormField = ({controller, label , fieldIcon , obscure}) => Padding(
    padding : EdgeInsets.all(16),
    child: TextField(
      controller: controller,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5)
          ) ,
          labelText: label,
          prefixIcon: fieldIcon
      ),
    ),
  );

  SizedBox Function({void Function()? onPressed, ButtonStyle? style})
  LoginButton = ({onPressed, style}) => SizedBox(
    width: double.infinity,
    child:  Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: const Text(
            'Login' ,
            style: TextStyle(
                fontSize:
                16
            ),
          )
      ),
    ),
  );

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
      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your username ${usernameController.text} and password ${passwordController.text}'),
              actions: [
                TextButton(
                    onPressed: (){
                      usernameController.clear();
                      passwordController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('ok')
                )
              ],
            );
          }
      );
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
            FormField(
                controller: usernameController ,
                label: 'Username' ,
                fieldIcon: const Icon(Icons.person)
            ),
            FormField(
              controller: passwordController ,
              label: 'Password' ,
              fieldIcon: const Icon(Icons.key),
            obscure: true
            ),
            LoginButton(
              onPressed: handleLogin ,
              style: buttonStyle
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

}