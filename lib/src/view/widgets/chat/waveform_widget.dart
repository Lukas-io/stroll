import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WaveformWidget extends StatelessWidget {
  final int waves;
  final double width;
  final double height;
  final bool quietBeginning;
  final Color color;
  final EdgeInsets? padding;
  final bool animate;

  const WaveformWidget(
      {super.key,
      required this.waves,
      required this.width,
      required this.height,
      this.quietBeginning = false,
      this.animate = false,
      this.padding,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 8.0),
      child: Row(
        children: List.generate(waves, (index) {
          double multiplier = 1;
          if (index < 10) {
            multiplier = 1 / (10 - index);
          }

          double waveHeight =
              (Random().nextDouble() * height / 2 + height / 3) * multiplier;

          return Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
              width: width,
              color: color,
              height: waveHeight,
            ).animate().scaleY(
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: animate ? 1500.ms : 0.ms),
          );
        }),
      ),
    );
  }
}
