import 'package:flutter/material.dart';
import 'package:stroll/src/constants/colors.dart';
import 'dart:math';

import 'package:stroll/src/utils/extensions.dart';

class PercentageArc extends StatelessWidget {
  final String centerText;
  final bool urgent;

  const PercentageArc({
    super.key,
    required this.centerText,
    required this.urgent,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ArcPainter(
        percentage: urgent ? 0.12 : 0.6,
        arcColor: urgent ? Colors.red : whiteTextColor,
        backgroundColor: backgroundColor,
      ),
      child: Center(
        child: Text(
          centerText,
          style: context.textTheme.bodySmall?.copyWith(
              color: urgent ? Colors.red : whiteTextColor,
              fontSize: 11,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double percentage;
  final Color arcColor;
  final Color backgroundColor;

  _ArcPainter({
    required this.percentage,
    required this.arcColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 3.0;
    final Rect rect = Offset.zero & size;

    // Draw arc for percentage
    final Paint arcPaint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    final double sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
        rect.deflate(strokeWidth / 2), -pi / 2, sweepAngle, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
