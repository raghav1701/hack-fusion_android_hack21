import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_app/social_media.dart';

typedef _OnFinishCallback = void Function(UserCredential user);
typedef _OnErrorCallback = void Function(Code code, String message);

enum _Operation {
  SIGNUP,
  LOGIN,
}

class FirebaseAuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String email;
  final String password;
  final String name;

  /// This function triggers when processing is just started;
  final Function onStart;

  /// This function triggers when processing is finished;
  final _OnFinishCallback onFinish;

  /// This function triggers whenever an exception occurs;
  final _OnErrorCallback onError;

  FirebaseAuthService({
    @required this.email,
    @required this.password,
    this.name,
    @required this.onStart,
    @required this.onFinish,
    @required this.onError,
  })  : assert(email != null),
        assert(password != null),
        assert(onStart != null),
        assert(onFinish != null),
        assert(onError != null);

  Future<void> createUser() async {
    await _authenticateUser(_Operation.SIGNUP);
  }

  Future<void> loginUser() async {
    await _authenticateUser(_Operation.LOGIN);
  }

  Future<void> _authenticateUser(_Operation operation) async {
    onStart();
    try {
      UserCredential user;
      if (operation == _Operation.LOGIN) {
        user = await _firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .timeout(Duration(seconds: 20));
      } else {
        user = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password)
            .timeout(Duration(seconds: 20));
        await setDisplayName(name);
      }
      if (user?.user != null) {
        onFinish(user);
      } else {
        throw 'Unknown Error';
      }
    } on FirebaseAuthException catch (e) {
      onError(Code.FIREBASEAUTH_EXCEPTION, e.message);
    } on SocketException catch (e) {
      onError(Code.SOCKET_EXCEPTION, e.message);
    } on TimeoutException catch (e) {
      onError(Code.TIMEOUT_EXCEPTION, e.message);
    } catch (e) {
      onError(Code.EXCEPTION, e.message);
    }
  }

  static Future<Result> setDisplayName(String name) async {
    try {
      await _firebaseAuth.currentUser
          .updateDisplayName(name)
          .timeout(Duration(seconds: 10));
      return Result(code: Code.SUCCESS);
    } on FirebaseAuthException catch (e) {
      return Result(code: Code.FIREBASEAUTH_EXCEPTION, message: e.message);
    } on SocketException catch (e) {
      return Result(code: Code.SOCKET_EXCEPTION, message: e.message);
    } on TimeoutException catch (e) {
      return Result(code: Code.TIMEOUT_EXCEPTION, message: e.message);
    } catch (e) {
      return Result(code: Code.EXCEPTION, message: e.message);
    }
  }

  static String get username => _firebaseAuth.currentUser.displayName;
}
