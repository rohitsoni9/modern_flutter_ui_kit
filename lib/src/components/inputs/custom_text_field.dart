import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text field widget with support for various input types and styles.
///
/// This widget provides a modern text input component with support for labels,
/// hints, validation, icons, and various input types. It automatically adapts
/// to different screen sizes and themes.
class CustomTextField extends StatelessWidget {
  /// Optional label text displayed above the text field.
  final String? label;

  /// Optional hint text displayed when the text field is empty.
  final String? hint;

  /// Optional helper text displayed below the text field.
  final String? helperText;

  /// Optional error text displayed below the text field when validation fails.
  final String? errorText;

  /// Optional controller for the text field.
  final TextEditingController? controller;

  /// Optional focus node for the text field.
  final FocusNode? focusNode;

  /// Optional keyboard type for the text field.
  final TextInputType? keyboardType;

  /// Optional text input action for the text field.
  final TextInputAction? textInputAction;

  /// Whether the text field should obscure the input (for passwords).
  final bool obscureText;

  /// Whether the text field is enabled for input.
  final bool enabled;

  /// Optional maximum number of lines for the text field.
  final int? maxLines;

  /// Optional minimum number of lines for the text field.
  final int? minLines;

  /// Optional maximum length of the input text.
  final int? maxLength;

  /// Optional icon displayed at the start of the text field.
  final Widget? prefixIcon;

  /// Optional icon displayed at the end of the text field.
  final Widget? suffixIcon;

  /// Optional input formatters for the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Optional callback when the text field content changes.
  final ValueChanged<String>? onChanged;

  /// Optional callback when editing is complete.
  final VoidCallback? onEditingComplete;

  /// Optional callback when the text field is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Optional validator function for the text field.
  final FormFieldValidator<String>? validator;

  /// The text capitalization style for the text field.
  final TextCapitalization textCapitalization;

  /// Whether the text field should automatically focus when displayed.
  final bool autofocus;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Optional padding around the text field content.
  final EdgeInsetsGeometry? contentPadding;

  /// Optional background color for the text field.
  final Color? fillColor;

  /// Whether the text field should have a filled background.
  final bool filled;

  /// Optional minimum height constraint for the text field.
  final double? minHeight;

  /// Optional maximum width constraint for the text field.
  final double? maxWidth;

  /// Creates a custom text field.
  ///
  /// All parameters are optional and can be used to customize the appearance
  /// and behavior of the text field.
  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.readOnly = false,
    this.contentPadding,
    this.fillColor,
    this.filled = false,
    this.minHeight,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? (isSmallScreen ? size.width * 0.9 : 500),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        textCapitalization: textCapitalization,
        autofocus: autofocus,
        readOnly: readOnly,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: enabled ? null : theme.disabledColor,
          fontSize: isSmallScreen ? 14 : 16,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding:
              contentPadding ??
              EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: isSmallScreen ? 12 : 16,
              ),
          filled: filled,
          fillColor:
              fillColor ??
              (enabled ? null : theme.disabledColor.withValues(alpha: 26)),
          constraints: BoxConstraints(
            minHeight: minHeight ?? (isSmallScreen ? 48 : 56),
          ),
          labelStyle: theme.textTheme.bodyLarge?.copyWith(
            fontSize: isSmallScreen ? 14 : 16,
          ),
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            fontSize: isSmallScreen ? 14 : 16,
            color: theme.hintColor,
          ),
          helperStyle: theme.textTheme.bodySmall?.copyWith(
            fontSize: isSmallScreen ? 12 : 14,
          ),
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            fontSize: isSmallScreen ? 12 : 14,
            color: colorScheme.error,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.error, width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 26)),
          ),
        ),
      ),
    );
  }
}
