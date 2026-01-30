import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_status_badge.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/mode.dart';

/// A specialized card component for displaying BLE mode options.
///
/// Features:
/// - Mode-specific styling based on difficulty level
/// - Status badge for recommended/locked states
/// - Responsive layout with icon visualization
/// - Performance-optimized with const constructors
class ModeCard extends ConsumerWidget {
  final Mode mode;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool showRecommendedBadge;

  const ModeCard({
    super.key,
    required this.mode,
    this.onTap,
    this.isSelected = false,
    this.showRecommendedBadge = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AppCard(
      margin: AppSpacing.marginSm,
      padding: AppSpacing.paddingMd,
      borderColor: isSelected 
          ? theme.colorScheme.primary 
          : (isDark ? theme.colorScheme.outline.withOpacity(0.2) : null),
      onTap: onTap,
      isSelected: isSelected,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content section
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level indicator and badges
                Row(
                  children: [
                    Text(
                      _getLevelText(mode.type),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                    if (mode.isLocked) ...[
                      AppSpacing.horizontalGapSm,
                      const Icon(
                        Icons.lock,
                        size: 16,
                        color: Colors.orange,
                      ),
                    ],
                    const Spacer(),
                    if (showRecommendedBadge)
                      const AppStatusBadge(
                        text: 'START HERE',
                        style: BadgeStyle.filled,
                        size: BadgeSize.small,
                      ),
                  ],
                ),
                AppSpacing.verticalGapSm,
                
                // Mode title
                Text(
                  _getTitle(mode.type),
                  style: theme.textTheme.titleLarge,
                ),
                AppSpacing.verticalGapXs,
                
                // Description
                Text(
                  mode.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark 
                        ? const Color(0xFF8ECCCC) 
                        : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                AppSpacing.verticalGapMd,
                
                // Action button
                _buildActionButton(context, theme),
              ],
            ),
          ),
          
          AppSpacing.horizontalGapMd,
          
          // Icon visualization
          _buildModeIcon(theme, isDark),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, ThemeData theme) {
    final buttonText = mode.isLocked 
        ? 'Unlock' 
        : (mode.type == ModeType.beginner ? 'Initialize' : 'Select');
        
    final buttonVariant = mode.type == ModeType.beginner && !mode.isLocked
        ? ButtonVariant.primary
        : ButtonVariant.secondary;

    return AppButton(
      onPressed: mode.isLocked ? null : onTap,
      variant: buttonVariant,
      size: ButtonSize.small,
      child: Text(buttonText),
    );
  }

  Widget _buildModeIcon(ThemeData theme, bool isDark) {
    final iconData = switch (mode.type) {
      ModeType.beginner => Icons.school,
      ModeType.intermediate => Icons.layers,
      ModeType.advanced => Icons.terminal,
    };
    
    final iconColor = theme.colorScheme.primary;
    final backgroundColor = iconColor.withOpacity(isDark ? 0.1 : 0.2);

    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(
          iconData,
          size: 48,
          color: iconColor,
        ),
      ),
    );
  }

  String _getLevelText(ModeType type) => switch (type) {
        ModeType.beginner => 'LVL 01',
        ModeType.intermediate => 'LVL 02',
        ModeType.advanced => 'LVL 03',
      };

  String _getTitle(ModeType type) => switch (type) {
        ModeType.beginner => 'Beginner',
        ModeType.intermediate => 'Intermediate',
        ModeType.advanced => 'Advanced',
      };
}