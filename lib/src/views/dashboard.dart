import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class Destinations{
  final String title;
  final IconData icon;
  final Widget widget;

  Destinations({
    @required this.title,
    @required this.icon,
    @required this.widget,
  });
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final bottomItemsIcons = [
    Destinations(title: 'Home', icon: Icons.home, widget: Home()),
    Destinations(title: 'Trending', icon: Icons.search, widget: TrendingPosts()),
    Destinations(title: 'Add Post', icon: Icons.add, widget: AddPost()),
    Destinations(title: 'NGOs', icon: Icons.ac_unit, widget: NGOs()),
    Destinations(title: 'About Us', icon: Icons.info, widget: AboutUs()),
  ];

  int tabSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bottomItemsIcons[tabSelected].title),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: bottomItemsIcons[tabSelected].widget,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabSelected,
        items: bottomItemsIcons.map((e) {
          return BottomNavigationBarItem(
            icon: Icon(e.icon),
            label: e.title,
          );
        }).toList(),
        onTap: (index) {
          if (mounted) {
            setState(() => tabSelected = index);
          }
        },
      ),
    );
  }
}
