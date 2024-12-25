import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constants/assets.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // 4seconds
    Timer(4.seconds, () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        imageSplashScreen,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.cover,
      ).animate().fadeIn(duration: 800.milliseconds).blur(
            begin: const Offset(10, 10),
            end: const Offset(4, 4),
          ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to",
              style: context.textTheme.displayMedium,
            ).animate().fadeIn(duration: 1000.milliseconds),
            Text(
              "Stroll.",
              style: context.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            )
                .animate()
                .then(delay: 1000.milliseconds)
                .fadeIn(duration: 1500.milliseconds)
                .blur(
                  begin: const Offset(10, 10),
                  end: Offset.zero,
                )
                .then()
                .shimmer(color: primaryColor, duration: 800.milliseconds),
          ],
        ),
      ),
    ]);
  }
}
