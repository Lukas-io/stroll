import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';

import '../../constants/colors.dart';

class MatchLikeTab extends StatelessWidget {
  const MatchLikeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: greyColor.withOpacity(.6),
              borderRadius: BorderRadius.circular(360.0)),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Text(
            "Matches",
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              // color: greyColor.withOpacity(.6),
              borderRadius: BorderRadius.circular(360.0)),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Text(
            "Likes",
            style: context.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600, color: greyTextColor),
          ),
        ),
        Container(
          decoration:
              const BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          padding: const EdgeInsets.all(6.0),
          child: Text(
            "4",
            style: context.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w700, color: whiteTextColor),
          ),
        ),
      ],
    );
  }
}
