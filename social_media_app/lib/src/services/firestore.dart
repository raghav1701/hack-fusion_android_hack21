import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/social_media.dart';

enum UserRole {
  REGULAR,
  AUTHORITY,
  HIGHER,
  SUPERADMIN,
}

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const _USER_COLLECTION = 'users';
  static const _POSTS_COLLECTION = 'posts';
  static const _LEVEL2_USER_COLLECTION = 'authorities';
  static const _LEVEL3_USER_COLLECTION = 'higher_auths';

  FirestoreService._();

  static Future<Result> createRole(String uid) async {
    try {
      await _firestore.collection(_USER_COLLECTION).doc(uid).set({
        'level': 1,
      }, SetOptions(merge: false, mergeFields: ['level']));
    } catch(e) {
      print(e);
    }
  }

  static Future<Result> getRole(String uid) async {
    try {
      var doc = await _firestore.collection(_USER_COLLECTION).doc(uid).get();
      return Result(code: Code.SUCCESS, message: doc?.data()['level']?.toString());
    } catch (e) {
      return Result(code: Code.EXCEPTION, message: e.toString());
    }
  }
}
