import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class AddPost extends StatelessWidget {
  AddPost(this.mycontext);

  final BuildContext mycontext;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthButton(
              buttonText: 'Click Image ',
              onPressed: () {
                clickImage(mycontext);
              },
            ),
            SizedBox(height: 24.0),
            AuthButton(
              buttonText: 'Pick from Gallery',
              onPressed: () {
                pickFromGallery(mycontext);
              },
            )
          ],
        ),
      ),
    );
  }
}
