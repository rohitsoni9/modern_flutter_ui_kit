import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A customizable list tile widget with support for leading and trailing widgets.
///
/// This widget provides a modern list tile component that can display a leading
/// widget, title, subtitle, and trailing widget. It supports selection state,
/// tap handling, and animations. It automatically adapts to different screen
/// sizes and themes.
class CustomListTile extends StatelessWidget {
  /// Optional widget displayed at the start of the tile.
  final Widget? leading;

  /// Optional widget displayed as the main title of the tile.
  final Widget? title;

  /// Optional widget displayed below the title.
  final Widget? subtitle;

  /// Optional widget displayed at the end of the tile.
  final Widget? trailing;

  /// Optional callback when the tile is tapped.
  final VoidCallback? onTap;

  /// Whether the tile is in the selected state.
  final bool selected;

  /// Whether the tile is enabled for interaction.
  final bool enabled;

  /// Optional padding around the tile content.
  final EdgeInsetsGeometry? contentPadding;

  /// Optional color for the selected state text.
  final Color? selectedColor;

  /// Optional color for the selected state background.
  final Color? selectedTileColor;

  /// Optional gap between the leading widget and title.
  final double? horizontalTitleGap;

  /// Optional minimum vertical padding.
  final double? minVerticalPadding;

  /// Optional minimum width for the leading widget area.
  final double? minLeadingWidth;

  /// Whether the tile should use a more compact layout.
  final bool dense;

  /// Whether to animate the tile when it appears.
  final bool animate;

  /// Optional minimum height constraint for the tile.
  final double? minHeight;

  /// Creates a custom list tile.
  ///
  /// All parameters are optional and can be used to customize the appearance
  /// and behavior of the list tile.
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
