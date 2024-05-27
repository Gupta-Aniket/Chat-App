import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  void Function()? onTap;
  LoginPage({required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _eMailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  void signIn(BuildContext context) async {
    //auth service
    final authService = AuthService();
    print(_eMailController.text);
    print(_pwdController.text);
    // try login
    try {
      await authService.signInWithEmailAndPassword(
        _eMailController.text,
        _pwdController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            const Icon(Icons.forward_to_inbox, size: 100),

            const SizedBox(height: 40),
            // welcome back text, missed you!
            const Text(
              'Welcome Back!, I was missing you 🥺',
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

            CustomTextField(
              controller: _pwdController,
              hintText: 'Enter Password',
              obsText: true,
            ),

            const SizedBox(height: 40),
            CustomButton(
              buttonText: 'Sign In',
              onTap: () => signIn(context),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to the app? '),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Register Now!',
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
    );
  }
}
