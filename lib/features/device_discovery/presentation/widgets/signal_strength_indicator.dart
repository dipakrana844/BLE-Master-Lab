import 'package:flutter/material.dart';
import '../../domain/entities/device.dart';

/// A reusable widget for displaying signal strength with visual bars and percentage
class SignalStrengthIndicator extends StatelessWidget {
  final Device device;
  final SignalStrengthIndicatorStyle style;

  const SignalStrengthIndicator({
    super.key,
    required this.device,
    this.style = SignalStrengthIndicatorStyle.compact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return switch (style) {
      SignalStrengthIndicatorStyle.compact => _buildCompactIndicator(context, isDark),
      SignalStrengthIndicatorStyle.detailed => _buildDetailedIndicator(context, isDark),
      SignalStrengthIndicatorStyle.barOnly => _buildBarOnlyIndicator(context, isDark),
    };
  }

  /// Compact version with bars and percentage
  Widget _buildCompactIndicator(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // RSSI value
        Text(
          '${device.rssi} dBm',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 4),
        // Signal bars and percentage
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSignalBars(context, isDark),
            const SizedBox(width: 8),
            Text(
              '${device.signalPercentage.round()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  /// Detailed version with label and description
  Widget _buildDetailedIndicator(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Signal Strength',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${device.rssi} dBm',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _buildProgressBar(context, isDark),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              device.signalStrength.displayName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: device.signalStrength.color,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              '${device.signalPercentage.round()}%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  /// Bar-only version for minimal display
  Widget _buildBarOnlyIndicator(BuildContext context, bool isDark) {
    return _buildSignalBars(context, isDark);
  }

  /// Build signal strength bars visualization
  Widget _buildSignalBars(BuildContext context, bool isDark) {
    final bars = <Widget>[];
    const barCount = 4;
    
    for (int i = 0; i < barCount; i++) {
      final isActive = _isBarActive(i, barCount);
      final barHeight = _getBarHeight(i, barCount);
      final barColor = isActive 
          ? device.signalStrength.color 
          : (isDark ? Colors.grey[700] : Colors.grey[300]);
      
      bars.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 4,
          height: barHeight,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
      
      // Add spacing between bars (except after last bar)
      if (i < barCount - 1) {
        bars.add(const SizedBox(width: 2));
      }
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: bars,
    );
  }

  /// Build progress bar visualization
  Widget _buildProgressBar(BuildContext context, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: device.signalPercentage / 100,
        backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
        valueColor: AlwaysStoppedAnimation<Color>(device.signalStrength.color),
        minHeight: 6,
      ),
    );
  }

  /// Determine if a bar should be active based on signal strength
  bool _isBarActive(int barIndex, int totalBars) {
    final percentage = device.signalPercentage;
    final threshold = (barIndex + 1) * (100 / totalBars);
    return percentage >= threshold - (100 / totalBars);
  }

  /// Get height for a specific bar
  double _getBarHeight(int barIndex, int totalBars) {
    // Bar heights: 4, 8, 12, 16 pixels
    return 4.0 + (barIndex * 4.0);
  }
}

/// Style variants for the signal strength indicator
enum SignalStrengthIndicatorStyle {
  /// Compact display with bars and percentage
  compact,
  
  /// Detailed display with labels and progress bar
  detailed,
  
  /// Minimal bar-only display
  barOnly,
}