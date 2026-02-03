import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/simulation_hub_provider.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../domain/entities/simulation_config.dart';

/// A reusable card widget for displaying sensor data with visualization.
///
/// Features:
/// - Color-coded icons based on sensor type
/// - Large metric display with units
/// - Mini visualization (bar chart or waveform)
/// - Status indicators
/// - Theme-aware styling
/// - Performance-optimized with const constructors
class SensorDataCard extends ConsumerWidget {
  final SensorType sensorType;

  const SensorDataCard({
    super.key,
    required this.sensorType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sensorDataMap = ref.watch(sensorDataProvider);
    final sensorData = sensorDataMap[sensorType];
    
    if (sensorData == null) {
      return const AppCard(
        child: Center(child: Text('No data available')),
      );
    }

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
          // Header with icon and unit
          _SensorHeader(sensorType: sensorType),
          AppSpacing.verticalGapMd,
          // Main value display
          _SensorValueDisplay(
            sensorType: sensorType,
            value: sensorData.value,
          ),
          AppSpacing.verticalGapMd,
          // Visualization
          _SensorVisualization(
            sensorType: sensorType,
            value: sensorData.value,
          ),
        ],
      ),
    );
  }
}

/// Header section with icon and unit label
class _SensorHeader extends StatelessWidget {
  final SensorType sensorType;

  const _SensorHeader({required this.sensorType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final (iconColor, backgroundColor) = _getSensorColors(sensorType, isDark);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: AppSpacing.paddingSm,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getSensorIcon(sensorType),
            color: iconColor,
            size: 24,
          ),
        ),
        Text(
          sensorType.unit,
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

/// Main value display with large text
class _SensorValueDisplay extends StatelessWidget {
  final SensorType sensorType;
  final double value;

  const _SensorValueDisplay({
    required this.sensorType,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _formatValue(sensorType, value),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          sensorType.displayName,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/// Mini visualization based on sensor type
class _SensorVisualization extends StatelessWidget {
  final SensorType sensorType;
  final double value;

  const _SensorVisualization({
    required this.sensorType,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return switch (sensorType) {
      SensorType.heartRate => _HeartRateVisualization(value: value),
      SensorType.temperature => _TemperatureVisualization(value: value),
      SensorType.battery => _BatteryVisualization(value: value),
    };
  }
}

/// Heart rate bar chart visualization
class _HeartRateVisualization extends StatelessWidget {
  final double value;

  const _HeartRateVisualization({required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Generate 6 bars with varying heights based on value
    final bars = List.generate(6, (index) {
      final baseHeight = 0.3 + (0.7 * (index / 5));
      final randomVariation = 0.8 + (0.4 * (value.abs() % 10) / 10);
      return baseHeight * randomVariation;
    });
    
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars
            .asMap()
            .entries
            .map((entry) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      height: 32 * entry.value,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withOpacity(0.8),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

/// Temperature waveform visualization
class _TemperatureVisualization extends StatelessWidget {
  final double value;

  const _TemperatureVisualization({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF97316).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomPaint(
        painter: _WaveformPainter(
          value: value,
          color: const Color(0xFFF97316),
        ),
      ),
    );
  }
}

/// Battery level progress bar
class _BatteryVisualization extends StatelessWidget {
  final double value;

  const _BatteryVisualization({required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF232948) : Colors.grey[200],
        borderRadius: BorderRadius.circular(4),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            // Progress fill
            Container(
              width: constraints.maxWidth * (value / 100),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for waveform visualization
class _WaveformPainter extends CustomPainter {
  final double value;
  final Color color;

  _WaveformPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    // Generate waveform points
    path.moveTo(0, size.height / 2);
    
    for (int i = 1; i <= 50; i++) {
      final x = (size.width / 50) * i;
      final y = size.height / 2 +
          (size.height / 3) *
              math.sin((i / 50) * 6.28 * 3 + (value / 100) * 6.28);
      path.lineTo(x, y);
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Helper methods
(Color, Color) _getSensorColors(SensorType type, bool isDark) {
  return switch (type) {
    SensorType.heartRate => (
        const Color(0xFFEF4444),
        const Color(0xFFEF4444).withOpacity(0.1),
      ),
    SensorType.temperature => (
        const Color(0xFFF97316),
        const Color(0xFFF97316).withOpacity(0.1),
      ),
    SensorType.battery => (
        const Color(0xFF10B981),
        const Color(0xFF10B981).withOpacity(0.1),
      ),
  };
}

IconData _getSensorIcon(SensorType type) {
  return switch (type) {
    SensorType.heartRate => Icons.favorite,
    SensorType.temperature => Icons.device_thermostat,
    SensorType.battery => Icons.battery_charging_full,
  };
}

String _formatValue(SensorType type, double value) {
  return switch (type) {
    SensorType.heartRate => value.toInt().toString(),
    SensorType.temperature => '${value.toStringAsFixed(1)}°',
    SensorType.battery => '${value.toInt()}%',
  };
}