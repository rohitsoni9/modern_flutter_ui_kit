import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum AvatarShape { circle, rounded, square }

enum AvatarSize { small, medium, large, extraLarge }

enum AvatarStatus { online, offline, busy, away }

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? text;
  final IconData? icon;
  final AvatarShape shape;
  final AvatarSize size;
  final AvatarStatus? status;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? radius;
  final Widget? child;
  final BoxFit? fit;
  final bool showBorder;
  final Color? borderColor;
  final double? borderWidth;
  final double? minSize;
  final double? maxSize;

  const CustomAvatar({
    super.key,
    this.imageUrl,
    this.text,
    this.icon,
    this.shape = AvatarShape.circle,
    this.size = AvatarSize.medium,
    this.status,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.radius,
    this.child,
    this.fit,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth,
    this.minSize,
    this.maxSize,
  });

  double _getSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    switch (this.size) {
      case AvatarSize.small:
        return isSmallScreen ? 24 : 32;
      case AvatarSize.medium:
        return isSmallScreen ? 32 : 48;
      case AvatarSize.large:
        return isSmallScreen ? 48 : 64;
      case AvatarSize.extraLarge:
        return isSmallScreen ? 64 : 96;
    }
  }

  double _getBorderRadius(BuildContext context) {
    switch (shape) {
      case AvatarShape.circle:
        return _getSize(context) / 2;
      case AvatarShape.rounded:
        return _getSize(context) / 4;
      case AvatarShape.square:
        return 0;
    }
  }

  Color get _statusColor {
    switch (status) {
      case AvatarStatus.online:
        return Colors.green;
      case AvatarStatus.offline:
        return Colors.grey;
      case AvatarStatus.busy:
        return Colors.red;
      case AvatarStatus.away:
        return Colors.orange;
      case null:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    final avatarSize = radius ?? _getSize(context);
    final statusSize = avatarSize / (isSmallScreen ? 5 : 4);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          constraints: BoxConstraints(
            minWidth: minSize ?? (isSmallScreen ? 24 : 32),
            maxWidth: maxSize ?? (isSmallScreen ? 64 : 96),
            minHeight: minSize ?? (isSmallScreen ? 24 : 32),
            maxHeight: maxSize ?? (isSmallScreen ? 64 : 96),
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(
              radius ?? _getBorderRadius(context),
            ),
            border:
                showBorder
                    ? Border.all(
                      color: borderColor ?? colorScheme.outline,
                      width: borderWidth ?? (isSmallScreen ? 1.5 : 2),
                    )
                    : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              radius ?? _getBorderRadius(context),
            ),
            child:
                imageUrl != null
                    ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: fit ?? BoxFit.cover,
                      placeholder:
                          (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: colorScheme.primary,
                              strokeWidth: isSmallScreen ? 1.5 : 2,
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Icon(
                            Icons.person,
                            size: avatarSize / 2,
                            color: iconColor ?? colorScheme.onPrimaryContainer,
                          ),
                    )
                    : text != null
                    ? Center(
                      child: Text(
                        text!,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: textColor ?? colorScheme.onPrimaryContainer,
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                      ),
                    )
                    : icon != null
                    ? Center(
                      child: Icon(
                        icon,
                        size: avatarSize / 2,
                        color: iconColor ?? colorScheme.onPrimaryContainer,
                      ),
                    )
                    : child,
          ),
        ),
        if (status != null)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: statusSize,
              height: statusSize,
              decoration: BoxDecoration(
                color: _statusColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surface,
                  width: isSmallScreen ? 1.5 : 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
