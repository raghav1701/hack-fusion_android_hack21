import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/src/views/make_post.dart';

PickedFile pickedfile=null;
final picker=ImagePicker();

class AddPost extends StatelessWidget {
  AddPost({
    this.mycontext
});

  final BuildContext mycontext;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            AuthButton(buttonText: 'Click Image ', onPressed:(){clickImage(mycontext);}),
            SizedBox(height: kScreenHeight*0.05,),
            AuthButton(buttonText: 'Pick from Gallery', onPressed: (){pickFromGallery(mycontext);})
          ]
        )
      ),
    );
  }
}

 void clickImage(context) async {
  await picker.getImage(source: ImageSource.camera).then((value){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MakePost(postFile: value)));
  });

}

 void pickFromGallery(context)async {
 await picker.getImage(source: ImageSource.gallery).then((value){
    Navigator.of(context).push( MaterialPageRoute(builder: (context)=> MakePost(postFile: value)));
  });
}