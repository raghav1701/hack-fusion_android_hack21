import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/social_media.dart';

class TrendingPosts extends StatefulWidget {
  @override
  _TrendingPostsState createState() => _TrendingPostsState();
}

class _TrendingPostsState extends State<TrendingPosts> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> trendingPosts = [];

  Future<void> getTrendingPosts() async {
    var result = await FirestoreService().getTrendingPosts();

    if (!mounted) return;

    if (result.code == Code.SUCCESS) {
      setState(() {
        trendingPosts = result.data;
      });
    } else {
      //TODO: Missing Error handling
    }
  }

  @override
  void initState() {
    super.initState();
    getTrendingPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          staggeredTiles: trendingPosts.asMap().entries.map((item) {
            if (item.key == 0)
              return StaggeredTile.count(2, 1);
            return StaggeredTile.count(1, item.key % 2 == 0 ? 1.5 : 1);
          }).toList(),
          children: trendingPosts.asMap().entries.map((item) {
            var postitem = PostItem.fromMap(item.value.data());
            return TrendingItem(
              item: postitem,
              index: item.key + 1,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))
                    ),
                    child: TrendItemDialog(
                      item: postitem,
                      profileTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                          return ProfileScreen(
                            uid: postitem.uid,
                            authLevel: 1,
                            profilePic: postitem.postedBy[PostItem.POST_IMG_URL],
                            name: postitem.postedBy[PostItem.POST_USER_NAME],
                          );
                        }));
                      },
                      index: item.key + 1,
                      onUpvote: () {
                        FirebaseFunctionService().upvotePost(item.value.id);
                      },
                      onMarkSolved: () async {
                        var result = await FirestoreService().updatePostStatus(item.value.id, 1);
                        if (result.code == Code.SUCCESS) {
                          
                        } else {
                          //TODO: handle any error
                        }
                      },
                      onSharePost: () {
                        //TODO: Share Pic
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
