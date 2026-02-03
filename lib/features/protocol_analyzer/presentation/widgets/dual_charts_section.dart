import 'package:flutter/material.dart';
import '../../../../core/widgets/app_card.dart';

/// Dual chart section showing latency and payload size metrics
class DualChartsSection extends StatelessWidget {
  const DualChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _LatencyChart(),
          SizedBox(height: 16),
          _PayloadSizeChart(),
        ],
      ),
    );
  }
}

class _LatencyChart extends StatelessWidget {
  const _LatencyChart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      padding: const EdgeInsets.all(16),
      color: isDark ? const Color(0xFF251630) : Colors.white,
      borderColor: isDark ? null : theme.dividerColor.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Latency (ms)',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isDark ? const Color(0xFFB292C9) : theme.disabledColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '45ms',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.red,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '2ms',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: CustomPaint(
              painter: _LatencyChartPainter(
                color: theme.colorScheme.primary,
                isDark: isDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayloadSizeChart extends StatelessWidget {
  const _PayloadSizeChart();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      padding: const EdgeInsets.all(16),
      color: isDark ? const Color(0xFF251630) : Colors.white,
      borderColor: isDark ? null : theme.dividerColor.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payload Size (bytes)',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isDark ? const Color(0xFFB292C9) : theme.disabledColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '128B',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF00F5D4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'STABLE',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF00F5D4),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: CustomPaint(
              painter: _PayloadSizeChartPainter(
                color: const Color(0xFF00F5D4),
                isDark: isDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for latency chart (fluctuating line)
class _LatencyChartPainter extends CustomPainter {
  final Color color;
  final bool isDark;

  _LatencyChartPainter({required this.color, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Simulate fluctuating latency data
    path.moveTo(0, size.height * 0.7);
    path.cubicTo(
      size.width * 0.1, size.height * 0.7,
      size.width * 0.1, size.height * 0.15,
      size.width * 0.2, size.height * 0.15,
    );
    path.cubicTo(
      size.width * 0.3, size.height * 0.15,
      size.width * 0.3, size.height * 0.3,
      size.width * 0.4, size.height * 0.3,
    );
    path.cubicTo(
      size.width * 0.5, size.height * 0.3,
      size.width * 0.5, size.height * 0.6,
      size.width * 0.6, size.height * 0.6,
    );
    path.cubicTo(
      size.width * 0.7, size.height * 0.6,
      size.width * 0.7, size.height * 0.05,
      size.width * 0.8, size.height * 0.05,
    );
    path.cubicTo(
      size.width * 0.9, size.height * 0.05,
      size.width * 0.9, size.height * 0.55,
      size.width, size.height * 0.55,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for payload size chart (stable line)
class _PayloadSizeChartPainter extends CustomPainter {
  final Color color;
  final bool isDark;

  _PayloadSizeChartPainter({required this.color, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    
    // Simulate stable payload size data
    final yPosition = size.height * 0.5;
    path.moveTo(0, yPosition);
    path.lineTo(size.width, yPosition);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}