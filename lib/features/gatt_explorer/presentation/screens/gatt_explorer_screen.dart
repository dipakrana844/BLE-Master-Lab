import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/app_spacing.dart';
import '../providers/gatt_explorer_provider.dart';
import '../widgets/connection_header.dart';
import '../widgets/service_card.dart';
import '../widgets/write_panel.dart';

/// GATT Explorer screen for browsing BLE services and characteristics
class GattExplorerScreen extends ConsumerWidget {
  const GattExplorerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gattExplorerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Column(
            children: [
              const ConnectionHeader(),
              AppSpacing.verticalGapSm,
              
              // Services list
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Section header
                    Padding(
                      padding: AppSpacing.paddingHorizontalMd,
                      child: Text(
                        'GATT Services',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    AppSpacing.verticalGapXs,
                    
                    // Services
                    for (final service in state.services)
                      ServiceCard(service: service),
                    
                    // Bottom padding
                    const SizedBox(height: 128),
                  ],
                ),
              ),
            ],
          ),
          
          // Write panel overlay
          if (state.isWritePanelVisible && state.selectedCharacteristic != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => ref.read(hideWritePanelProvider)(),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: GestureDetector(
                    onTap: () {}, // Prevent tap through
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: WritePanel(
                        characteristic: state.selectedCharacteristic!,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}