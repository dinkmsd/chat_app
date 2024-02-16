import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String conversationID;
  final String? imageURL;
  final String title;
  const ChatItem(
      {super.key,
      required this.conversationID,
      required this.title,
      this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(imageURL!),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("chats").doc(conversationID).collection("messages").orderBy("createAt").snapshots(),
                    builder: (context, snapshot) {
                      String content = '';
                      if (snapshot.hasData) {
                        content = snapshot.data!.docs[0]['text'];
                      }
                      return Text(
                        content,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
