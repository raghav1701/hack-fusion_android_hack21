import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/social_media.dart';

Future<void> clickImage(context) async {
  await ImagePicker().getImage(source: ImageSource.camera).then((value) {
    if (value != null) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => MakePost(postFile: value)));
    }
  });
}

Future<void> pickFromGallery(context) async {
  await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
    if (value != null) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => MakePost(postFile: value)));
    }
  });
}
