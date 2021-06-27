import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class NGOs extends StatelessWidget {
  var titleList = [
    "NGO 1",
    "NGO 2",
    "NGO 3",
    "NGO 4",
    "NGO 5",
    "NGO 6",
    "NGO 7",
    "NGO 8"
  ];
  var imageList = [
    "images/ngo1.jpeg",
    "images/ngo2.jpeg",
    "images/ngo3.jpeg",
    "images/ngo4.jpeg",
    "images/ngo5.png",
    "images/ngo6.png",
    "images/ngo7.jpeg",
    "images/ngo8.jpeg"
  ];

  var contactNo = [
    "7042347146",
    "9234567890",
    "8123456789",
    "9547382454",
    "7947384725",
    "9887658976",
    "9876789432",
    "9865465930"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            itemCount: titleList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Card(
                  //color: Colors.lightGreenAccent,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 80,
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(imageList[index]),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                titleList[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                contactNo[index],
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
