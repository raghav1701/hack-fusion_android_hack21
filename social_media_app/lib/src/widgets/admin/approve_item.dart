import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class RequestApprovalCard extends StatelessWidget {
  final RequestItem item;
  final String imgURL;
  final Function onApprove;
  final Function onDeny;

  const RequestApprovalCard({
    Key key,
    this.item,
    this.onApprove,
    this.onDeny,
    this.imgURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: imgURL),
            Expanded(
              child: Column(
                children: [
                  Text(item.name),
                  Text(item.address),
                  Text(item.phone),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
