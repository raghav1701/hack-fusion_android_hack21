import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/social_media.dart';

class TrendingPosts extends StatefulWidget {
  @override
  _TrendingPostsState createState() => _TrendingPostsState();
}

class _TrendingPostsState extends State<TrendingPosts> {
  List<Map<String, Object>> trendingPosts = [
    PostItem(uid: 'l9X2gglxMsWxX1X8aazibqOIcqk2', imgUrl: 'https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTU3ODc5MDg1NjI5OTA4Mjk3/nature-pollution.jpg',caption: 'Pollution By Plastic', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 1, status: 0, postedBy: {PostItem.POST_USER_NAME: 'Raghav',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
  ];

  Future<void> getTrendingPosts() async {
    var result = await FirestoreService().getTrendingPosts();

    if (!mounted) return;

    if (result.code == Code.SUCCESS) {
      setState(() {
        trendingPosts.addAll(result.data.map((e) => e.data()));
        trendingPosts = result.data.map((e) => e.data()).toList();
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
            var postitem = PostItem.fromMap(item.value);
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
                      onMarkSolved: () {
                        //TODO: ON MARKED SOLVED
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
