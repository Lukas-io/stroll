import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/utils/extensions.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String? image;
  final Object tag;
  final String? text;
  final double? fontSize;
  final Color backGroundColor;
  final double radius;

  const ProfileAvatar({
    super.key,
    this.image,
    this.backGroundColor = secondaryCardColor,
    this.radius = 30.0,
    this.fontSize,
    this.text,
    this.tag = "null",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: radius * 4 / 3,
          top: radius / 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: backGroundColor,
            ),
            // width: 300,
            padding: EdgeInsets.only(
                left: radius * 6 / 5, right: 8.0, top: 2, bottom: 2),
            child: Text(
              text ?? "Angelina, 28",
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: fontSize),
            ).animate().then(delay: 2.seconds).shimmer(
                color: primaryColor, duration: 2000.ms, curve: Curves.easeOut),
          ).animate().fadeIn(
              duration: 900.milliseconds,
              delay: 1000.milliseconds,
              curve: Curves.fastOutSlowIn),
        ),
        Hero(
          tag: tag,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: backGroundColor, width: 4.0),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: CircleAvatar(
                backgroundImage: Image.asset(
                  image ?? imageAngelina,
                ).image,
                radius: radius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
