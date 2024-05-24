
import 'package:flutter/material.dart';
import 'package:news_watcher/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        required this.backgroundColor,
        required this.textColor,
        this.borderRadius,

        required this.text, this.fontSize, this.buttonWidth, this.buttonHeight, required this.onPressed,  this.textStyle});

  final Color backgroundColor;
  final Color textColor;
  final BorderRadius? borderRadius;
  final String text;
  final double? fontSize;

  final double? buttonWidth;
  final double? buttonHeight;

  final VoidCallback onPressed; // Callback function for onPressed event

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(12),
              ),
            ),
            child: Text(
              text,
              style: textStyle ?? AppStyles.textStyleSemiBold14
                  .copyWith(color: textColor),
            )),
      ),
    );
  }
}
