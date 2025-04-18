import 'package:flutter/material.dart';
import 'package:modern_flutter_ui_kit/src/theme/color_scheme.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool isDisabled;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 24.0,
    this.color,
    this.backgroundColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(8.0),
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColorScheme.primary,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Icon(
            icon,
            size: size,
            color:
                isDisabled
                    ? AppColorScheme.disabled
                    : color ?? AppColorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
