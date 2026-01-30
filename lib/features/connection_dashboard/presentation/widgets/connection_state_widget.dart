import 'package:flutter/material.dart';

enum ConnectionStateType { completed, active, pending }

class ConnectionStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final ConnectionStateType state;
  final bool showProgressIndicator;

  const ConnectionStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.state,
    this.showProgressIndicator = false,
  });

  Color _getCircleBackgroundColor(BuildContext context) {
    switch (state) {
      case ConnectionStateType.completed:
        return Colors.green;
      case ConnectionStateType.active:
        return Theme.of(context).primaryColor;
      case ConnectionStateType.pending:
        return Theme.of(context).disabledColor;
    }
  }

  IconData _getIconData() {
    switch (state) {
      case ConnectionStateType.completed:
        return Icons.check;
      case ConnectionStateType.active:
        return Icons.bluetooth_connected;
      case ConnectionStateType.pending:
        return Icons.lock;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (state) {
      case ConnectionStateType.completed:
        return Colors.green;
      case ConnectionStateType.active:
        return Theme.of(context).primaryColor;
      case ConnectionStateType.pending:
        return Theme.of(context).disabledColor.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getCircleBackgroundColor(context),
            borderRadius: BorderRadius.circular(20),
            boxShadow: state == ConnectionStateType.active
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 0,
                    ),
                  ]
                : state == ConnectionStateType.completed
                    ? [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
          ),
          child: Center(
            child: showProgressIndicator
                ? Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )
                : Icon(
                    _getIconData(),
                    color: Colors.white,
                    size: 20,
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: state == ConnectionStateType.active
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : state == ConnectionStateType.pending
                      ? Theme.of(context).disabledColor.withOpacity(0.05)
                      : null,
              border: Border.all(
                color: state == ConnectionStateType.active
                    ? Theme.of(context).primaryColor.withOpacity(0.3)
                    : Theme.of(context).dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: state == ConnectionStateType.pending
                        ? Theme.of(context).disabledColor.withOpacity(0.7)
                        : Theme.of(context).disabledColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}