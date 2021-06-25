import 'package:flutter/foundation.dart';

enum Code {
  SUCCESS,
  TIMEOUT_EXCEPTION,
  SOCKET_EXCEPTION,
  PLATFORM_EXCEPTION,
  FIREBASEAUTH_EXCEPTION,
  EXCEPTION,
}

class Result {
  final Code code;
  final String message;

  Result({
    @required this.code,
    this.message,
  });
}
