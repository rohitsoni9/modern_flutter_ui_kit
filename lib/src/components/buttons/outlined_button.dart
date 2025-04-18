import 'package:flutter/material.dart';
import 'package:modern_flutter_ui_kit/src/theme/color_scheme.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isDisabled;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.isDisabled = false,
    this.width,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: isDisabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color:
                isDisabled
                    ? AppColorScheme.disabled
                    : borderColor ?? AppColorScheme.primary,
          ),
        ),
        child: Text(
          text,
          style: (textStyle ?? const TextStyle()).copyWith(
            color:
                isDisabled
                    ? AppColorScheme.disabled
                    : textColor ?? AppColorScheme.primary,
          ),
        ),
      ),
    );
  }
}
