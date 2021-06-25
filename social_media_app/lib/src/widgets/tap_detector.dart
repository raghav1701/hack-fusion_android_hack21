import 'package:flutter/material.dart';

class TapDetector extends InkWell {
  TapDetector({
    Widget child,
    String text,
    Function onTap,
    Function onLongPress,
    Color textColor = const Color(0xFF10B73F),
    FontWeight fontWeight = FontWeight.bold,
  }) : super(
    splashColor: Colors.transparent,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    child: child ?? Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    onTap: onTap,
    onLongPress: onLongPress,
  );
}
