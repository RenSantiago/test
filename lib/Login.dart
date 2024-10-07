import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  TextEditingController textController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      )
  );

  TextField Function(TextEditingController params) UsernameField = (params) => TextField(
    controller: params,
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)
        ) ,
        labelText: 'Username',
        prefixIcon: Icon(Icons.person)
    ),
  );

  TextField Function(TextEditingController controller) PasswordField = (controller) => TextField(
    controller : controller,
    obscureText: true,
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
      ) ,
      labelText: 'Password',
      prefixIcon: const Icon(Icons.key)
    ),
  );

  void handleLogin() {
    if(textController.text.isEmpty || passwordController.text.isEmpty){
      textController.clear();
      passwordController.clear();

      showDialog(context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hello'),
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
      setState(() {
        enteredText = '${textController.text} ${passwordController.text}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UsernameField(textController),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PasswordField(passwordController),
            ),
            SizedBox(
              width: double.infinity,
              child:  Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                    onPressed: handleLogin,
                    style: buttonStyle,
                    child: const Text(
                      'Login' ,
                      style: TextStyle(
                          fontSize:
                          16
                      ),
                    )
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(enteredText , style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }

}