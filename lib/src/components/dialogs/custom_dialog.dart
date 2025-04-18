import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// The type of dialog to display.
///
/// This enum classifies dialogs into different categories based on their purpose
/// and visual style. Each type has a default icon and color scheme.
enum DialogType {
  /// An informational dialog that provides general information to the user.
  info,

  /// A success dialog that indicates a successful operation or completion.
  success,

  /// A warning dialog that alerts the user about potential issues or risks.
  warning,

  /// An error dialog that indicates something went wrong or failed.
  error,

  /// A custom dialog that allows for custom styling and behavior.
  custom
}

/// A customizable dialog widget that supports different types and animations.
///
/// This widget provides a modern, animated dialog with support for different
/// types (info, success, warning, error, custom), custom icons, colors, and
/// animations. It automatically adapts to different screen sizes and themes.
class CustomDialog extends StatelessWidget {
  /// The title text displayed at the top of the dialog.
  final String title;

  /// The main content text displayed in the dialog.
  final String content;

  /// Optional action buttons displayed at the bottom of the dialog.
  final List<Widget>? actions;

  /// The type of dialog to display, which affects the default icon and colors.
  final DialogType type;

  /// Optional custom icon to override the default icon for the dialog type.
  final IconData? icon;

  /// Optional custom color for the dialog icon.
  final Color? iconColor;

  /// Optional custom background color for the dialog.
  final Color? backgroundColor;

  /// Optional elevation of the dialog.
  final double? elevation;

  /// Optional border radius for the dialog corners.
  final BorderRadius? borderRadius;

  /// Optional padding around the dialog content.
  final EdgeInsetsGeometry? contentPadding;

  /// Optional custom text style for the dialog title.
  final TextStyle? titleStyle;

  /// Optional custom text style for the dialog content.
  final TextStyle? contentStyle;

  /// Optional duration for the dialog animation.
  final Duration? animationDuration;

  /// Optional animation curve for the dialog animation.
  final Curve? animationCurve;

  /// Whether to show a close button in the dialog.
  final bool showCloseButton;

  /// Creates a custom dialog.
  ///
  /// The [title] and [content] parameters are required. All other parameters
  /// are optional and can be used to customize the appearance and behavior
  /// of the dialog.
  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.type = DialogType.info,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.contentPadding,
    this.titleStyle,
    this.contentStyle,
    this.animationDuration,
    this.animationCurve,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    IconData dialogIcon;
    Color dialogIconColor;
    Color dialogBackgroundColor;

    switch (type) {
      case DialogType.info:
        dialogIcon = icon ?? Icons.info_outline;
        dialogIconColor = iconColor ?? colorScheme.primary;
        dialogBackgroundColor = backgroundColor ?? colorScheme.surface;
        break;
      case DialogType.success:
        dialogIcon = icon ?? Icons.check_circle_outline;
        dialogIconColor = iconColor ?? Colors.green;
        dialogBackgroundColor = backgroundColor ?? colorScheme.surface;
        break;
      case DialogType.warning:
        dialogIcon = icon ?? Icons.warning_amber_outlined;
        dialogIconColor = iconColor ?? Colors.orange;
        dialogBackgroundColor = backgroundColor ?? colorScheme.surface;
        break;
      case DialogType.error:
        dialogIcon = icon ?? Icons.error_outline;
        dialogIconColor = iconColor ?? colorScheme.error;
        dialogBackgroundColor = backgroundColor ?? colorScheme.surface;
        break;
      case DialogType.custom:
        dialogIcon = icon ?? Icons.info_outline;
        dialogIconColor = iconColor ?? colorScheme.primary;
        dialogBackgroundColor = backgroundColor ?? colorScheme.surface;
        break;
    }

    return Dialog(
      backgroundColor: dialogBackgroundColor,
      elevation: elevation ?? 8,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isSmallScreen ? size.width * 0.9 : 500,
          maxHeight: size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: contentPadding ?? EdgeInsets.all(isSmallScreen ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                                dialogIcon,
                                color: dialogIconColor,
                                size: isSmallScreen ? 20 : 24,
                              )
                              .animate(
                                delay:
                                    animationDuration ??
                                    const Duration(milliseconds: 200),
                              )
                              .scale(
                                begin: const Offset(0.8, 0.8),
                                end: const Offset(1, 1),
                                curve: animationCurve ?? Curves.easeOutBack,
                              ),
                          SizedBox(width: isSmallScreen ? 8 : 12),
                          Flexible(
                            child: Text(
                                  title,
                                  style: (titleStyle ??
                                          theme.textTheme.titleLarge?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ))
                                      ?.copyWith(
                                        fontSize: isSmallScreen ? 18 : 24,
                                      ),
                                )
                                .animate(
                                  delay:
                                      animationDuration ??
                                      const Duration(milliseconds: 200),
                                )
                                .fadeIn()
                                .slideX(
                                  begin: 0.2,
                                  end: 0,
                                  curve: animationCurve ?? Curves.easeOutCubic,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (showCloseButton)
                      IconButton(
                            icon: Icon(
                              Icons.close,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                          .animate(
                            delay:
                                animationDuration ??
                                const Duration(milliseconds: 200),
                          )
                          .fadeIn(),
                  ],
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),
                Text(
                      content,
                      style: (contentStyle ?? theme.textTheme.bodyLarge)
                          ?.copyWith(fontSize: isSmallScreen ? 14 : 16),
                    )
                    .animate(
                      delay:
                          animationDuration ??
                          const Duration(milliseconds: 200),
                    )
                    .fadeIn()
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      curve: animationCurve ?? Curves.easeOutCubic,
                    ),
                if (actions != null) ...[
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 8,
                        runSpacing: 8,
                        children: actions!.map((action) => action).toList(),
                      )
                      .animate(
                        delay:
                            animationDuration ??
                            const Duration(milliseconds: 200),
                      )
                      .fadeIn()
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        curve: animationCurve ?? Curves.easeOutCubic,
                      ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
