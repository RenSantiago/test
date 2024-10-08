
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:testsampleproject/Models/UserEntity.dart';

class AwesomeSignUpPage extends StatefulWidget {
  final Store store;
  const AwesomeSignUpPage(this.store);

  @override
  State<AwesomeSignUpPage> createState() => _AwesomeSignUpPageState();
}

class _AwesomeSignUpPageState extends State<AwesomeSignUpPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late final Box<UserEntity> _userBox;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBox = widget.store.box<UserEntity>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    email.dispose();
    password.dispose();

    super.dispose();

  }

  void handleSignup() {
    UserEntity payload = UserEntity(username: name.text, email: email.text, password: password.text);
    _userBox.put(payload);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'), // Background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Signup form and content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Image.asset(
                          'assets/logo.png', // Your logo image
                          height: 100,
                        ),
                        SizedBox(height: 20),
                        const Text(
                          "Create an Account",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Name field
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Email field
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Password field
                        TextField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        SizedBox(height: 30),
                        // Signup button
                        ElevatedButton(
                          onPressed: handleSignup,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), backgroundColor: Colors.blueAccent, // Button color
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 80.0),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Already have an account
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to login screen
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.yellowAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}