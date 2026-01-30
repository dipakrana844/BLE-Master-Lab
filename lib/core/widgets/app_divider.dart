import 'package:flutter/material.dart';

/// A reusable divider component with consistent styling.
///
/// Features:
/// - Theme-aware styling
/// - Customizable thickness and color
/// /// - Horizontal and vertical variants
/// - Accessibility support
class AppDivider extends StatelessWidget {
  final Axis direction;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const AppDivider({
    super.key,
    this.direction = Axis.horizontal,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  const AppDivider.vertical({
    super.key,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  }) : direction = Axis.vertical;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final effectiveColor = color ?? theme.dividerColor;
    final effectiveThickness = thickness ?? 0.5;

    return direction == Axis.horizontal
        ? Divider(
            height: effectiveThickness,
            thickness: effectiveThickness,
            indent: indent,
            endIndent: endIndent,
            color: effectiveColor,
          )
        : VerticalDivider(
            width: effectiveThickness,
            thickness: effectiveThickness,
            indent: indent,
            endIndent: endIndent,
            color: effectiveColor,
          );
  }
}