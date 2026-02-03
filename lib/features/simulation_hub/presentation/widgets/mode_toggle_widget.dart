import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/simulation_hub_provider.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/simulation_config.dart';

/// A reusable segmented button widget for toggling between simulation modes.
///
/// Features:
/// - Hardware Mode and Simulation Lab options
/// - Smooth transition animations
/// - Theme-aware styling
/// - Accessibility support
/// - Performance-optimized with const constructors
class ModeToggleWidget extends ConsumerWidget {
  final ValueChanged<SimulationMode>? onModeChanged;

  const ModeToggleWidget({
    super.key,
    this.onModeChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(simulationModeProvider);
    
    return Padding(
      padding: AppSpacing.paddingHorizontalMd,
      child: AppCard(
        padding: AppSpacing.paddingSm,
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF232948)
            : Colors.grey[200],
        child: Row(
          children: [
            _ModeOption(
              mode: SimulationMode.hardware,
              isSelected: currentMode == SimulationMode.hardware,
              onTap: () => _handleModeChange(ref, SimulationMode.hardware),
            ),
            _ModeOption(
              mode: SimulationMode.simulation,
              isSelected: currentMode == SimulationMode.simulation,
              onTap: () => _handleModeChange(ref, SimulationMode.simulation),
            ),
          ],
        ),
      ),
    );
  }

  void _handleModeChange(WidgetRef ref, SimulationMode mode) {
    ref.read(simulationHubProvider.notifier).updateMode(mode);
    onModeChanged?.call(mode);
  }
}

/// Individual mode option button within the toggle
class _ModeOption extends StatelessWidget {
  final SimulationMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeOption({
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF101322) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: theme.textTheme.labelLarge!.copyWith(
                color: isSelected
                    ? (isDark ? Colors.white : theme.colorScheme.primary)
                    : (isDark ? const Color(0xFF929bc9) : Colors.grey[500]!),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(mode.displayName),
            ),
          ),
        ),
      ),
    );
  }
}