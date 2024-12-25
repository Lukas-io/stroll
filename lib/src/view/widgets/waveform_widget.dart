import 'dart:math';

import 'package:flutter/material.dart';

class WaveformWidget extends StatelessWidget {
  final int waves;
  final double width;
  final double height;
  final bool quietBeginning;
  final Color color;

  const WaveformWidget(
      {super.key,
      required this.waves,
      required this.width,
      required this.height,
      this.quietBeginning = false,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Row(
        children: List.generate(waves, (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
              width: width,
              color: color,
              height: Random().nextDouble() * height / 2 + height / 3,
            ),
          );
        }),
      ),
    );
  }
}
