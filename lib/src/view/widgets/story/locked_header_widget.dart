import 'package:flutter/material.dart';
import 'package:stroll/src/utils/extensions.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';

class LockedHeaderWidget extends StatelessWidget {
  const LockedHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      imageFlame,
      imageAmanda,
      imageAngelina,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Locked",
                  style: context.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "Make your move, they are waiting. 🎵",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: greyTextColor),
                ),
              ],
            ),
          ),
          SizedBox(
            // diameter x number of items(slashed)
            width: (1 + images.length / 2) * 24.0,
            height: 24, // diameter
            child: Stack(
              children: List.generate(images.length + 1, (index) {
                if (index == images.length) {
                  return Positioned(
                    right: 10 * index.toDouble(),
                    bottom: 0.0,
                    child: CircleAvatar(
                      backgroundColor: cardColor,
                      radius: 12.0,
                      child: Text(
                        "+5",
                        style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700, color: whiteTextColor),
                      ),
                    ),
                  );
                }

                final image = images[index];
                return Positioned(
                  right: 10 * index.toDouble(),
                  bottom: 0.0,
                  child: CircleAvatar(
                    backgroundImage: Image.asset(image).image,
                    radius: 12.0,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
