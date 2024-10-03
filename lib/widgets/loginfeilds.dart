import 'package:flutter/material.dart';

// ignore: must_be_immutable
class loginfeild extends StatelessWidget {
  String hinttxt;
  bool isobscure;
  TextEditingController controller;
  final validator;
  final IconButton? iconbutton;
  loginfeild({
    required this.hinttxt,
    required this.isobscure,
    required this.controller,
    this.validator,
    this.iconbutton,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: TextStyle(color: Colors.white),
      obscureText: isobscure,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hinttxt,
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.white, strokeAlign: 10, width: 5),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: iconbutton,
      ),
    );
  }
}
