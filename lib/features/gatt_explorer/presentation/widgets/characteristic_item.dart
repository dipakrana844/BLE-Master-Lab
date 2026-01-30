import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/gatt_service.dart';
import '../providers/gatt_explorer_provider.dart';

/// Displays a GATT characteristic with its properties
class CharacteristicItem extends ConsumerWidget {
  final GattCharacteristic characteristic;

  const CharacteristicItem({
    super.key,
    required this.characteristic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () {
        if (characteristic.properties.contains(CharacteristicProperty.write)) {
          ref.read(selectCharacteristicProvider)(characteristic);
        }
      },
      child: Container(
        padding: AppSpacing.paddingMd,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 2,
            ),
          ),
          color: characteristic.properties.contains(CharacteristicProperty.write)
              ? theme.colorScheme.primary.withOpacity(0.05)
              : null,
        ),
        child: Row(
          children: [
            // Characteristic info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and properties
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          characteristic.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Property badges
                      _PropertyBadges(properties: characteristic.properties),
                    ],
                  ),
                  AppSpacing.verticalGapXs,
                  
                  // UUID
                  Text(
                    characteristic.uuid,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Active status badge (for writable characteristics)
            if (characteristic.isActive && characteristic.activeStatus != null) ...[
              AppSpacing.horizontalGapSm,
              _ActiveStatusBadge(status: characteristic.activeStatus!),
            ] else ...[
              AppSpacing.horizontalGapSm,
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurface.withOpacity(0.3),
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Displays characteristic property badges (R, W, N, I)
class _PropertyBadges extends StatelessWidget {
  final List<CharacteristicProperty> properties;

  const _PropertyBadges({required this.properties});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: properties.map((property) {
        final (color, bgColor) = _getPropertyColors(context, property);
        
        return Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              property.abbreviation,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 8,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  (Color, Color) _getPropertyColors(BuildContext context, CharacteristicProperty property) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    switch (property) {
      case CharacteristicProperty.read:
        final color = isDark ? Colors.blue[300]! : Colors.blue[600]!;
        return (color, color.withOpacity(0.2));
      case CharacteristicProperty.write:
        final color = isDark ? Colors.green[300]! : Colors.green[600]!;
        return (color, color.withOpacity(0.2));
      case CharacteristicProperty.notify:
        final color = isDark ? Colors.orange[300]! : Colors.orange[600]!;
        return (color, color.withOpacity(0.2));
      case CharacteristicProperty.indicate:
        final color = isDark ? Colors.purple[300]! : Colors.purple[600]!;
        return (color, color.withOpacity(0.2));
    }
  }
}

/// Displays active status badge
class _ActiveStatusBadge extends StatelessWidget {
  final String status;

  const _ActiveStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}