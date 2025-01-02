import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../constants/colors.dart';

class WaveformWidget extends StatelessWidget {
  final List<double> amplitude;
  final double width;
  final double height;
  final EdgeInsets? padding;
  final bool playerMode;
  final double position;

  const WaveformWidget({
    super.key,
    required this.amplitude,
    required this.width,
    required this.height,
    this.padding,
    this.playerMode = false,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Padding(
      padding: padding ?? const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: height,
        child: Row(
          children: [
            if (!playerMode)
              const Expanded(
                child: Divider(
                  color: greyColor,
                ),
              ),
            ...amplitude.map((amp) {
              index++;
              return Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Container(
                  width: width,
                  color: ((position * amplitude.length + 1).floor() > index)
                      ? primaryColor
                      : greyColor,
                  height: (amp * height).abs(),
                ).animate().scaleY(curve: Curves.easeOut, duration: 200.ms),
              );
            }),
          ],
        ),
      ),
    );
  }
}
