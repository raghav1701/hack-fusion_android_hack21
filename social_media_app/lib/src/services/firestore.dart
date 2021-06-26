import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/social_media.dart';

class FirestoreService {
  static const _COLLECTION = [
    'users',        // LEVEL 1
    'ngos',         // LEVEL 2
    'admin',        // LEVEL 3
    'super_admin',  // LEVEL 4
  ];
  static const POSTS = 'posts';
  static const REQUEST = 'requests';

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _resolveUserCollection(int level) => _COLLECTION[level-1];

  Future<Result<Map<String, Object>>> getUserInfo(int level, String uid) async {
    var collectionPath = _resolveUserCollection(level);
    try {
      var doc = await _firestore.collection(collectionPath).doc(uid).get(
        GetOptions(source: Source.serverAndCache),
      ).timeout(Duration(seconds: 20));
      return Result(code: Code.SUCCESS, data: doc.data());
    } on FirebaseException catch (e) {
      return Result(code: Code.FIREBASEAUTH_EXCEPTION, message: e.message);
    } on SocketException catch (e) {
      return Result(code: Code.SOCKET_EXCEPTION, message: e.message);
    } on PlatformException catch (e) {
      return Result(code: Code.PLATFORM_EXCEPTION, message: e.message);
    } on TimeoutException catch (e) {
      return Result(code: Code.TIMEOUT_EXCEPTION, message: e.message);
    } catch (e) {
      return Result(code: Code.EXCEPTION, message: e.toString());
    }
  }

  Future<Result<List<QueryDocumentSnapshot<Map<String, dynamic>>>>> getUserPosts(String uid) async {
    try {
      var doc = await _firestore
          .collection(POSTS)
          .where(PostItem.POSTED_BY, isEqualTo: uid)
          .orderBy(PostItem.TIMESTAMP)
          .get(GetOptions(source: Source.serverAndCache))
          .timeout(Duration(seconds: 20));
      return Result(code: Code.SUCCESS, data: doc.docs);
    } on FirebaseException catch (e) {
      return Result(code: Code.FIREBASEAUTH_EXCEPTION, message: e.message);
    } on SocketException catch (e) {
      return Result(code: Code.SOCKET_EXCEPTION, message: e.message);
    } on PlatformException catch (e) {
      return Result(code: Code.PLATFORM_EXCEPTION, message: e.message);
    } on TimeoutException catch (e) {
      return Result(code: Code.TIMEOUT_EXCEPTION, message: e.message);
    } catch (e) {
      return Result(code: Code.EXCEPTION, message: e.toString());
    }
  }

  Future<Result> postUpgradeRequest(RequestItem info) async {
    try {
      await _firestore
          .collection(REQUEST)
          .doc(info.uid)
          .set(info.toMap())
          .timeout(Duration(seconds: 20));
      return Result(code: Code.SUCCESS, message: 'Request Added Successfully');
    } on FirebaseException catch (e) {
      return Result(code: Code.FIREBASEAUTH_EXCEPTION, message: e.message);
    } on SocketException catch (e) {
      return Result(code: Code.SOCKET_EXCEPTION, message: e.message);
    } on PlatformException catch (e) {
      return Result(code: Code.PLATFORM_EXCEPTION, message: e.message);
    } on TimeoutException catch (e) {
      return Result(code: Code.TIMEOUT_EXCEPTION, message: e.message);
    } catch (e) {
      return Result(code: Code.EXCEPTION, message: e.toString());
    }
  }

  Future<Result<List<QueryDocumentSnapshot<Map<String, dynamic>>>>> getPendingRequests(int level) async {
    try {
      var doc = await _firestore
          .collection(REQUEST)
          .where(RequestItem.LEVEL, isEqualTo: level)
          .orderBy(RequestItem.TIMESTAMP)
          .get()
          .timeout(Duration(seconds: 40));
      return Result(code: Code.SUCCESS, data: doc.docs);
    } on FirebaseException catch (e) {
      return Result(code: Code.FIREBASEAUTH_EXCEPTION, message: e.message);
    } on SocketException catch (e) {
      return Result(code: Code.SOCKET_EXCEPTION, message: e.message);
    } on PlatformException catch (e) {
      return Result(code: Code.PLATFORM_EXCEPTION, message: e.message);
    } on TimeoutException catch (e) {
      return Result(code: Code.TIMEOUT_EXCEPTION, message: e.message);
    } catch (e) {
      return Result(code: Code.EXCEPTION, message: e.toString());
    }
  }
}
