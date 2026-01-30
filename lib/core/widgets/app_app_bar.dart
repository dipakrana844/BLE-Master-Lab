import 'package:flutter/material.dart';

/// A reusable app bar component with iOS-style design.
///
/// Features:
/// - iOS-style layout with centered title
/// - Leading/trailing actions support
/// - Theme-aware styling
/// - Safe area handling
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? trailingActions;
  final bool showDivider;
  final double? elevation;

  const AppAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailingActions,
    this.showDivider = false,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AppBar(
      leading: leading,
      title: Text(
        title,
        style: theme.appBarTheme.titleTextStyle,
      ),
      centerTitle: true,
      actions: trailingActions,
      elevation: elevation ?? 0,
      scrolledUnderElevation: elevation ?? 0,
      surfaceTintColor: Colors.transparent,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                height: 0.5,
                color: theme.dividerColor,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}