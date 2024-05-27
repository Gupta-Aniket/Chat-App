import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText = '';
  void Function()? onTap;
  CustomButton({required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[800],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: (const TextStyle(
              fontSize: 16,
            )),
          ),
        ),
      ),
    );
  }
}
