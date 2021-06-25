import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool useThemeColor;
  final Color fillColor;
  final Color textColor;
  final double horizontalMargin;
  final double verticalMargin;

  const AuthButton({
    @required this.title,
    @required this.onPressed,
    this.useThemeColor = true,
    this.fillColor,
    this.textColor,
    this.horizontalMargin = 42.0,
    this.verticalMargin = 24.0,
  })  : assert(useThemeColor != null),
        assert(useThemeColor || (fillColor != null && textColor != null)),
        super();

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalMargin, 8.0, horizontalMargin, verticalMargin),
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: TextStyle(
                  color: useThemeColor ? Colors.white : textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              fillColor: useThemeColor ? Color(0xFF10B73F) : fillColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
