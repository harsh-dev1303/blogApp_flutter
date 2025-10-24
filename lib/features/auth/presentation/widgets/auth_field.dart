import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  const AuthField({
    super.key,
    required this.hintText,
    this.isObsecure = false,
    required this.controller
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
      validator: (value) {
        if(value == null || value.isEmpty){
          return "$hintText is required";
        }
        return null;
      },
      decoration: InputDecoration(
         hint: Text(hintText)
      ),
      obscureText: isObsecure,
      
    );
  }
}