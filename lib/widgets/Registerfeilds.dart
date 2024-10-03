import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Registerfeilds extends StatelessWidget {
  String hinttxt;
  bool isobscure;
  final TextStyle? txtsty;
  TextEditingController controller;

  final validator;
  final onchange;
  final IconButton? iconbutton;
  Registerfeilds({
    required this.hinttxt,
    required this.isobscure,
    required this.controller,
    this.validator,
    this.txtsty,
    this.onchange,
    this.iconbutton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        style: txtsty,
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
            borderSide: BorderSide(color: Colors.green, strokeAlign: 10),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: iconbutton,
        ),
      ),
    );
  }
}
