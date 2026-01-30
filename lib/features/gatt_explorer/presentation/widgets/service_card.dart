import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/gatt_service.dart';
import '../providers/gatt_explorer_provider.dart';
import 'characteristic_item.dart';

/// Displays a GATT service with expandable characteristics
class ServiceCard extends ConsumerWidget {
  final GattService service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return AppCard(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(16),
      borderColor: theme.brightness == Brightness.dark
          ? Colors.white.withOpacity(0.05)
          : Colors.grey.withOpacity(0.2),
      hasShadow: false,
      child: Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: ValueKey(service.id),
          initiallyExpanded: service.isExpanded,
          onExpansionChanged: (expanded) {
            ref.read(toggleServiceProvider)(service.id);
          },
          tilePadding: AppSpacing.paddingHorizontalMd,
          childrenPadding: const EdgeInsets.only(bottom: 8),
          title: _ServiceHeader(service: service),
          children: [
            for (final characteristic in service.characteristics)
              CharacteristicItem(characteristic: characteristic),
          ],
        ),
      ),
    );
  }
}

/// Header widget for service card
class _ServiceHeader extends StatelessWidget {
  final GattService service;

  const _ServiceHeader({required this.service});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final iconColor = _getIconColor(context, service.iconColor);

    return Row(
      children: [
        // Icon container
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(isDark ? 0.1 : 0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getIconData(service.icon),
            color: iconColor,
            size: 24,
          ),
        ),
        AppSpacing.horizontalGapMd,
        
        // Service info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                service.uuid,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        
        // Expand indicator
        Icon(
          Icons.expand_more,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
      ],
    );
  }

  IconData _getIconData(String icon) {
    switch (icon) {
      case 'favorite':
        return Icons.favorite;
      case 'info':
        return Icons.info;
      case 'settings_remote':
        return Icons.settings_remote;
      default:
        return Icons.bluetooth;
    }
  }

  Color _getIconColor(BuildContext context, String colorName) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    
    switch (colorName) {
      case 'rose':
        return Colors.pink;
      case 'blue':
        return Colors.blue;
      case 'primary':
        return primary;
      default:
        return primary;
    }
  }
}