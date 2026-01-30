import 'package:flutter/material.dart';

enum SignalStrength { poor, fair, good, excellent }

class SignalStrengthBadge extends StatelessWidget {
  final SignalStrength strength;

  const SignalStrengthBadge({
    super.key,
    required this.strength,
  });

  String _getText(SignalStrength strength) {
    switch (strength) {
      case SignalStrength.poor:
        return 'Poor';
      case SignalStrength.fair:
        return 'Fair';
      case SignalStrength.good:
        return 'Good';
      case SignalStrength.excellent:
        return 'Excellent';
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (strength) {
      case SignalStrength.poor:
        return Colors.red.withOpacity(0.1);
      case SignalStrength.fair:
        return Colors.orange.withOpacity(0.1);
      case SignalStrength.good:
        return Colors.blue.withOpacity(0.1);
      case SignalStrength.excellent:
        return Colors.green.withOpacity(0.1);
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (strength) {
      case SignalStrength.poor:
        return Colors.red;
      case SignalStrength.fair:
        return Colors.orange;
      case SignalStrength.good:
        return Colors.blue;
      case SignalStrength.excellent:
        return Colors.green;
    }
  }

  IconData _getIcon() {
    switch (strength) {
      case SignalStrength.poor:
        return Icons.signal_cellular_alt_outlined;
      case SignalStrength.fair:
        return Icons.signal_cellular_alt_2_bar_outlined;
      case SignalStrength.good:
        return Icons.signal_cellular_alt_1_bar_outlined;
      case SignalStrength.excellent:
        return Icons.signal_cellular_alt_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            color: _getTextColor(context),
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            _getText(strength),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getTextColor(context),
            ),
          ),
        ],
      ),
    );
  }
}