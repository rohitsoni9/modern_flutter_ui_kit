import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// The shape of an avatar.
///
/// This enum defines different shape options for avatars, affecting their
/// border radius and overall appearance.
enum AvatarShape {
  /// A circular avatar with equal width and height.
  circle,

  /// A rounded rectangle avatar with slightly rounded corners.
  rounded,

  /// A square avatar with sharp corners.
  square,
}

/// The size of an avatar.
///
/// This enum defines different size options for avatars, with each size
/// automatically adapting to different screen sizes.
enum AvatarSize {
  /// A small avatar, typically used in lists or comments.
  small,

  /// A medium avatar, typically used in user profiles or headers.
  medium,

  /// A large avatar, typically used in profile pages or large displays.
  large,

  /// An extra large avatar, typically used in hero sections or featured content.
  extraLarge,
}

/// The status indicator of an avatar.
///
/// This enum defines different status options that can be displayed as
/// an indicator on an avatar.
enum AvatarStatus {
  /// Indicates the user is currently online and active.
  online,

  /// Indicates the user is currently offline.
  offline,

  /// Indicates the user is currently busy or in a meeting.
  busy,

  /// Indicates the user is currently away or inactive.
  away,
}

/// A customizable avatar widget with support for different shapes, sizes, and status indicators.
///
/// This widget provides a modern avatar component that can display an image,
/// text, or icon, with support for different shapes, sizes, and status indicators.
/// It automatically adapts to different screen sizes and themes.
class CustomAvatar extends StatelessWidget {
  /// The URL of the image to display in the avatar.
  final String? imageUrl;

  /// The text to display in the avatar (used when no image is provided).
  final String? text;

  /// The icon to display in the avatar (used when no image or text is provided).
  final IconData? icon;

  /// The shape of the avatar.
  final AvatarShape shape;

  /// The size of the avatar.
  final AvatarSize size;

  /// The status indicator to display on the avatar.
  final AvatarStatus? status;

  /// Optional custom background color for the avatar.
  final Color? backgroundColor;

  /// Optional custom text color for the avatar.
  final Color? textColor;

  /// Optional custom icon color for the avatar.
  final Color? iconColor;

  /// Optional custom radius for the avatar (overrides size-based radius).
  final double? radius;

  /// Optional custom child widget to display in the avatar.
  final Widget? child;

  /// Optional image fit mode for the avatar image.
  final BoxFit? fit;

  /// Whether to show a border around the avatar.
  final bool showBorder;

  /// Optional custom border color for the avatar.
  final Color? borderColor;

  /// Optional custom border width for the avatar.
  final double? borderWidth;

  /// Optional minimum size constraint for the avatar.
  final double? minSize;

  /// Optional maximum size constraint for the avatar.
  final double? maxSize;

  /// Creates a custom avatar.
  ///
  /// At least one of [imageUrl], [text], [icon], or [child] should be provided.
  /// All other parameters are optional and can be used to customize the
  /// appearance of the avatar.
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
