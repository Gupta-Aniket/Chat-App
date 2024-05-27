import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String hintText;
  bool obsText;
  TextEditingController controller;
  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.obsText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[800],
          fontSize: 18,
        ),
        border: OutlineInputBorder(),
      ),
      obscureText: obsText,
    );
  }
}
