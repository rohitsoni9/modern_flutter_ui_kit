import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum CardVariant { elevated, outlined, filled }

class CustomCard extends StatelessWidget {
  final Widget child;
  final CardVariant variant;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool animate;
  final Duration? animationDuration;
  final double? maxWidth;
  final double? minHeight;

  const CustomCard({
    super.key,
    required this.child,
    this.variant = CardVariant.elevated,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    this.animate = true,
    this.animationDuration,
    this.maxWidth,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    Color cardColor;
    double cardElevation;
    BorderSide? borderSide;

    switch (variant) {
      case CardVariant.elevated:
        cardColor = backgroundColor ?? colorScheme.surface;
        cardElevation = elevation ?? (isSmallScreen ? 1 : 2);
        borderSide = BorderSide.none;
        break;
      case CardVariant.outlined:
        cardColor = backgroundColor ?? colorScheme.surface;
        cardElevation = 0;
        borderSide = BorderSide(color: colorScheme.outline);
        break;
      case CardVariant.filled:
        cardColor = backgroundColor ?? colorScheme.surfaceContainerHighest;
        cardElevation = 0;
        borderSide = BorderSide.none;
        break;
    }

    Widget card = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? (isSmallScreen ? size.width * 0.95 : 600),
        minHeight: minHeight ?? (isSmallScreen ? 80 : 100),
      ),
      child: Container(
        margin: margin ?? EdgeInsets.all(isSmallScreen ? 8 : 12),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius:
              borderRadius ?? BorderRadius.circular(isSmallScreen ? 8 : 12),
          border: Border.fromBorderSide(borderSide),
          boxShadow: cardElevation == 0 ? null : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 26),
              blurRadius: cardElevation * 2,
              offset: Offset(0, cardElevation),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius:
              borderRadius ?? BorderRadius.circular(isSmallScreen ? 8 : 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: padding ?? EdgeInsets.all(isSmallScreen ? 12 : 16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );

    if (animate) {
      card = card
          .animate(
            delay: animationDuration ?? const Duration(milliseconds: 300),
          )
          .fadeIn()
          .slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
    }

    return card;
  }
}
