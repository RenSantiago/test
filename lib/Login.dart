import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:testsampleproject/Models/UserEntity.dart';
import 'package:testsampleproject/Models/UserFirestore.dart';
import 'package:testsampleproject/Services/UserFirestoreService.dart';
import 'package:testsampleproject/components/Formfield.dart';
import 'package:testsampleproject/components/LoginButton.dart';
import 'package:testsampleproject/objectbox.g.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginState extends StatefulWidget {
  final Store store;
  const LoginState(this.store);
  @override
  _Login createState() => _Login();
}

class _Login extends State<LoginState> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _verificationId = '';
  String message = '';
  late final Box<UserEntity> _userBox;
  UserFirestoreService _userFirestoreService = UserFirestoreService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userBox = widget.store.box<UserEntity>();
  }

  void handleLoginViaPhone() async {
      try {
        String phoneNumber = usernameController.text.trim();
        if(phoneNumber.isEmpty) {
          throw();
        }
        await _auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) async {
              // Auto verification success
              await _auth.signInWithCredential(credential);
              print('success');
              // Handle successful login here
            },
            verificationFailed: (FirebaseAuthException e) {
              print('success coming');

              // // Handle error
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Verification failed: ${e.message}"),
              ));
            },
            codeSent: (String verificationId, int? resendToken) {
              // Code sent to user's phone
              setState(() {
                _verificationId = verificationId;
                print('codeSent $_verificationId');

              });
              print('codeSent');

            },
            codeAutoRetrievalTimeout: (String verificationId) {
              // Auto-retrieval timeout
              print('codeAutoRetrievalTimeout');

            }
        );
      } catch(err) {
        message = 'invalid credentials' ;
        _snackBar();
      }
  }

  void handleOtp() async {
    String otp = passwordController.text.trim();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: otp,
    );

    try {
      await _auth.signInWithCredential(credential);
      // Handle successful login
      print('super success');
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false , arguments: 'test');
    } catch (e) {
      print('super success on the way $e');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in: ${e.toString()}"),
      ));
    }

  }

  void handleLogin() async {
  try{
   UserFirestore user = await _userFirestoreService.getUser(usernameController.text);
    if(user.password != passwordController.text) {
      throw();
    };
   Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false , arguments: user.id);
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

  Widget showWidgetIfEmpty(Widget yourWidget) {
    if(_verificationId.isEmpty) {
      return yourWidget;
    } else {
      return SizedBox();
    }
  }

  Widget showWidgetIfNotEmpty(Widget yourWidget) {
    if(_verificationId.isNotEmpty) {
      return yourWidget;
    } else {
      return SizedBox();
    }
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
                  label: 'Phone Number' ,
                  fieldIcon: const Icon(Icons.phone),
                  editable: _verificationId.isEmpty,
              ),
              showWidgetIfNotEmpty(MyFormField(
                  controller: passwordController ,
                  label: 'otp' ,
                  fieldIcon: const Icon(Icons.key),
                  obscure: true
              )) ,
              const SizedBox(
                height: 20,
              ),
              _verificationId.isEmpty ?
                LoginButton(onPressed: handleLoginViaPhone , label: 'Sign in',) :
                LoginButton(onPressed: handleOtp , label: 'Send OTP Details',),
              showWidgetIfEmpty(SignInButton(
                Buttons.Facebook,
                mini: true,
                onPressed: () {
                  print('im pressed');
                },
              )),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/signup')
                  },
                  child: const Text('Create an account')),

            ],
          ),
        ),
      ),
    );
  }

}