import 'package:flutter/material.dart';

/// A reusable custom chart widget built purely with Flutter (no packages).
/// Supports simple line or bar visualization using CustomPaint.
///
/// Example:
/// ```dart
/// SkChart(
///   title: "Sales Overview",
///   values: [20, 80, 50, 100, 40, 70, 90],
///   color: Colors.blue,
///   chartType: ChartType.bar,
/// )
/// ```
class SkChart extends StatelessWidget {
  final String title;
  final List<double> values;
  final Color color;
  final double height;
  final ChartType chartType;
  final Color backgroundColor;

  const SkChart({
    super.key,
    required this.title,
    required this.values,
    this.color = Colors.blue,
    this.height = 220,
    this.chartType = ChartType.bar,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final double maxValue = values.isEmpty
        ? 0
        : values.reduce((a, b) => a > b ? a : b);

    return Card(
      color: backgroundColor,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: height,
              child: CustomPaint(
                painter: chartType == ChartType.bar
                    ? _BarChartPainter(values, color, maxValue)
                    : _LineChartPainter(values, color, maxValue),
                size: Size.infinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ChartType { bar, line }

/// Painter for Bar Chart
class _BarChartPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final double maxValue;

  _BarChartPainter(this.values, this.color, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final double barWidth = size.width / (values.length * 1.5);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < values.length; i++) {
      final double x = (i * barWidth * 1.5) + (barWidth / 2);
      final double barHeight = maxValue == 0
          ? 0
          : (values[i] / maxValue) * size.height;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, size.height - barHeight, barWidth, barHeight),
        const Radius.circular(4),
      );

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) =>
      oldDelegate.values != values;
}

/// Painter for Line Chart
class _LineChartPainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final double maxValue;

  _LineChartPainter(this.values, this.color, this.maxValue);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    final double dxStep = values.length > 1
        ? size.width / (values.length - 1)
        : size.width;

    for (int i = 0; i < values.length; i++) {
      final double x = i * dxStep;
      final double y =
          size.height -
          (maxValue == 0 ? 0 : (values[i] / maxValue) * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Draw dots
    final dotPaint = Paint()..color = color;
    for (int i = 0; i < values.length; i++) {
      final double x = i * dxStep;
      final double y =
          size.height -
          (maxValue == 0 ? 0 : (values[i] / maxValue) * size.height);
      canvas.drawCircle(Offset(x, y), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) =>
      oldDelegate.values != values;
}
