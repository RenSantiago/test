
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      )
  );

  LoginButton({super.key , required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child:  Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
            onPressed: onPressed,
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
    );
  }
}
