import 'package:flutter/material.dart';

class RssiChartWidget extends StatelessWidget {
  final double currentValue;
  final List<double> history;

  const RssiChartWidget({
    super.key,
    required this.currentValue,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: const Size(double.infinity, 160),
        painter: _RssiChartPainter(
          history: history,
          primaryColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class _RssiChartPainter extends CustomPainter {
  final List<double> history;
  final Color primaryColor;

  _RssiChartPainter({
    required this.history,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          primaryColor.withOpacity(0.3),
          primaryColor.withOpacity(0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    if (history.isEmpty) return;

    // Normalize values to fit in the canvas
    final maxValue = 150.0;
    final minValue = 0.0;
    final range = maxValue - minValue;

    final points = <Offset>[];
    for (int i = 0; i < history.length; i++) {
      final x = (i / (history.length - 1)) * size.width;
      final normalizedValue = (maxValue - history[i]) / range;
      final y = normalizedValue * size.height;
      points.add(Offset(x, y));
    }

    // Draw filled area under the curve
    if (points.length > 1) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, gradientPaint);
    }

    // Draw the line
    if (points.length > 1) {
      final linePath = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(linePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}