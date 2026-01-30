import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable card component with consistent styling and accessibility support.
///
/// Features:
/// - Theme-aware styling
/// - Hover effects
/// - Accessibility support
/// - Customizable elevation and borders
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final Color? borderColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool hasShadow;

  const AppCard({
    super.key,
    required this.child,
    this.margin,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.borderColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
    this.isSelected = false,
    this.hasShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final cardColor = color ?? 
        (isDark ? theme.cardTheme.color ?? theme.colorScheme.surface : theme.colorScheme.surface);
    
    final borderSide = borderColor != null
        ? BorderSide(color: borderColor!, width: 1)
        : BorderSide.none;

    final card = Card(
      color: cardColor,
      elevation: isSelected ? (elevation ?? 4) : (hasShadow ? (elevation ?? 2) : 0),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        side: borderSide,
      ),
      margin: margin,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );

    // Add accessibility semantics
    return Semantics(
      button: onTap != null,
      enabled: onTap != null,
      child: card,
    );
  }
}