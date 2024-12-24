import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';

import '../constants/colors.dart';
import 'options_widget.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0.0,
          child: Container(
            height: MediaQuery.sizeOf(context).height / 6,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [
                    0.2,
                    1
                  ]),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            height: MediaQuery.sizeOf(context).height / 6,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Opacity(
            opacity: .35,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 4.5,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                    center: Alignment.bottomCenter, // Center of the gradient
                    radius: 2,
                    colors: [
                      Colors.deepPurple.shade900.withOpacity(.6),
                      Colors.black
                    ],
                    stops: [
                      -1,
                      .6
                    ]),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0),
          child: Column(
            children: [
              Text(
                "Use a tag to describe what you are looking for.",
                style: context.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const OptionsWidget(options: [
                "Relationship",
                "Casual",
                "Friendship",
                "Open to all",
              ]),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: secondaryCardColor.withOpacity(.6),
                    borderRadius: BorderRadius.circular(12.0)),
                child: Text(
                  "Deep talks & coffee dates.",
                  style: context.textTheme.bodyLarge?.apply(
                      color: greyColor.withOpacity(.6),
                      fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "🚶‍♂️BeReal.",
                      style: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    IconButton.outlined(
                      onPressed: null,
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 35.0,
                        color: greyColor,
                      ),
                      style: IconButton.styleFrom(
                          side: const BorderSide(width: 2, color: greyColor)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
