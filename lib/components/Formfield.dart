
import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  MyFormField({super.key ,this.controller , this.label = '' , this.fieldIcon , this.obscure , this.editable });

  final TextEditingController? controller;
  final String label;
  final Icon? fieldIcon;
  final bool? obscure;
  final bool? editable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : EdgeInsets.all(16),
      child: TextField(
        enabled: editable != null ? editable! : true,
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
  }

}
