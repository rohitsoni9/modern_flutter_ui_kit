import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:modern_flutter_ui_kit/src/components/buttons/button.dart';

/// A customizable button widget with support for different variants and loading state.
///
/// This widget provides a modern button component that can display text and an icon,
/// with support for different variants, loading state, and custom colors.
/// It automatically adapts to different screen sizes and themes.
class CustomButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// The visual style variant of the button.
  final ButtonVariant variant;

  /// Whether the button is in a loading state.
  final bool isLoading;

  /// Optional icon to display on the button.
  final IconData? icon;

  /// Optional fixed width for the button.
  final double? width;

  /// Optional fixed height for the button.
  final double? height;

  /// Optional custom color for the button.
  final Color? customColor;

  /// Whether the button should expand to fill the available width.
  final bool isFullWidth;

  /// Optional minimum width constraint for the button.
  final double? minWidth;

  /// Optional maximum width constraint for the button.
  final double? maxWidth;

  /// Creates a custom button.
  ///
  /// The [text] and [onPressed] parameters are required.
  /// All other parameters are optional and can be used to customize the
  /// appearance and behavior of the button.
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
      default:
        backgroundColor = customColor ?? colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
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
