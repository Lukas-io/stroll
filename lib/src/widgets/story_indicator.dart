import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/colors.dart';

class StoryIndicator extends StatefulWidget {
  const StoryIndicator({super.key});

  @override
  State<StoryIndicator> createState() => _StoryIndicatorState();
}

class _StoryIndicatorState extends State<StoryIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 8.seconds)
      ..addListener(() => setState(() {}))
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: greyColor.withOpacity(.5),
          ),
          height: 5.0,
        ),
        Container(
          width: _controller.value * MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.deepPurple.withOpacity(.9),
          ),
          height: 5.0,
        )
      ],
    );
  }
}
