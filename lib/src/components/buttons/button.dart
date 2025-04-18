import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// A modern, customizable button component.
///
/// This button supports different variants, sizes, and states.
class ModernButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// The callback function when the button is pressed
  final VoidCallback? onPressed;

  /// The variant of the button (filled, outlined, text)
  final ButtonVariant variant;

  /// The size of the button (small, medium, large)
  final ButtonSize size;

  /// Whether the button is in a loading state
  final bool isLoading;

  /// Whether the button is disabled
  final bool isDisabled;

  /// The icon to display before the text
  final IconData? leadingIcon;

  /// The icon to display after the text
  final IconData? trailingIcon;

  /// Creates a modern button
  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ModernTheme.of(context);

    return ElevatedButton(
      onPressed: isDisabled || isLoading ? null : onPressed,
      style: _getButtonStyle(theme),
      child: _buildButtonContent(theme),
    );
  }

  ButtonStyle _getButtonStyle(ModernThemeData theme) {
    // Implementation of button styling based on variant and size
    return ElevatedButton.styleFrom(
      // Add your button styling here
    );
  }

  Widget _buildButtonContent(ModernThemeData theme) {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) Icon(leadingIcon),
        const SizedBox(width: 8),
        Text(text),
        if (trailingIcon != null) ...[
          const SizedBox(width: 8),
          Icon(trailingIcon),
        ],
      ],
    );
  }
}

/// The variant of the button
enum ButtonVariant {
  /// A filled button with solid background
  filled,

  /// An outlined button with border
  outlined,

  /// A text button with no background or border
  text,
}

/// The size of the button
enum ButtonSize {
  /// Small button size
  small,

  /// Medium button size
  medium,

  /// Large button size
  large,
}
