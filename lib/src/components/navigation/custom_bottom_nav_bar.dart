import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<CustomBottomNavBarItem> items;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? elevation;
  final double? iconSize;
  final double? itemHeight;
  final bool showLabels;
  final double? labelFontSize;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final double? minHeight;
  final double? maxHeight;

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
      constraints: BoxConstraints(
        minHeight: minHeight ?? (isSmallScreen ? 48 : 56),
        maxHeight: maxHeight ?? (isSmallScreen ? 64 : 72),
      ),
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
      child: SafeArea(
        child: Row(
          children: List.generate(
            items.length,
            (index) => Expanded(
              child: _CustomBottomNavBarItem(
                item: items[index],
                isSelected: index == currentIndex,
                onTap: () => onTap(index),
                selectedColor: selectedItemColor ?? colorScheme.primary,
                unselectedColor: unselectedItemColor ?? colorScheme.onSurface,
                iconSize: iconSize ?? (isSmallScreen ? 20 : 24),
                itemHeight: itemHeight ?? (isSmallScreen ? 48 : 56),
                showLabel: showLabels,
                labelFontSize: labelFontSize ?? (isSmallScreen ? 10 : 12),
                animationDuration: animationDuration,
                animationCurve: animationCurve,
              ),
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
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final color = isSelected ? selectedColor : unselectedColor;
    final icon =
        isSelected ? (item.activeIcon ?? Icon(item.icon)) : Icon(item.icon);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: itemHeight,
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6 : 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon
                  .animate(
                    target: isSelected ? 1 : 0,
                    delay:
                        animationDuration ?? const Duration(milliseconds: 200),
                  )
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.2, 1.2),
                    curve: animationCurve ?? Curves.easeInOut,
                  )
                  .color(begin: unselectedColor, end: selectedColor),
              if (showLabel) ...[
                SizedBox(height: isSmallScreen ? 2 : 4),
                Text(
                      item.label,
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
