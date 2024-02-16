import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String conversationID;
  const ChatMessage({super.key, required this.conversationID});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats").doc(conversationID).collection("messages")
            .orderBy('createAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No message found!!!"),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong..."),
            );
          }

          final loadedMessage = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: loadedMessage.length,
              reverse: true,
              itemBuilder: (context, index) {
                final chatMessage = loadedMessage[index].data();
                final nextChatMessage = index + 1 < loadedMessage.length
                    ? loadedMessage[index + 1]
                    : null;
                final currentMessageUserId = chatMessage['userId'];
                final nextMessageUserId =
                    nextChatMessage != null ? nextChatMessage['userId'] : null;
                final nextUserIsSame =
                    currentMessageUserId == nextMessageUserId;
                if (nextUserIsSame) {
                  return MessageBubble.next(
                      message: chatMessage['text'],
                      isMe: currentMessageUserId == currentUser.uid);
                } else {
                  return MessageBubble.first(
                      userImage: chatMessage['userImage'],
                      username: chatMessage['username'],
                      message: chatMessage['text'],
                      isMe: currentMessageUserId == currentUser.uid);
                }
                // return Text(loadedMessage[index].data()['text']);
              });
        });
  }
}
