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
    this.onMarkClose,
    this.onMarkFake,
    this.onShare,
    this.onGetDirections,
    this.onUpvote,
  });

  final PostItem item;
  final Function onProfileTap;
  final Function onMarkSolved;
  final Function onMarkClose;
  final Function onMarkFake;
  final Function onShare;
  final Function onGetDirections;
  final Function onUpvote;

  void handlePopupMenu(String val) {
    print("handle called");
    if (val == 'Get Directions') {
      onGetDirections();
    } else if (val == 'Mark as Solved') {
      print("mark called");
      onMarkSolved();
    } else if (val == 'Share') {
      onShare();
    } else {
      onMarkClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var level = sharedPreferences.authLevel;
    List<String> menuItems;

    if (level == 1) {
      menuItems = const ['Get Directions', 'Share'];
    } else if (level == 2) {
      menuItems = const ['Get Directions', 'Mark as Solved', 'Share'];
    } else {
      menuItems = const ['Get Directions', 'Close Issue', 'Share'];
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      height: kScreenHeight * 0.4,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            child: CachedNetworkImage(
              imageUrl: item.imgUrl,
              height: kScreenHeight * 0.4,
              width: double.infinity,
              fit: BoxFit.fill,
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
                item.address + ', ' + item.region,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
              trailing: PopupMenuButton<String>(
                child: Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (context) {
                  return menuItems.map((e) {
                    return PopupMenuItem<String>(
                      child: Text(e),
                      value: e,
                    );
                  }).toList();
                },
                onSelected: handlePopupMenu,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
