import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/utils/extensions.dart';
import 'package:stroll/src/view/widgets/flame/profile_avatar.dart';

import '../../../constants/colors.dart';
import '../onboarding/options_widget.dart';

class FlameBody extends StatelessWidget {
  const FlameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.transparent,
            ],
            stops: [
              0.8,
              1
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 36.0, left: 24.0, right: 24.0, bottom: 12.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 110.0,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  const ProfileAvatar().animate().moveY(
                      begin: 30,
                      delay: 1000.milliseconds,
                      duration: 600.milliseconds,
                      curve: Curves.fastOutSlowIn),
                  Positioned(
                    top: 40.0,
                    left: 75.0,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 80 - 38,
                      child: Text(
                        "What is your favorite time of the day?",
                        maxLines: 2,
                        style: context.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700, height: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '"Mine is definitely the peace in the morning."',
              style: context.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: purpleTextColor,
                shadows: const [
                  BoxShadow(
                      color: whiteTextColor, blurRadius: 0.3, spreadRadius: 1),
                ],
              ),
            ),
            const OptionsWidget(
              options: [
                "The peace in the early mornings",
                "The magical golden hours",
                "Wind-down time after dinners",
                "The serenity past midnight",
              ],
              paddingVertical: 12.0,
              optionColor: cardColor,
              showBorders: false,
              numbering: ["A", "B", "C", "D"],
            ),
            Row(
              children: [
                Text(
                  "Pick your option.\nSee who has a similar mind.",
                  style: context.textTheme.bodyMedium?.copyWith(
                    height: 1,
                  ),
                ),
                const Spacer(),
                IconButton.outlined(
                  onPressed: () => {},
                  icon: const Icon(
                    CupertinoIcons.mic_fill,
                    size: 35.0,
                    color: primaryColor,
                  ),
                  style: IconButton.styleFrom(
                      side: const BorderSide(width: 2, color: primaryColor)),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 35.0,
                    color: backgroundColor,
                  ),
                  style: IconButton.styleFrom(
                    side: const BorderSide(width: 2, color: primaryColor),
                    backgroundColor: primaryColor,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
