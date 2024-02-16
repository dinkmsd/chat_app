import 'package:chat_app/screens/chat_box.dart';
import 'package:chat_app/widgets/chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = await fcm.getToken();
    print('Token: $token');
  }

  Future<List<String>> getUserConversations(String userId) async {
    List<String> conversations = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('group_chats')
          .where('participants', arrayContains: userId)
          .get();

      querySnapshot.docs.forEach((doc) {
        conversations.add(doc.id);
      });
    } catch (e) {
      print('Error fetching conversations: $e');
    }

    return conversations;
  }

  @override
  void initState() {
    super.initState();
    // setupPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat App"),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.exit_to_app)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.message),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .where('members', arrayContains: currentUser.uid)
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

              final listMessages = snapshot.data!.docs;
              return ListView.builder(
                itemCount: listMessages.length,
                itemBuilder: (context, index) {
                  var members = listMessages[index]['members'];
                  String otherID = '';

                  otherID =
                      members.firstWhere((userId) => userId != currentUser.uid);

                  if (otherID != '') {
                    print(otherID);
                  }

                  // DocumentReference reference =
                  //     listMessages[index]['members'][otherID];
                  // String reservationName = '';
                  // String imageURL = '';
                  // reference.get().then((DocumentSnapshot refDocumentSnapshot) {
                  //   if (refDocumentSnapshot.exists) {
                  //     Map<String, dynamic> data =
                  //         refDocumentSnapshot.data() as Map<String, dynamic>;
                  //     reservationName = data['username'];
                  //     imageURL = data['imageURL'];
                  //   } else {
                  //     print('Document does not exist');
                  //   }
                  // });
                  // final imageURL = FirebaseFirestore.instance.collection("users").doc(otherID).snapshots();
                  return GestureDetector(
                      onTap: () async {
                        // print("$reservationName   $imageURL");
                        // print(listMessages[index]['member']
                        //     ['8Up41iw6tMdtZFITUR71UYPduV43']);
                        // DocumentReference reference =
                        //     listMessages[index]['members'][otherID];
                        // reference
                        //     .get()
                        //     .then((DocumentSnapshot refDocumentSnapshot) {
                        //   if (refDocumentSnapshot.exists) {
                        //     print(
                        //         'Data from reference: ${refDocumentSnapshot.data()}');
                        //   } else {
                        //     print('Document does not exist');
                        //   }
                        // });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatBox(
                                    conversationID: listMessages[index].id)));
                      },
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(otherID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            final itemData = snapshot.data!;
                            return ChatItem(
                              conversationID: listMessages[index].id,
                              imageURL: itemData['imageURL'],
                              title: itemData['username'],
                            );
                          }));
                },
              );
            }));
  }
}
