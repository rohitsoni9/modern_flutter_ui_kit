import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final Color? selectedColor;
  final Color? selectedTileColor;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final bool dense;
  final bool animate;
  final double? minHeight;

  const CustomListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
    this.selectedColor,
    this.selectedTileColor,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.dense = false,
    this.animate = true,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    Widget tile = Material(
      color:
          selected
              ? (selectedTileColor ?? colorScheme.primaryContainer)
              : Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: BoxConstraints(
            minHeight: minHeight ?? (isSmallScreen ? 48 : 56),
          ),
          padding:
              contentPadding ??
              EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical:
                    dense ? (isSmallScreen ? 6 : 8) : (isSmallScreen ? 8 : 12),
              ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(
                  width:
                      horizontalTitleGap ??
                      (dense
                          ? (isSmallScreen ? 12 : 16)
                          : (isSmallScreen ? 16 : 24)),
                ),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null)
                      DefaultTextStyle(
                        style: theme.textTheme.titleMedium!.copyWith(
                          color:
                              selected
                                  ? (selectedColor ??
                                      colorScheme.onPrimaryContainer)
                                  : enabled
                                  ? null
                                  : theme.disabledColor,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                        child: title!,
                      ),
                    if (subtitle != null) ...[
                      SizedBox(height: isSmallScreen ? 2 : 4),
                      DefaultTextStyle(
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color:
                              selected
                                  ? (selectedColor ??
                                          colorScheme.onPrimaryContainer)
                                      .withValues(alpha: 70)
                                  : enabled
                                  ? theme.textTheme.bodyMedium!.color
                                  : theme.disabledColor,
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                SizedBox(
                  width:
                      minLeadingWidth ??
                      (dense
                          ? (isSmallScreen ? 24 : 32)
                          : (isSmallScreen ? 32 : 40)),
                ),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );

    if (animate) {
      tile = tile.animate().fadeIn().slideX(
        begin: 0.1,
        end: 0,
        curve: Curves.easeOutCubic,
      );
    }

    return tile;
  }
}
