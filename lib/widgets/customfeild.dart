import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? Onchange;
  final Function()? Ontap;
  final String? hintname;
  final TextInputType? keyboradtype;
  final validator;
  final cursorColor;
  final fillColor;
  final boderides;
   final TextStyle?hintstyle;
  CustomSearchField({
    this.controller,
    this.Onchange,
     this.hintname,
    this.Ontap,
    this.keyboradtype,
    this.validator,
    this.cursorColor,
    this.fillColor, this.boderides, this.hintstyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboradtype,
        onChanged: Onchange,
        onTap: Ontap,
        cursorColor: cursorColor,
        controller: controller,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.green,
                )),
            filled: true,
            fillColor: fillColor,
            hintText: hintname,
            hintStyle: hintstyle,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide())),
      ),
    );
  }
}
