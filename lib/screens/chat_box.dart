import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final String conversationID;
  const ChatBox({super.key, required this.conversationID});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat App"),
        ),
        body: Column(
          children: [
            Expanded(child: ChatMessage(conversationID: widget.conversationID,)),
            NewMessage(conversationID: widget.conversationID,),
          ],
        ));
  }
}
