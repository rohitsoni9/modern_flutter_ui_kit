import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum ButtonVariant { primary, secondary, outlined, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;
  final Color? customColor;
  final bool isFullWidth;
  final double? minWidth;
  final double? maxWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
    this.customColor,
    this.isFullWidth = false,
    this.minWidth,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide? borderSide;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = customColor ?? colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        break;
      case ButtonVariant.secondary:
        backgroundColor = customColor ?? colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        break;
      case ButtonVariant.outlined:
        backgroundColor = Colors.transparent;
        foregroundColor = customColor ?? colorScheme.primary;
        borderSide = BorderSide(color: foregroundColor);
        break;
      case ButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = customColor ?? colorScheme.primary;
        break;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth ?? (isSmallScreen ? 120 : 140),
        maxWidth: maxWidth ?? (isFullWidth ? double.infinity : 400),
      ),
      child: SizedBox(
        width: isFullWidth ? double.infinity : width,
        height: height ?? (isSmallScreen ? 40 : 48),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: variant == ButtonVariant.primary ? 2 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: borderSide ?? BorderSide.none,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 16,
              vertical: isSmallScreen ? 8 : 12,
            ),
          ),
          child:
              isLoading
                  ? SizedBox(
                    width: isSmallScreen ? 20 : 24,
                    height: isSmallScreen ? 20 : 24,
                    child: CircularProgressIndicator(
                      color: foregroundColor,
                      strokeWidth: 2,
                    ),
                  ).animate().fadeIn()
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: isSmallScreen ? 18 : 20),
                        SizedBox(width: isSmallScreen ? 6 : 8),
                      ],
                      Flexible(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: foregroundColor,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
