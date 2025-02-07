import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/constants/assets.dart';
import 'package:stroll/src/view/widgets/flame/flame_body.dart';

import '../widgets/flame/stroll_bonfire_widget.dart';

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
                Expanded(
                  child: const StrollBonfireWidget()
                      .animate()
                      .then(delay: 200.ms)
                      .moveY(begin: 10, duration: 500.ms, curve: Curves.easeOut)
                      .fadeIn(
                          delay: 400.ms,
                          duration: 600.ms,
                          curve: Curves.easeOut),
                ),
                const FlameBody().animate().move(curve: Curves.fastOutSlowIn),
              ],
            ),
          )
        ],
      ),
    );
  }
}
