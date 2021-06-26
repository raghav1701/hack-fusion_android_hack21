import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showConfirmDialog(BuildContext context, String title,
    {String content,
    Widget child,
    String denyText,
    String acceptText,
    Function onAccept}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: child ?? Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(denyText ?? 'Cancel'),
          ),
          TextButton(
            onPressed: onAccept,
            child: Text(acceptText ?? 'Confirm'),
          ),
        ],
      );
    },
  );
}
