import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String reciverId;
  String senderEmail;
  String message;
  Timestamp timestamp;

  Message({
    required this.senderId,
    required this.reciverId,
    required this.senderEmail,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'reciverId': reciverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
