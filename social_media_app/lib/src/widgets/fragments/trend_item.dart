import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class TrendingItem extends StatelessWidget {
  static const borderRadius = 16.0;

  final PostItem item;
  final Function onTap;
  final int index;

  const TrendingItem({
    Key key,
    @required this.item,
    @required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: CachedNetworkImage(
                imageUrl: item.imgUrl,
                height: 500.0,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  item.postedBy[PostItem.POST_IMG_URL],
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(50.0),
                    topRight: const Radius.circular(borderRadius + 10.0),
                  ),
                  color: Colors.green.withOpacity(0.6),
                ),
                padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 8.0),
                child: Text('#$index', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendItemDialog extends StatelessWidget {
  final PostItem item;
  final int index;
  final Function profileTap;
  final Function onMarkSolved;
  final Function onSharePost;
  final Function onUpvote;

  const TrendItemDialog({
    Key key,
    @required this.item,
    @required this.index,
    this.onSharePost,
    this.profileTap,
    this.onMarkSolved,
    this.onUpvote,
  }) : super(key: key);

  final menuItems = const ['View User', 'Share', 'Mark as Solved'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(item.postedBy[PostItem.POST_IMG_URL]),
          ),
          title: Text(item.postedBy[PostItem.POST_USER_NAME]),
          subtitle: Text(item.address),
          trailing: PopupMenuButton(
            child: Icon(Icons.more_vert),
            itemBuilder: (context) {
              return menuItems.map((e) {
                return PopupMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList();
            },
            onSelected: (val) {
              if (val == menuItems[0]) {
                profileTap();
              } else if (val == menuItems[1]) {
                onMarkSolved();
              } else {
                onSharePost();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: CachedNetworkImage(
              imageUrl: item.imgUrl,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Trending: $index')),
                  SizedBox(
                    width: 36.0,
                    child: IconButton(
                      icon: Icon(Icons.thumb_up_outlined),
                      color: Theme.of(context).primaryColor,
                      splashRadius: 24.0,
                      onPressed: onUpvote ?? () {},
                    ),
                  ),
                  Text(
                    ' ${item.upvotes}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Text(item.caption),
              Text('Updated: ' + convertTimestampToReadable(item.timestamp)),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}
