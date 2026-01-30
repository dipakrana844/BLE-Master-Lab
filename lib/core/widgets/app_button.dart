import 'package:flutter/material.dart';

/// A reusable button component with multiple variants and consistent styling.
///
/// Features:
/// - Primary, secondary, and tertiary variants
/// - Loading state support
/// - Icon support
/// - Accessibility support
/// - Consistent sizing and padding
class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.minWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveOnPressed = isLoading ? null : onPressed;
    
    final buttonStyle = _getButtonStyle(theme);
    
    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading) ...[
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: 8),
        ],
        DefaultTextStyle(
          style: _getTextStyle(theme),
          child: child,
        ),
      ],
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth ?? _getMinWidth()),
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        style: buttonStyle,
        child: Padding(
          padding: padding ?? _getDefaultPadding(),
          child: buttonChild,
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    final baseStyle = switch (variant) {
      ButtonVariant.primary => theme.elevatedButtonTheme.style,
      ButtonVariant.secondary => theme.outlinedButtonTheme.style?.copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          side: WidgetStateProperty.all(
            BorderSide(color: theme.colorScheme.primary.withOpacity(0.3), width: 1),
          ),
        ),
      ButtonVariant.tertiary => ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(theme.colorScheme.primary),
          overlayColor: WidgetStateProperty.all(theme.colorScheme.primary.withOpacity(0.1)),
          padding: WidgetStateProperty.all(_getDefaultPadding()),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
    };

    return baseStyle?.copyWith(
      minimumSize: WidgetStateProperty.all(Size(_getMinWidth(), _getHeight())),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    ) ?? const ButtonStyle();
  }

  TextStyle _getTextStyle(ThemeData theme) {
    final baseStyle = switch (variant) {
      ButtonVariant.primary => theme.elevatedButtonTheme.style?.textStyle?.resolve({}),
      ButtonVariant.secondary => theme.outlinedButtonTheme.style?.textStyle?.resolve({}),
      ButtonVariant.tertiary => theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
    };

    return baseStyle ?? const TextStyle();
  }

  double _getIconSize() => switch (size) {
        ButtonSize.small => 16,
        ButtonSize.medium => 20,
        ButtonSize.large => 24,
      };

  double _getMinWidth() => switch (size) {
        ButtonSize.small => 80,
        ButtonSize.medium => 100,
        ButtonSize.large => 120,
      };

  double _getHeight() => switch (size) {
        ButtonSize.small => 32,
        ButtonSize.medium => 40,
        ButtonSize.large => 48,
      };

  EdgeInsets _getDefaultPadding() => switch (size) {
        ButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ButtonSize.large => const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      };
}

enum ButtonVariant { primary, secondary, tertiary }
enum ButtonSize { small, medium, large }