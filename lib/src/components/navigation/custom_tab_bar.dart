import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A customizable tab bar widget with support for animations and different styles.
///
/// This widget provides a modern tab bar component that can display multiple
/// tabs with support for animations, custom colors, and different styles.
/// It automatically adapts to different screen sizes and themes.
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// The index of the currently selected tab.
  final int currentIndex;

  /// The list of tab labels to display.
  final List<String> tabs;

  /// Callback when a tab is tapped.
  final ValueChanged<int> onTap;

  /// Optional background color for the tab bar.
  final Color? backgroundColor;

  /// Optional color for the selected tab text.
  final Color? selectedColor;

  /// Optional color for the unselected tab text.
  final Color? unselectedColor;

  /// Optional color for the tab indicator.
  final Color? indicatorColor;

  /// Optional height of the tab indicator.
  final double? indicatorHeight;

  /// Optional weight of the tab indicator.
  final double? indicatorWeight;

  /// Optional padding around the tab bar.
  final EdgeInsetsGeometry? padding;

  /// Whether the tab bar should scroll horizontally when tabs overflow.
  final bool isScrollable;

  /// Optional height of each tab.
  final double? tabHeight;

  /// Optional text style for the selected tab label.
  final TextStyle? selectedLabelStyle;

  /// Optional text style for the unselected tab label.
  final TextStyle? unselectedLabelStyle;

  /// Optional duration for the tab animations.
  final Duration? animationDuration;

  /// Optional curve for the tab animations.
  final Curve? animationCurve;

  /// Optional minimum height constraint for the tab bar.
  final double? minHeight;

  /// Optional maximum height constraint for the tab bar.
  final double? maxHeight;

  /// Creates a custom tab bar.
  ///
  /// The [currentIndex], [tabs], and [onTap] parameters are required.
  /// All other parameters are optional and can be used to customize the
  /// appearance and behavior of the tab bar.
  const CustomTabBar({
    super.key,
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.indicatorHeight,
    this.indicatorWeight,
    this.padding,
    this.isScrollable = false,
    this.tabHeight,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
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
        minHeight: minHeight ?? (isSmallScreen ? 40 : 48),
        maxHeight: maxHeight ?? (isSmallScreen ? 56 : 64),
      ),
      color: backgroundColor ?? colorScheme.surface,
      child: TabBar(
        controller: TabController(
          length: tabs.length,
          initialIndex: currentIndex,
          vsync: Navigator.of(context),
        ),
        onTap: onTap,
        isScrollable: isScrollable || (isSmallScreen && tabs.length > 3),
        padding:
            padding ??
            EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
        labelColor: selectedColor ?? colorScheme.primary,
        unselectedLabelColor: unselectedColor ?? colorScheme.onSurface,
        indicatorColor: indicatorColor ?? colorScheme.primary,
        indicatorWeight: indicatorWeight ?? (isSmallScreen ? 1.5 : 2),
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle:
            selectedLabelStyle ??
            theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 14 : 16,
            ),
        unselectedLabelStyle:
            unselectedLabelStyle ??
            theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: isSmallScreen ? 14 : 16,
            ),
        tabs: List.generate(
          tabs.length,
          (index) => _CustomTab(
            text: tabs[index],
            isSelected: index == currentIndex,
            animationDuration: animationDuration,
            animationCurve: animationCurve,
            isSmallScreen: isSmallScreen,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(tabHeight ?? 48);
}

class _CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool isSmallScreen;

  const _CustomTab({
    required this.text,
    required this.isSelected,
    this.animationDuration,
    this.animationCurve,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 12,
          vertical: isSmallScreen ? 4 : 8,
        ),
        child: Text(text)
            .animate(
              target: isSelected ? 1 : 0,
              delay: animationDuration ?? const Duration(milliseconds: 200),
            )
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.1, 1.1),
              curve: animationCurve ?? Curves.easeInOut,
            ),
      ),
    );
  }
}
