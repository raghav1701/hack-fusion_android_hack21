import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media_app/social_media.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:social_media_app/src/views/fragments/stats.dart';

class DashboardScreen extends StatefulWidget {
  final regularUsers = [
    Destination(title: 'Trending', icon: FontAwesomeIcons.search, widget: TrendingPosts()),
    Destination(title: 'NGOs Connect', icon: FontAwesomeIcons.hands, widget: NGOs()),
    Destination(title: 'Statistics', icon: FontAwesomeIcons.chartLine, widget: Statistics()),
  ];

  final authorisedUsers = [
    Destination(title: 'Trending', icon: FontAwesomeIcons.search, widget: TrendingPosts()),
    Destination(title: 'Statistics', icon: FontAwesomeIcons.chartLine, widget: Statistics()),
  ];

  final higherAuthorityUser = [
    Destination(title: 'Trending', icon: FontAwesomeIcons.search, widget: TrendingPosts()),
    Destination(title: 'NGOs Connect', icon: FontAwesomeIcons.search, widget: NGOs()),
    Destination(title: 'Statistics', icon: FontAwesomeIcons.chartLine, widget: Statistics()),
  ];

  final superAdminUser = [
    Destination(title: 'Requests (Lv 2)', icon: FontAwesomeIcons.accessibleIcon, widget: RequestApprovalScreen(level: 2)),
    Destination(title: 'Requests (Lv 3)', icon: FontAwesomeIcons.search, widget: RequestApprovalScreen(level: 3)),
    Destination(title: 'NGOs Connect', icon: FontAwesomeIcons.search, widget: NGOs()),
  ];

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Destination> bottomBarItems;
  int tabSelected = 0;

  PersistentTabController _controller;

  void handleAppActions(int index) {
    if (index == 1) {
      Navigator.of(context).pushNamed(Routes.profile);
    }
  }

  @override
  void initState() {
    super.initState();
    var level = sharedPreferences.authLevel;
    switch (level) {
      case 1: bottomBarItems = widget.regularUsers;
        bottomBarItems.insert(1, Destination(
          title: 'Post',
          icon: FontAwesomeIcons.plusSquare,
          widget: AddPost(context),
        ));
        break;
      case 2: bottomBarItems = widget.authorisedUsers;
        break;
      case 3: bottomBarItems = widget.higherAuthorityUser;
        break;
      case 4: bottomBarItems = widget.superAdminUser;
        break;
      default: bottomBarItems = widget.regularUsers;
    }
    if (level < 4) {
      bottomBarItems.insert(0, Destination(
        title: 'Local Posts',
        icon: FontAwesomeIcons.home,
        widget: Home(context),
      ));
    }
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bottomBarItems[_controller.index].title),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.solidCommentDots, size: 32.0),
            splashRadius: 24.0,
            onPressed: () {
              handleAppActions(0);
            },
          ),
          IconButton(
            icon: CircleAvatar(
              foregroundImage: NetworkImage(FirebaseAuth.instance.currentUser.photoURL ?? ''),
              child: Icon(Icons.person),
              backgroundColor: Colors.white,
            ),
            splashRadius: 24.0,
            onPressed: () {
              handleAppActions(1);
            },
          ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        backgroundColor: Theme.of(context).primaryColor, // Default is Colors.white.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Theme.of(context).primaryColor,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
      ),
    );
  }

  List<Widget> _buildScreens() {
    return bottomBarItems.map((e) => e.widget).toList();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return bottomBarItems.map((e) {
      return PersistentBottomNavBarItem(
        icon: Icon(e.icon, size: 24.0),
        title: e.title,
        textStyle: TextStyle(
          fontSize: 11.0,
        ),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
        inactiveColorSecondary: Colors.white,
      );
    }).toList();
  }
}
