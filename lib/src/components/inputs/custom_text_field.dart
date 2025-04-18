import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool filled;
  final double? minHeight;
  final double? maxWidth;

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
