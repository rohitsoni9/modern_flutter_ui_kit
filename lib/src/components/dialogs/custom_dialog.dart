import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum DialogType { info, success, warning, error, custom }

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget>? actions;
  final DialogType type;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool showCloseButton;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
