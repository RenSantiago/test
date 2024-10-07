import 'package:flutter/material.dart';
import 'package:testsampleproject/Models/User.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          Text(
            'Hello ${user.username}  , here is your dashboard' ,
            style: const TextStyle(
                fontSize: 24 ,
                fontWeight: FontWeight.bold
            ),
          ),
          TextButton(onPressed: () => {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false)
          },  child: const Text('Sign out'))
        ],
      ),
    );
  }
}