import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/social_media.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  final String name;
  final String profilePic;
  final int authLevel;

  const ProfileScreen({
    Key key,
    this.uid,
    this.name,
    this.profilePic,
    this.authLevel,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String uid, name, profilePic;

  bool loading = true, isCurrentAuthUser = false;
  int authLevel;
  String address, phone, xp, rank, posts, error;
  List<QueryDocumentSnapshot<Map<String, Object>>> postsList = [];

  Future<void> getUserInfo() async {
    setState(() {
      loading = true;
      error = null;
    });
    var result = await FirestoreService().getUserInfo(authLevel, uid);

    if (!mounted) return;

    if (result.code == Code.SUCCESS) {
      setState(() {
        posts = result.data['posts'].toString();
        xp = result.data['xp'].toString();
        rank = result.data['rank'].toString();
      });
      getUserPosts();
    } else {
      setState(() {
        error = result.message;
      });
    }
  }

  Future<void> getUserPosts() async {
    setState(() {
      loading = true;
      error = null;
    });

    var result = await FirestoreService().getUserPosts(uid);

    if (!mounted) return;

    if (result.code == Code.SUCCESS) {
      setState(() {
        postsList = result.data;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
        error = result.message;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    uid = widget.uid ?? FirebaseAuthService.user.uid;
    isCurrentAuthUser = uid == FirebaseAuthService.user.uid;
    name = widget.name ?? FirebaseAuthService.user.displayName;
    profilePic = widget.profilePic ?? FirebaseAuthService.user.photoURL;
    authLevel = widget.authLevel ?? sharedPreferences.authLevel;
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Visibility(
            visible: posts != null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildImageHeader(context),
                    Expanded(child: buildActivityDetails(context)),
                  ],
                ),
                buildPersonalDetails(context),
                buildOptions(context),
                Visibility(
                  visible: !loading && error == null,
                  child: buildPosts(context),
                  replacement: buildFetching(context, topMargin: 72.0),
                ),
              ],
            ),
            replacement: buildFetching(context),
          ),
        ),
      ),
    );
  }

  Widget buildImageHeader(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          foregroundImage:
              NetworkImage(profilePic ?? ''),
          child: Icon(Icons.person),
          backgroundColor: Colors.white,
          minRadius: 36.0,
        ),
        Positioned(
          right: -8.0,
          bottom: -8.0,
          child: Transform.scale(
            scale: 0.6,
            child: TapDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.edit),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildActivityDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        authLevel == 1
          ? buildActivityAsset(context, 'Posts', '$posts')
          : buildActivityAsset(context, 'Level', '$authLevel'),
        buildActivityAsset(context, 'Rank', '$rank'),
        buildActivityAsset(context, 'XP', '$xp'),
      ],
    );
  }

  Widget buildActivityAsset(BuildContext context, String title, String content) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(content),
        ],
      ),
    );
  }

  Widget buildPersonalDetails(BuildContext context) {
    var userLevel = sharedPreferences.authLevel;
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 16.0, 8.0, 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name + ' (Lv. $userLevel)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Visibility(visible: address != null, child: Text('$address')),
          Visibility(visible: phone != null, child: Text('$phone')),
        ],
      ),
    );
  }

  Widget buildOptions(BuildContext context) {
    var userLevel = sharedPreferences.authLevel;
    var showUpgradeButton = userLevel < 3;
    return Visibility(
      visible: isCurrentAuthUser,
      child: Row(
        children: [
          showUpgradeButton
              ? Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.upgrade);
                    },
                    icon: Icon(Icons.upgrade_sharp),
                    label: Text('Upgrade'),
                  ),
                )
              : Container(),
          showUpgradeButton ? SizedBox(width: 8.0) : Container(),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.editProfile);
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
            ),
          ),
        ],
      ),
      replacement: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                //TODO: Chat with this user
              },
              icon: Icon(Icons.message),
              label: Text('Send Message'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPosts(BuildContext context) {
    return Visibility(
      visible: authLevel < 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              (isCurrentAuthUser ? 'Your' : '') + ' Posts',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Visibility(
            visible: postsList.length == 0,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'You haven\'t not posted anything in a while',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  OutlinedButton(
                    child: Text('Add Post'),
                    onPressed: () {
                      //TODO: Navigate to Add Post
                    },
                  )
                ],
              ),
            ),
            replacement: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: postsList.map((e) {
                var data = e.data();
                return TapDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    margin: const EdgeInsets.all(1.0),
                    child: Image.network(
                      data[PostItem.IMG_URL],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFetching(BuildContext context, {double topMargin = 0.0}) {
    return Center(
      child: Visibility(
        visible: loading,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: topMargin),
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text('Fetching your data...'),
          ],
        ),
        replacement: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: topMargin),
                Text('Failed to fetch data. Please try again.'),
                SizedBox(height: 16.0),
                OutlinedButton(
                  onPressed: () {
                    if (posts == null) {
                      getUserInfo();
                    } else {
                      getUserPosts();
                    }
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
