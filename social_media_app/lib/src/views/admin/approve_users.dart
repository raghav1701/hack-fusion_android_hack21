import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:social_media_app/social_media.dart';
import 'package:social_media_app/src/widgets/admin/approve_item.dart';

class RequestApprovalScreen extends StatefulWidget {
  final int level;

  const RequestApprovalScreen(this.level, {
    Key key,
  }) : super(key: key);

  @override
  _RequestApprovalScreenState createState() => _RequestApprovalScreenState();
}

class _RequestApprovalScreenState extends State<RequestApprovalScreen> {
  ProgressDialog progressDialog;
  bool loading = true;
  String error;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> items = [];

  Future<void> getPendingPosts() async {
    setState(() {
      loading = true;
      error = null;
    });
    var result = await FirestoreService().getPendingRequests(widget.level);

    if (!mounted) return;

    if (result.code == Code.SUCCESS) {
      setState(() {
        loading = false;
        items = result.data.toList();
      });
    } else {
      print(result.message);
      setState(() {
        loading = false;
        error = result.message;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPendingPosts();
    progressDialog = ProgressDialog(
      context,
      isDismissible: false,
      type: ProgressDialogType.Normal,
      customBody: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text('Approving User...'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !loading,
      replacement: Center(child: CircularProgressIndicator()),
      child: Visibility(
        visible: error == null,
        child: Visibility(
          visible: items.length > 0,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = RequestItem.fromMap(items[index].data());
              return RequestApprovalCard(
                item: item,
                imgURL: 'https://picsum.photos/100',
                onDeny: () {},
                onApprove: () async {
                  await progressDialog.show();
                  var result = await FirebaseFunctionService().approveUpgradeRequest(item.uid);
                  await progressDialog.hide();
                  if (result.code == Code.SUCCESS) {
                    items.removeAt(index);
                    setState(() {});
                    ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Approved Successfully')));
                  } else {
                    ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('${result.message}')));
                  }
                },
              );
            },
          ),
          replacement: Center(
            child: Text('No Requests yet'),
          ),
        ),
        replacement: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$error'),
              OutlinedButton(
                child: Text('Retry'),
                onPressed: getPendingPosts,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
