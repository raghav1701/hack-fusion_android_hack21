import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';
import 'package:social_media_app/src/widgets/admin/approve_item.dart';

class RequestApprovalScreen extends StatefulWidget {
  final int level;

  const RequestApprovalScreen({
    Key key,
    this.level = 2,
  }) : super(key: key);

  @override
  _RequestApprovalScreenState createState() => _RequestApprovalScreenState();
}

class _RequestApprovalScreenState extends State<RequestApprovalScreen> {
  String error;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> items = [];

  Future<void> getPendingPosts() async {
    setState(() {
      error = null;
    });
    var result = await FirestoreService().getPendingRequests(widget.level);

    if (!mounted) return;

    if (result.code == Code.SUCCESS) {
      setState(() {
        items = result.data;
      });
    } else {
      setState(() {
        error = result.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return RequestApprovalCard(
          item: RequestItem.fromMap(items[index].data()),
          imgURL: Assets.loginPageImage,
          onDeny: () {},
          onApprove: () {},
        );
      },
    );
  }
}
