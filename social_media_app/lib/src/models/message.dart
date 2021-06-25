import 'package:flutter/foundation.dart';

enum Code {
  SUCCESS,
  TIMEOUT_EXCEPTION,
  SOCKET_EXCEPTION,
  PLATFORM_EXCEPTION,
  FIREBASEAUTH_EXCEPTION,
  EXCEPTION,
}

class Result<T> {
  final Code code;
  final String message;
  final T data;

  Result({
    @required this.code,
    this.message,
    this.data,
  });
}
