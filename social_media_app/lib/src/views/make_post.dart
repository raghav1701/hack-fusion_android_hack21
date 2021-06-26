import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/social_media.dart';

bool loading = false;
String uid;
GeoPoint currentPosition;

class MakePost extends StatefulWidget {

  MakePost({
  @required  this.postFile
});

 final PickedFile postFile;

  @override
  _MakePostState createState() => _MakePostState();
}

class _MakePostState extends State<MakePost> {
  TextEditingController caption=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController district=TextEditingController();

  @override
  void initState() {
    uid=FirebaseAuth.instance.currentUser.uid;
    getCurrentLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Make Post'),
      ),
      body: loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: kScreenHeight
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Container(
                    height: kScreenHeight*0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(File(widget.postFile.path)))
                    ),
                  ),
                  SizedBox(height: kScreenHeight*0.05,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: caption,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Add your Caption here',
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20)
                        )
                      ),
                  ),
                  SizedBox(height: kScreenHeight*0.05,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                        controller: address,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Address',
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20)
                        )
                    ),
                  ),
                  SizedBox(height: kScreenHeight*0.05,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                        controller: district,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'District',
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20)
                        )
                    ),
                  ),
                  SizedBox(height: kScreenHeight*0.05,),
                  AuthButton(buttonText: 'Post', onPressed: (){handlepost();})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    caption.dispose();
    address.dispose();
    district.dispose();
    super.dispose();
  }

  void handlepost() async {
    if (caption.text.isEmpty
        ||address.text.isEmpty
        ||district.text.isEmpty) {
      return Get.snackbar("Please enter all details!", "",
          snackPosition: SnackPosition.BOTTOM);
    }

    uploadPhoto() {
      DateTime time = DateTime.now();
      String filename = 'files/postImages/${uid + time.toString()}';
      try {
        final ref = FirebaseStorage.instance.ref(filename);

        UploadTask task = ref.putFile(File(widget.postFile.path));

        return task;
      } catch (e) {
        print(e);
      }
    }

    UploadTask photopath = uploadPhoto();
    setState(() {
      loading = true;
    });
    final snapshot = await photopath.whenComplete(() {});
    final postImgUrl = await snapshot.ref.getDownloadURL();

    try {
      FirebaseFirestore.instance.collection("posts").add({
        "postedbyUID":uid,
        "imgUrl": postImgUrl,
        "caption": caption.text.trim(),
        "location": currentPosition,
        "address":address.text.trim(),
        "region":district.text.trim(),
        "upvotes": 0,
        "status": "Pending",
        "timeStamp": DateTime.now(),

      }).then((value) {
        setState(() {
          loading = false;
        });
        Get.snackbar(
          "Posted!",
          "",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
      });
    }
    catch(e){

    }



  }
  getCurrentLocation() async {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((position) {
          currentPosition=GeoPoint(position.latitude, position.longitude);
    });
  }

}
