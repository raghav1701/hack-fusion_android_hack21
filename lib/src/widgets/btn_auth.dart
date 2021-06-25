import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final bool useThemeColor;
  final bool fillWithDark;
  final Color fillColor;
  final Color textColor;
  final double horizontalMargin;
  final double verticalMargin;

  AuthButton({
    @required this.buttonText,
    @required this.onPressed,
    this.useThemeColor = true,
    this.fillWithDark = true,
    this.fillColor,
    this.textColor,
    this.horizontalMargin = 42.0,
    this.verticalMargin = 4.0,
  })  : assert(useThemeColor != null),
        assert(fillWithDark != null),
        assert(useThemeColor || (fillColor != null && textColor != null)),
        super();

  @override
  Widget build(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  color: useThemeColor
                      ? fillWithDark
                          ? Colors.white
                          : Colors.black
                      : textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              fillColor: useThemeColor
                  ? fillWithDark
                      ? Color(0xFF10B73F)
                      : Color(0xFFF0EFEF)
                  : fillColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))
              ),
              elevation: 1.0,
              hoverElevation: 2.0,
              highlightElevation: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
