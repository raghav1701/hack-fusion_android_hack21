import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kScreenWidth*0.8,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 30),
            child: Container(
              child: Stack(
                children: [
                  Image.asset(Assets.loginPageImage,fit: BoxFit.fill,),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                            color: Colors.green.withOpacity(0.6),
                          ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children :[
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CircleAvatar(backgroundColor: Colors.amber,),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Raghav Aggarwal'),
                                    Text('Locations',style: TextStyle(fontSize: 10),),
                                  ],
                                ),
                              ]
                            ),

                            Icon(Icons.more_vert)
                          ],
                        )
                      ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                          color: Colors.green.withOpacity(0.6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon( Icons.thumb_up_alt_outlined),
                            Icon(Icons.mode_comment_outlined),
                            Icon(Icons.share)
                          ]
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
