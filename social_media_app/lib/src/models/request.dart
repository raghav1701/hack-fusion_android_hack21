import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class RequestItem {
  static const UID = 'uid';
  static const NAME = 'name';
  static const EMAIL = 'email';
  static const PHONE = 'phone';
  static const ADDRESS = 'address';
  static const DOCLINK = 'docLink';
  static const LEVEL = 'level';
  static const TIMESTAMP = 'timestamp';

  final String uid;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String docLink;
  final int level;
  final Timestamp timestamp;

  RequestItem({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.address,
    @required this.docLink,
    @required this.level,
    @required this.timestamp,
  });

  Map<String, Object> toMap() {
    return {
      UID: uid,
      NAME: name,
      EMAIL: email,
      PHONE: phone,
      ADDRESS: address,
      DOCLINK: docLink,
      LEVEL: level,
      TIMESTAMP: timestamp,
    };
  }

  static RequestItem fromMap(Map<String, Object> data) {
    return RequestItem(
      uid: data[UID],
      name: data[NAME],
      email: data[EMAIL],
      phone: data[PHONE],
      address: data[ADDRESS],
      docLink: data[DOCLINK],
      level: data[LEVEL],
      timestamp: data[TIMESTAMP],
    );
  }
}
