import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Chats'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirestoreService().chatStream(FirebaseAuthService.user.uid, sharedPreferences.authLevel).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data.size == 0) {
            return Center(child: Text('No chats yet.'));
          }

          var docs = snapshot.data.docs;

          return ListView.builder(
            itemCount: snapshot.data.size,
            itemBuilder: (context, index) {
              var doc = docs[index].data();
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    doc['profileImg'],
                  ),
                ),
                title: Text(doc['name']),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) {
                      return ChatRoom(
                        name: doc['name'],
                        picURL: doc['profileImg'],
                        receiverId: docs[index].id,
                        receiverLevel: doc['level'],
                      );
                    }
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
