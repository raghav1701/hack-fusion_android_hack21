import 'package:flutter/foundation.dart';

class RequestItem {
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const PHONE = 'phone';
  static const ADDRESS = 'address';
  static const DOCLINK = 'docLink';
  static const LEVEL = 'level';

  final String name;
  final String email;
  final String phone;
  final String address;
  final String docLink;
  final int level;

  RequestItem({
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.address,
    @required this.docLink,
    @required this.level,
  });

  Map<String, Object> toMap() {
    return {
      NAME: name,
      EMAIL: email,
      PHONE: phone,
      ADDRESS: address,
      DOCLINK: docLink,
      LEVEL: level,
    };
  }

  static RequestItem fromMap(Map<String, Object> data) {
    return RequestItem(
      name: data[NAME],
      email: data[EMAIL],
      phone: data[PHONE],
      address: data[ADDRESS],
      docLink: data[DOCLINK],
      level: data[LEVEL],
    );
  }
}
