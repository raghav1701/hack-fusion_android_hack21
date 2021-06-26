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
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: imgURL,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name),
                Text(item.address),
                Text(item.phone),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    OutlinedButton.icon(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        'Approve',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: onApprove,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
