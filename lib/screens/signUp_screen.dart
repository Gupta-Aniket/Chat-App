import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;

  RegisterPage({required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _eMailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();

  bool error = false;

  void register(BuildContext context) async {
    if (_pwdController.text == _confirmPwdController.text) {
      setState(() {
        error = false;
      });
      try {
        final _auth = AuthService();
        await _auth.signUpWithEmailAndPassword(
            _eMailController.text, _pwdController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error Signing up!!'),
              content: Text(e.toString()),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error Signing up!!'),
              content: Text(e.code),
            ),
          );
        }
      }
    } else {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //icon
              const Icon(Icons.contact_mail, size: 100),

              const SizedBox(height: 40),
              // welcome back text, missed you!
              const Text(
                'Let\'s get you signed up!',
                style: TextStyle(fontSize: 16),
              ),
              // login text field
              const SizedBox(height: 40),

              CustomTextField(
                controller: _eMailController,
                hintText: 'Enter email',
                obsText: false,
              ),

              const SizedBox(height: 10),

              Container(
                color: error ? Colors.redAccent : Colors.transparent,
                child: CustomTextField(
                  controller: _pwdController,
                  hintText: 'Enter Password',
                  obsText: true,
                ),
              ),

              const SizedBox(height: 10),
              Container(
                color: error ? Colors.redAccent : Colors.transparent,
                child: CustomTextField(
                  controller: _confirmPwdController,
                  hintText: 'Confirm Password',
                  obsText: true,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                error ? 'Passwords do not match!!' : '',
                style: TextStyle(color: Colors.redAccent),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(height: 40),

              CustomButton(
                buttonText: 'Sign Up',
                onTap: () => register(context),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Registered? '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // register
              //
            ],
          ),
        ),
      ),
    );
  }
}
