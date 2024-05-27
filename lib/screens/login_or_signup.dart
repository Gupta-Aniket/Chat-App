import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/signUp_screen.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool register = false;
  void change() {
    setState(() {
      register = !register;
    });
  }

  Widget build(BuildContext context) {
    if (register)
      return RegisterPage(onTap: () {
        change();
      });
    else
      return LoginPage(onTap: () {
        change();
      });
  }
}
