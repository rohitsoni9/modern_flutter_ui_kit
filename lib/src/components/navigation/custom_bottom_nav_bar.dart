import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A customizable bottom navigation bar widget with support for animations and different styles.
///
/// This widget provides a modern bottom navigation bar component that can display
/// multiple items with icons and labels, with support for animations, custom colors,
/// and different styles. It automatically adapts to different screen sizes and themes.
class CustomBottomNavBar extends StatelessWidget {
  /// The index of the currently selected item.
  final int currentIndex;

  /// The list of navigation items to display.
  final List<CustomBottomNavBarItem> items;

  /// Callback when a navigation item is tapped.
  final ValueChanged<int> onTap;

  /// Optional background color for the navigation bar.
  final Color? backgroundColor;

  /// Optional color for the selected item.
  final Color? selectedItemColor;

  /// Optional color for the unselected items.
  final Color? unselectedItemColor;

  /// Optional elevation of the navigation bar.
  final double? elevation;

  /// Optional size of the item icons.
  final double? iconSize;

  /// Optional height of each navigation item.
  final double? itemHeight;

  /// Whether to show labels below the icons.
  final bool showLabels;

  /// Optional font size for the item labels.
  final double? labelFontSize;

  /// Optional duration for the navigation animations.
  final Duration? animationDuration;

  /// Optional curve for the navigation animations.
  final Curve? animationCurve;

  /// Optional minimum height constraint for the navigation bar.
  final double? minHeight;

  /// Optional maximum height constraint for the navigation bar.
  final double? maxHeight;

  /// Creates a custom bottom navigation bar.
  ///
  /// The [currentIndex], [items], and [onTap] parameters are required.
  /// All other parameters are optional and can be used to customize the
  /// appearance and behavior of the navigation bar.
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation,
    this.iconSize,
    this.itemHeight,
    this.showLabels = true,
    this.labelFontSize,
    this.animationDuration,
    this.animationCurve,
    this.minHeight,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Container(
      height: 80,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 26),
            blurRadius: elevation ?? (isSmallScreen ? 4 : 8),
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => Expanded(
            child: _CustomBottomNavBarItem(
              item: items[index],
              isSelected: index == currentIndex,
              onTap: () => onTap(index),
              selectedColor: selectedItemColor ?? colorScheme.primary,
              unselectedColor: unselectedItemColor ?? colorScheme.onSurface,
              iconSize: iconSize ?? (isSmallScreen ? 18 : 22),
              itemHeight: itemHeight ?? (isSmallScreen ? 40 : 48),
              showLabel: showLabels,
              labelFontSize: labelFontSize ?? (isSmallScreen ? 10 : 11),
              animationDuration: animationDuration,
              animationCurve: animationCurve,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavBarItem {
  final IconData icon;
  final String label;
  final Widget? activeIcon;

  const CustomBottomNavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}

class _CustomBottomNavBarItem extends StatelessWidget {
  final CustomBottomNavBarItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double iconSize;
  final double itemHeight;
  final bool showLabel;
  final double labelFontSize;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const _CustomBottomNavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.iconSize,
    required this.itemHeight,
    required this.showLabel,
    required this.labelFontSize,
    this.animationDuration,
    this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? selectedColor : unselectedColor;
    final icon = Icon(item.icon, size: iconSize, color: color);

    final activeIcon =
        item.activeIcon ?? Icon(item.icon, size: iconSize, color: color);

    final currentIcon = isSelected ? activeIcon : icon;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: itemHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: iconSize,
                child: currentIcon
                    .animate(
                      target: isSelected ? 1 : 0,
                      delay:
                          animationDuration ??
                          const Duration(milliseconds: 200),
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.1, 1.1),
                      curve: animationCurve ?? Curves.easeInOut,
                    ),
              ),
              if (showLabel) ...[
                const SizedBox(height: 2),
                Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: color,
                        fontSize: labelFontSize,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                    .animate(
                      target: isSelected ? 1 : 0,
                      delay:
                          animationDuration ??
                          const Duration(milliseconds: 200),
                    )
                    .fadeIn(curve: animationCurve ?? Curves.easeInOut),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
