import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/utils/extensions.dart';

import '../../../constants/colors.dart';

class StrollBonfireWidget extends StatelessWidget {
  const StrollBonfireWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Stroll Bonfire",
              style: context.textTheme.displaySmall?.copyWith(
                  color: purpleTextColor,
                  shadows: const [
                    BoxShadow(
                        color: backgroundColor,
                        blurRadius: 10,
                        spreadRadius: 3),
                    BoxShadow(
                        color: purpleTextColor, blurRadius: 10, spreadRadius: 4)
                  ],
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 30.0,
              color: whiteTextColor.withOpacity(.8),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer_outlined,
            ),
            Text(
              "22hr 00m",
              style: context.textTheme.bodyMedium?.copyWith(
                  color: whiteTextColor,
                  shadows: const [
                    BoxShadow(
                        color: backgroundColor,
                        blurRadius: 10,
                        spreadRadius: 3),
                    BoxShadow(
                        color: whiteTextColor, blurRadius: 10, spreadRadius: 4)
                  ],
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 12.0,
            ),
            const Icon(
              CupertinoIcons.person,
            ),
            Text(
              "103",
              style: context.textTheme.bodyMedium?.copyWith(
                  color: whiteTextColor,
                  shadows: const [
                    BoxShadow(
                        color: backgroundColor,
                        blurRadius: 10,
                        spreadRadius: 3),
                    BoxShadow(
                        color: whiteTextColor, blurRadius: 10, spreadRadius: 4)
                  ],
                  fontWeight: FontWeight.w600),
            ),
          ],
        )
            .animate()
            .then(delay: 400.ms)
            .moveY(begin: 10, duration: 500.ms, curve: Curves.easeOut)
            .fadeIn(delay: 400.ms, duration: 600.ms, curve: Curves.easeOut),
      ],
    );
  }
}
