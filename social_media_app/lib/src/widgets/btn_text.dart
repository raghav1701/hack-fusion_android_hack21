import 'package:flutter/material.dart';

class InteractiveText extends InkWell {
  InteractiveText(
    String text, {
    @required Function onTap,
    Color textColor = const Color(0xFF10B73F),
    FontWeight fontWeight = FontWeight.bold,
  }) : super(
    splashColor: Colors.transparent,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    onTap: onTap,
  );
}
