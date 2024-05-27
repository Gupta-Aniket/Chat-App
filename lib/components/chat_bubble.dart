import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  String message;
  bool isCurrentUser;
  ChatBubble({required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.symmetric(vertical: 2.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
