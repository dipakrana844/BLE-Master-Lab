import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/utils/app_spacing.dart';
import '../providers/gatt_explorer_provider.dart';

/// Connection header with device info and disconnect button
class ConnectionHeader extends ConsumerWidget {
  const ConnectionHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gattExplorerProvider);
    final theme = Theme.of(context);

    return Container(
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: theme.colorScheme.primary,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
          AppSpacing.horizontalGapSm,
          
          // Device info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.deviceName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${state.isConnected ? 'Connected' : 'Disconnected'} • ${state.latency} Latency',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: state.isConnected ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          
          // Disconnect button
          AppButton(
            onPressed: state.isConnected 
                ? () => ref.read(toggleConnectionProvider)()
                : null,
            variant: ButtonVariant.secondary,
            size: ButtonSize.small,
            child: Text(state.isConnected ? 'Disconnect' : 'Connect'),
          ),
        ],
      ),
    );
  }
}