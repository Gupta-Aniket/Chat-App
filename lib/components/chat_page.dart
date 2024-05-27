import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  String reciverEmail = '';
  String reciverId = '';
  ChatPage({required this.reciverEmail, required this.reciverId});

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // send message only when TEC not empty
      await _chatService.sendMessage(reciverId, _messageController.text);

      //clear text
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reciverEmail.split('@')[0]),
        elevation: 5,
        backgroundColor: Colors.black26,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),

          // userInput
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildUserInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: _chatService.getMessages(reciverId, senderId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error Loading Chats'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading...'));
          }
          var userList = snapshot.data!.docs;
          return ListView(
            children: userList.map((DocumentSnapshot doc) {
              return _buildMessageListItem(doc);
            }).toList(),
          );
        });
  }

  Widget _buildMessageListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(
          isCurrentUser: isCurrentUser,
          message: data['message'],
        ),
      ],
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(
            controller: _messageController,
            hintText: 'Enter a Message ',
            obsText: false,
          ),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.send_outlined,
              size: 30,
              color: Colors.green,
            ),
            onPressed: sendMessage,
          ),
        ),
      ],
    );
  }
}
