import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class ChatRoom extends StatefulWidget {
  final String receiverId, name, picURL;
  final int receiverLevel;

  const ChatRoom({Key key, this.name, this.receiverId, this.receiverLevel, this.picURL})
      : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final messageController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  String message;

  @override
  void initState() {
    super.initState();
    User _user = _auth.currentUser;
    if (_user != null) {
      user = _user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name.split(' ').first}\'s Chats'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirestoreService().messageStream(user.uid, widget.receiverId, sharedPreferences.authLevel, widget.receiverLevel).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var chatData = snapshot.data.data();

                if (chatData == null) {
                  return NoChatBubble();
                }

                return ListView.builder(
                  itemCount: chatData['messages'].length,
                  itemBuilder: (context, index) {
                    var message = chatData['messages'][index];
                    return MessageBubble(text: message['text'], isMe: message['sender'] == user.uid);
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message'
                    ),
                    controller: messageController,
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    messageController.clear();
                    FirebaseFunctionService().sendMessage(
                      text: message,
                      userName: FirebaseAuthService.user.displayName,
                      userLevel: sharedPreferences.authLevel,
                      userImg: FirebaseAuthService.user.photoURL ?? 'https://picsum.photos/50',
                      receiverId: widget.receiverId,
                      receiverName: widget.name,
                      receiverImg: widget.picURL,
                      receiverLevel: widget.receiverLevel,
                    );
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
