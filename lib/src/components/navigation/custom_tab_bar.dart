import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final List<String> tabs;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final double? indicatorHeight;
  final double? indicatorWeight;
  final EdgeInsetsGeometry? padding;
  final bool isScrollable;
  final double? tabHeight;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final double? minHeight;
  final double? maxHeight;

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
