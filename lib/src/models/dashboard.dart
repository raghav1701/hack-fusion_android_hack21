import 'package:flutter/material.dart';

class Destination{
  final String title;
  final IconData icon;
  final Widget widget;

  Destination({
    @required this.title,
    @required this.icon,
    @required this.widget,
  });
}
