import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/simulation_hub_provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/simulation_config.dart';

/// A reusable card widget for simulation configuration controls.
///
/// Features:
/// - Label with current value badge
/// - Slider control with real-time updates
/// - Min/max labels
/// - Theme-aware styling
/// - Performance-optimized with const constructors
class SimulationControlCard extends ConsumerWidget {
  final SimulationControlType controlType;

  const SimulationControlCard({
    super.key,
    required this.controlType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(simulationConfigProvider);
    
    return AppCard(
      padding: AppSpacing.paddingMd,
      borderRadius: BorderRadius.circular(16),
      borderColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white.withOpacity(0.05)
          : Colors.grey.withOpacity(0.2),
      hasShadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with label and value badge
          _ControlHeader(
            controlType: controlType,
            currentValue: _getCurrentValue(config, controlType),
          ),
          AppSpacing.verticalGapMd,
          // Slider control
          _ControlSlider(
            controlType: controlType,
            value: _getCurrentValue(config, controlType),
            onChanged: (value) => _handleValueChanged(ref, controlType, value),
          ),
          AppSpacing.verticalGapSm,
          // Min/Max labels
          _ControlLabels(controlType: controlType),
        ],
      ),
    );
  }

  double _getCurrentValue(SimulationConfig config, SimulationControlType type) {
    return switch (type) {
      SimulationControlType.dataNoise => config.dataNoise,
      SimulationControlType.refreshRate => config.refreshRateMs / 1000.0,
    };
  }

  void _handleValueChanged(
    WidgetRef ref,
    SimulationControlType type,
    double value,
  ) {
    switch (type) {
      case SimulationControlType.dataNoise:
        ref.read(simulationHubProvider.notifier).updateDataNoise(value);
      case SimulationControlType.refreshRate:
        ref.read(simulationHubProvider.notifier).updateRefreshRate((value * 1000).toInt());
    }
  }
}

/// Header section with label and current value badge
class _ControlHeader extends StatelessWidget {
  final SimulationControlType controlType;
  final double currentValue;

  const _ControlHeader({
    required this.controlType,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getControlLabel(controlType),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _formatCurrentValue(controlType, currentValue),
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Slider control for adjusting values
class _ControlSlider extends StatelessWidget {
  final SimulationControlType controlType;
  final double value;
  final ValueChanged<double> onChanged;

  const _ControlSlider({
    required this.controlType,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: theme.colorScheme.primary,
        inactiveTrackColor: isDark
            ? const Color(0xFF232948)
            : Colors.grey[300],
        thumbColor: theme.colorScheme.primary,
        overlayColor: theme.colorScheme.primary.withOpacity(0.1),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        trackHeight: 6,
      ),
      child: Slider(
        value: value,
        min: _getMinValue(controlType),
        max: _getMaxValue(controlType),
        onChanged: onChanged,
      ),
    );
  }
}

/// Min/Max labels below the slider
class _ControlLabels extends StatelessWidget {
  final SimulationControlType controlType;

  const _ControlLabels({required this.controlType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getMinLabel(controlType),
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            fontSize: 10,
            letterSpacing: 1.2,
            height: 1.2,
          ),
        ),
        Text(
          _getMaxLabel(controlType),
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            fontSize: 10,
            letterSpacing: 1.2,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

/// Control type enum
enum SimulationControlType {
  dataNoise,
  refreshRate,
}

/// Helper methods
String _getControlLabel(SimulationControlType type) {
  return switch (type) {
    SimulationControlType.dataNoise => 'Data Noise',
    SimulationControlType.refreshRate => 'Refresh Rate',
  };
}

String _formatCurrentValue(SimulationControlType type, double value) {
  return switch (type) {
    SimulationControlType.dataNoise => '${(value * 100).toInt()}%',
    SimulationControlType.refreshRate => '${value.toInt()}ms',
  };
}

double _getMinValue(SimulationControlType type) {
  return switch (type) {
    SimulationControlType.dataNoise => 0.0,
    SimulationControlType.refreshRate => 0.1, // 100ms
  };
}

double _getMaxValue(SimulationControlType type) {
  return switch (type) {
    SimulationControlType.dataNoise => 1.0,
    SimulationControlType.refreshRate => 2.0, // 2000ms
  };
}

String _getMinLabel(SimulationControlType type) {
  return switch (type) {
    SimulationControlType.dataNoise => 'Steady',
    SimulationControlType.refreshRate => 'Fast',
  };
}

String _getMaxLabel(SimulationControlType type) {
  return switch (type) {
    SimulationControlType.dataNoise => 'Chaotic',
    SimulationControlType.refreshRate => 'Slow',
  };
}