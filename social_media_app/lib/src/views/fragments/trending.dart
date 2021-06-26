import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/social_media.dart';

class TrendingPosts extends StatefulWidget {
  @override
  _TrendingPostsState createState() => _TrendingPostsState();
}

class _TrendingPostsState extends State<TrendingPosts> {
  final List<Map<String, Object>> trendingPosts = [
    PostItem(uid: '1', imgUrl: 'https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTU3ODc5MDg1NjI5OTA4Mjk3/nature-pollution.jpg',caption: 'Pollution By Plastic', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 1, status: PostStatus.Pending, postedBy: {PostItem.POST_USER_NAME: 'Raghav',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
    PostItem(uid: '1', imgUrl: 'https://images.unsplash.com/photo-1564608938148-e3c5325907ee?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9sbHV0aW9ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',caption: 'Air pollution', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 5, status: PostStatus.Pending, postedBy: {PostItem.POST_USER_NAME: 'Piyush',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
    PostItem(uid: '1', imgUrl: 'https://images.unsplash.com/photo-1564608938148-e3c5325907ee?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9sbHV0aW9ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',caption: 'Air pollution', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 5, status: PostStatus.Pending, postedBy: {PostItem.POST_USER_NAME: 'Piyush',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
    PostItem(uid: '1', imgUrl: 'https://images.unsplash.com/photo-1564608938148-e3c5325907ee?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9sbHV0aW9ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',caption: 'Air pollution', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 5, status: PostStatus.Pending, postedBy: {PostItem.POST_USER_NAME: 'Piyush',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
    PostItem(uid: '1', imgUrl: 'https://images.unsplash.com/photo-1564608938148-e3c5325907ee?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9sbHV0aW9ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',caption: 'Air pollution', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 5, status: PostStatus.Pending, postedBy: {PostItem.POST_USER_NAME: 'Piyush',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
    PostItem(uid: '1', imgUrl: 'https://images.unsplash.com/photo-1564608938148-e3c5325907ee?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9sbHV0aW9ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',caption: 'Air pollution', address: "address", region: "region", location: GeoPoint(0,0), upvotes: 5, status: PostStatus.Pending, postedBy: {PostItem.POST_USER_NAME: 'Piyush',PostItem.POST_IMG_URL:'https://t3.ftcdn.net/jpg/02/22/85/16/360_F_222851624_jfoMGbJxwRi5AWGdPgXKSABMnzCQo9RN.jpg'}, timestamp: Timestamp(1,1)).toMap(),
  ];

  Future<void> getTrendingPosts() async {

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
            return TrendingItem(
              item: PostItem.fromMap(item.value),
              index: item.key + 1,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: TrendItemDialog(
                      item: PostItem.fromMap(item.value),
                      index: item.key + 1,
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
