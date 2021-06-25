import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum PostStatus {
  /// Pending
  Pending,
  /// Resolved By NGOs and Under Verification by Higher Auths
  UV,
  /// Verified by Higher Auths, Resolved and Closed
  CL,
  /// Fake
  FK,
}

class PostItem {
  static const IMG_URL = 'imgURL';
  static const CAPTION = 'caption';
  static const ADDRESS = 'address';
  static const REGION = 'region';
  static const LOCATION = 'location';
  static const UPVOTES = 'upvotes';
  static const STATUS = 'status';
  static const TIMESTAMP = 'timestamp';

  static const POSTED_BY = 'uid';
  static const POSTED_BY_USER = 'postedBy';
  static const POST_USER_NAME = 'name';
  static const POST_IMG_URL = 'photoURL';

  final String imgUrl;
  final String caption;
  final String address;
  final String region;
  final GeoPoint location;
  final int upvotes;
  final PostStatus status;
  final String uid;

  /// ```dart
  /// Map<String, Object> postedBy = {
  ///   POST_USER_NAME: username,
  ///   POST_IMG_URL: userProfilePic,
  /// }
  /// ```
  final Map<String, Object> postedBy;
  final Timestamp timestamp;

  PostItem({
    @required this.uid,
    @required this.imgUrl,
    @required this.caption,
    @required this.address,
    @required this.region,
    @required this.location,
    @required this.upvotes,
    @required this.status,
    @required this.postedBy,
    @required this.timestamp,
  });

  Map<String, Object> toMap() {
    return {
      IMG_URL: this.imgUrl,
      CAPTION: this.caption,
      ADDRESS: this.address,
      REGION: this.region,
      LOCATION: this.location,
      UPVOTES: this.upvotes,
      STATUS: this.status,
      POSTED_BY: this.uid,
      POSTED_BY_USER: this.postedBy,
      TIMESTAMP: this.timestamp,
    };
  }

  static PostItem fromMap(Map<String, Object> data) {
    return PostItem(
      imgUrl: data[IMG_URL],
      caption: data[CAPTION],
      address: data[ADDRESS],
      region: data[REGION],
      location: data[LOCATION],
      upvotes: data[UPVOTES],
      status: data[STATUS],
      uid: data[POSTED_BY],
      postedBy: data[POSTED_BY_USER],
      timestamp: data[TIMESTAMP],
    );
  }
}
