import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class NGOs extends StatelessWidget {
  var titleList = ["NGO 1", "NGO 2", "NGO 3", "NGO 4", "NGO 5"];
  var imageList = [
    Assets.loginPageImage,
    Assets.signupPageImage,
    Assets.welcomePageImage,
    Assets.loginPageImage,
    Assets.signupPageImage,
  ];

  var contactNo = [
    "7042347146",
    "1234567890",
    "0123456789",
    "654738245",
    "394738472",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NGO Connect",
          style: TextStyle(color: Colors.green),
        ),
        elevation: 3,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: titleList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
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
                          SizedBox(height: 4.0),
                          Text(
                            contactNo[index],
                            style: TextStyle(fontSize: 17, color: Colors.grey[500]),
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
    );
  }
}
