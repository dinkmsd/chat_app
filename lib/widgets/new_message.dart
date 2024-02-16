import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String conversationID;
  const NewMessage({super.key, required this.conversationID});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

    await FirebaseFirestore.instance.collection("chats").doc(widget.conversationID).collection("messages").add({
      "text": enteredMessage,
      "createAt": Timestamp.now(),
      "username": userData.data()!['username'],
      "userImage": userData.data()!['imageURL'],
      "userId": user.uid,
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 1.0, bottom: 14.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageController,
            decoration: const InputDecoration(labelText: "Send a message..."),
            autocorrect: true,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: true,
          )),
          IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
