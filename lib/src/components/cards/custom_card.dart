import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// The visual style variant of a card.
///
/// This enum defines different visual styles for cards, each with its own
/// elevation, border, and background characteristics.
enum CardVariant {
  /// A card with elevation and shadow, appearing to float above the surface.
  elevated,

  /// A card with a border but no elevation or shadow.
  outlined,

  /// A card with a filled background color but no elevation or shadow.
  filled,
}

/// A customizable card widget with support for different variants and animations.
///
/// This widget provides a modern, animated card with support for different
/// visual styles (elevated, outlined, filled), custom colors, and animations.
/// It automatically adapts to different screen sizes and themes.
class CustomCard extends StatelessWidget {
  /// The widget to display inside the card.
  final Widget child;

  /// The visual style variant of the card.
  final CardVariant variant;

  /// Optional padding around the card content.
  final EdgeInsetsGeometry? padding;

  /// Optional margin around the card.
  final EdgeInsetsGeometry? margin;

  /// Optional elevation of the card (only applies to elevated variant).
  final double? elevation;

  /// Optional background color of the card.
  final Color? backgroundColor;

  /// Optional border radius for the card corners.
  final BorderRadius? borderRadius;

  /// Optional callback when the card is tapped.
  final VoidCallback? onTap;

  /// Whether to animate the card when it appears.
  final bool animate;

  /// Optional duration for the card animation.
  final Duration? animationDuration;

  /// Optional maximum width constraint for the card.
  final double? maxWidth;

  /// Optional minimum height constraint for the card.
  final double? minHeight;

  /// Creates a custom card.
  ///
  /// The [child] parameter is required. All other parameters are optional
  /// and can be used to customize the appearance and behavior of the card.
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
          boxShadow:
              cardElevation == 0
                  ? null
                  : [
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
