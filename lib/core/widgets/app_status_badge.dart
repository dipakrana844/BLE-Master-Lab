import 'package:flutter/material.dart';

/// A reusable badge component for displaying status indicators.
///
/// Features:
/// - Multiple style variants (filled, outlined, subtle)
/// - Theme-aware coloring
/// - Customizable size and padding
/// - Accessibility support
class AppStatusBadge extends StatelessWidget {
  final String text;
  final BadgeStyle style;
  final BadgeSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const AppStatusBadge({
    super.key,
    required this.text,
    this.style = BadgeStyle.filled,
    this.size = BadgeSize.medium,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final (bgColor, fgColor) = _getColors(theme, isDark);
    
    final badgeContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: _getIconSize(), color: fgColor),
          const SizedBox(width: 4),
        ],
        Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: _getFontSize(),
            fontWeight: FontWeight.bold,
            color: fgColor,
            letterSpacing: 1.2,
            height: 1,
          ),
        ),
      ],
    );

    return Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        border: style == BadgeStyle.outlined
            ? Border.all(color: fgColor.withOpacity(0.3), width: 1)
            : null,
      ),
      child: badgeContent,
    );
  }

  (Color, Color) _getColors(ThemeData theme, bool isDark) {
    if (backgroundColor != null && textColor != null) {
      return (backgroundColor!, textColor!);
    }

    final primary = theme.colorScheme.primary;
    final onPrimary = theme.colorScheme.onPrimary;
    final surface = theme.colorScheme.surface;
    
    return switch (style) {
      BadgeStyle.filled => (backgroundColor ?? primary, textColor ?? onPrimary),
      BadgeStyle.outlined => (backgroundColor ?? Colors.transparent, textColor ?? primary),
      BadgeStyle.subtle => (
          backgroundColor ?? primary.withOpacity(isDark ? 0.2 : 0.1),
          textColor ?? primary,
        ),
    };
  }

  double _getFontSize() => switch (size) {
        BadgeSize.small => 8,
        BadgeSize.medium => 10,
        BadgeSize.large => 12,
      };

  double _getIconSize() => switch (size) {
        BadgeSize.small => 12,
        BadgeSize.medium => 14,
        BadgeSize.large => 16,
      };

  EdgeInsets _getPadding() => switch (size) {
        BadgeSize.small => const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        BadgeSize.medium => const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        BadgeSize.large => const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      };

  double _getBorderRadius() => switch (size) {
        BadgeSize.small => 6,
        BadgeSize.medium => 8,
        BadgeSize.large => 10,
      };
}

enum BadgeStyle { filled, outlined, subtle }
enum BadgeSize { small, medium, large }