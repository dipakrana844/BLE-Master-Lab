import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/simulation_hub_provider.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/utils/app_spacing.dart';

/// A fixed bottom panel with simulation controls.
///
/// Features:
/// - Start/Stop simulation button with dynamic text
/// - Reset button
/// - Fixed positioning with backdrop blur
/// - Theme-aware styling
/// - Accessibility support
/// - Performance-optimized with const constructors
class FixedBottomPanel extends ConsumerWidget {
  final VoidCallback? onStartPressed;
  final VoidCallback? onStopPressed;
  final VoidCallback? onResetPressed;

  const FixedBottomPanel({
    super.key,
    this.onStartPressed,
    this.onStopPressed,
    this.onResetPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunning = ref.watch(isSimulationRunningProvider);
    
    return Container(
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: AppSpacing.paddingMd.copyWith(bottom: 20),
          child: Row(
            children: [
              // Start/Stop button (flexible)
              Expanded(
                flex: 3,
                child: AppButton(
                  onPressed: isRunning
                      ? () {
                          ref.read(simulationHubProvider.notifier).stopSimulation();
                          onStopPressed?.call();
                        }
                      : () {
                          ref.read(simulationHubProvider.notifier).startSimulation();
                          onStartPressed?.call();
                        },
                  variant: ButtonVariant.primary,
                  size: ButtonSize.large,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isRunning ? Icons.stop : Icons.play_arrow,
                        size: 20,
                      ),
                      AppSpacing.horizontalGapSm,
                      Text(
                        isRunning ? 'Stop Simulation' : 'Start Simulation',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.horizontalGapMd,
              // Reset button (fixed width)
              SizedBox(
                width: 56,
                child: AppButton(
                  onPressed: () {
                    ref.read(simulationHubProvider.notifier).resetSimulation();
                    onResetPressed?.call();
                  },
                  variant: ButtonVariant.secondary,
                  size: ButtonSize.large,
                  child: const Icon(
                    Icons.restart_alt,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get appropriate background color based on theme
  Color _getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return isDark
        ? const Color(0xFF191E33).withOpacity(0.95)
        : Colors.white.withOpacity(0.9);
  }
}