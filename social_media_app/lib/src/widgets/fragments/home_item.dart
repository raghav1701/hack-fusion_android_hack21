import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';
import 'package:social_media_app/src/models/models.dart';
import 'package:social_media_app/src/shared/constants.dart';

class MyPost extends StatelessWidget {
  static const borderRadius = 16.0;

  const MyPost({
    this.item,
    this.onProfileTap,
    this.onMarkSolved,
    this.onShare,
    this.onGetDirections,
    this.onUpvote,
  });

  final PostItem item;
  final Function onProfileTap;
  final Function onMarkSolved;
  final Function onShare;
  final Function onGetDirections;
  final Function onUpvote;

  final menuItems = const ['Get Directions', 'Mark as Solved', 'Share'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      height: kScreenHeight * 0.4,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: CachedNetworkImage(
              imageUrl: item.imgUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: 56.0,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: ListTile(
              leading: TapDetector(
                onTap: onProfileTap,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      item.postedBy[PostItem.POST_IMG_URL]),
                ),
              ),
              title: Text(item.postedBy[PostItem.POST_USER_NAME]),
              subtitle: Text(
                item.address,
                style: TextStyle(color: Colors.white),
              ),
              trailing: PopupMenuButton(
                child: Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (context) {
                  return menuItems.map((e) {
                    return PopupMenuItem(
                      child: Text(e),
                    );
                  }).toList();
                },
                onSelected: (val) {
                  if (val == menuItems[0]) {
                    onGetDirections();
                  } else if (val == menuItems[1]) {
                    onMarkSolved();
                  } else {
                    onShare();
                  }
                },
              ),
              visualDensity: VisualDensity(vertical: -4.0),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 36.0,
                              child: IconButton(
                                icon: Icon(Icons.thumb_up_outlined),
                                color: Colors.white,
                                splashRadius: 24.0,
                                onPressed: onUpvote ?? () {},
                              ),
                            ),
                            Text(
                              '${item.upvotes} \t|',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.caption,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
