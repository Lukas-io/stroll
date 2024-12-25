import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/constants/assets.dart';
import 'package:stroll/src/view/widgets/flame_body.dart';

import '../widgets/strollBonfireWidget.dart';

class FlameScreen extends StatelessWidget {
  const FlameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            imageFlame,
            height: MediaQuery.sizeOf(context).height / 3 * 2,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          )
              .animate()
              .fadeIn(duration: 1400.milliseconds, curve: Curves.ease)
              .blur(
                  begin: const Offset(5, 5),
                  end: Offset.zero,
                  duration: 800.milliseconds),
          Positioned(
            top: 0.0,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 2,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(.4),
                  ],
                  stops: const [0.1, 1],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Expanded(child: StrollBonfireWidget()),
                const FlameBody()
                    .animate()
                    .moveY(begin: 30, curve: Curves.fastOutSlowIn),
              ],
            ),
          )
        ],
      ),
    );
  }
}
