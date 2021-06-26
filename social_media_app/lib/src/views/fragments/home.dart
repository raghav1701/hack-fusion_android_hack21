import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class Home extends StatefulWidget {
  final BuildContext context;

  const Home(this.context);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Query<Map<String, dynamic>> stream;

  @override
  void initState() {
    super.initState();
    var level = sharedPreferences.authLevel;
    if (level == 1) {
      stream = FirebaseFirestore.instance.collection("posts").where(PostItem.STATUS, isLessThanOrEqualTo: 1);
    } else if (level == 2) {
      stream = FirebaseFirestore.instance.collection("posts").where(PostItem.STATUS, isEqualTo: 0);
    } else if (level == 3) {
      stream = FirebaseFirestore.instance.collection("posts").where(PostItem.STATUS, isEqualTo: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream : stream.snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          if (snapshot.data.size == 0) {
            return Center(
              child: Text('No Posts'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.size,
            itemBuilder: (context, index){
              var doc = snapshot.data.docs[index];
              var item = PostItem.fromMap(doc.data());
              return MyPost(
                item: item,
                onProfileTap: () {
                  Navigator.of(widget.context).push(MaterialPageRoute(builder: (_) {
                    return ProfileScreen(
                      uid: item.uid,
                      authLevel: 1,
                      name: item.postedBy[PostItem.POST_USER_NAME],
                      profilePic: item.postedBy[PostItem.POST_IMG_URL],
                    );
                  }));
                },
                onUpvote: () {
                  FirebaseFunctionService().upvotePost(doc.id);
                },
                onMarkSolved: () async {
                  var result = await FirestoreService().updatePostStatus(doc.id, 1);
                  if (result.code == Code.SUCCESS) {

                  } else {
                    //TODO: handle any error
                  }
                },
                onMarkClose: () async {
                  var result = await FirestoreService().updatePostStatus(doc.id, 2);
                  if (result.code == Code.SUCCESS) {

                  } else {
                    //TODO: handle any error
                  }
                },
                onMarkFake: () async {
                  var result = await FirestoreService().updatePostStatus(doc.id, 3);
                  if (result.code == Code.SUCCESS) {

                  } else {
                    //TODO: handle any error
                  }
                },
                onGetDirections: () {
                  //TODO: Get Directions
                },
                onShare: () {
                  //TODO: Share Pic
                },
              );
            },
          );
        },
      )


    );
  }
}
