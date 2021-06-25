import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/src/models/models.dart';
import 'package:social_media_app/src/shared/constants.dart';

class MyPost extends StatelessWidget {
  MyPost(this.item);

  final PostItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 30),
      child: Container(
        height: kScreenHeight*0.5,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: CachedNetworkImage(
                imageUrl: item.imgUrl,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: kScreenHeight*0.06,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    color: Colors.green.withOpacity(0.6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          children :[
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CircleAvatar(child : CachedNetworkImage(
                                imageUrl: item.postedBy[PostItem.POST_IMG_URL],
                              ),),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.postedBy[PostItem.POST_USER_NAME],style: TextStyle(color: Colors.white,),),
                                Text(item.address,style: TextStyle(fontSize: 10,color: Colors.white,),),
                              ],
                            ),
                          ]
                      ),

                      Icon(Icons.more_vert,color: Colors.white,)
                    ],
                  )
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: kScreenHeight*0.10,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    color: Colors.green.withOpacity(0.6),
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon( Icons.thumb_up_alt_outlined,color: Colors.white,),
                                SizedBox(width: 5,),
                                Text(item.upvotes.toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),)
                              ],
                            ),
                            Icon(Icons.mode_comment_outlined,color: Colors.white,),
                            Icon(Icons.share,color: Colors.white,)

                          ]
                      ),
                      Text(item.caption,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}