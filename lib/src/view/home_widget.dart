import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/constants/images.dart';

import '../widgets/onboarding_widget.dart';
import '../widgets/story_indicator.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            imageOnboarding,
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
          SafeArea(
            child: Column(
              children: [
                const Expanded(child: StoryIndicator()),
                const OnboardingBody()
                    .animate()
                    .moveY(begin: 30, curve: Curves.easeOut),
              ],
            ),
          )
        ],
      ),
    );
  }
}
