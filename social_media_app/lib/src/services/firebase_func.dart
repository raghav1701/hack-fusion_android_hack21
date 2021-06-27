import 'dart:async';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:social_media_app/social_media.dart';

class FirebaseFunctionService {
  static final _functions = FirebaseFunctions.instance;

  Future<Result> approveUpgradeRequest(String uid) async {
    try {
      await _functions
        .httpsCallable(
          'upgrade',
          options: HttpsCallableOptions(
            timeout: Duration(seconds: 40),
          ),
        ).call({
          'id': uid,
        });
      return Result(code: Code.SUCCESS);
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

  Future<Result> upvotePost(String postId) async {
    try {
      await _functions
        .httpsCallable(
          'upvote',
          options: HttpsCallableOptions(
            timeout: Duration(seconds: 20),
          ),
        ).call({
          'id': postId,
        });
      return Result(code: Code.SUCCESS);
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

  Future<Result> sendMessage({
    String userName,
    int userLevel,
    String userImg,
    String receiverId,
    String receiverName,
    int receiverLevel,
    String receiverImg,
    String text,
  }) async {
    try {
      await _functions
        .httpsCallable(
          'addMessage',
          options: HttpsCallableOptions(
            timeout: Duration(seconds: 20),
          ),
        ).call({
          'username': userName,
          'userLevel': userLevel,
          'userImg': userImg,
          'receiverId': receiverId,
          'receiverName': receiverName,
          'receiverLevel': receiverLevel,
          'receiverImg': receiverImg,
          'message': text,
        });
      return Result(code: Code.SUCCESS);
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
