import 'package:flutter/material.dart';

/// A reusable bottom sheet component with iOS-style design.
///
/// Features:
/// - Grabber handle
/// - Theme-aware styling
/// - Safe area handling
/// - Customizable height
class AppSheet extends StatelessWidget {
  final Widget child;
  final double? height;
  final bool enableDrag;
  final Color? backgroundColor;

  const AppSheet({
    super.key,
    required this.child,
    this.height,
    this.enableDrag = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final sheetColor = backgroundColor ?? 
        (isDark ? const Color(0xFF1c1c2e) : Colors.white);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: sheetColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Grabber handle
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.white.withOpacity(0.2) 
                  : Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 16),
          
          // Content
          Expanded(child: child),
        ],
      ),
    );
  }
}