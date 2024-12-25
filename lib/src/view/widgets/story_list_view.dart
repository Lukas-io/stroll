import 'package:flutter/material.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/view/widgets/percentage_arc.dart';

import '../../model/story_model.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3.5 + 10,
      child: ListView.separated(
        itemCount: stories.length,
        scrollDirection: Axis.horizontal,
        // physics: RangeMaintainingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return StoryBoxWidget(story: stories[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 16.0,
          );
        },
      ),
    );
  }
}

class StoryBoxWidget extends StatelessWidget {
  final StoryModel story;

  const StoryBoxWidget({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width / 2.5,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset(story.decorationImage).image,
              fit: BoxFit.cover),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                backgroundColor,
              ],
              stops: [0.1, 0.5],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: greyColor.withOpacity(.5),
                radius: 18.0,
                child: PercentageArc(
                  centerText: story.timeLeft,
                  urgent: story.urgent,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                story.name,
                style: context.textTheme.titleMedium?.copyWith(
                    color: whiteTextColor, fontWeight: FontWeight.w700),
              ),
              Text(
                "${story.question}\n\n", // To give the widget preferred height
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textHeightBehavior: const TextHeightBehavior(
                    applyHeightToLastDescent: false,
                    applyHeightToFirstAscent: false),
                style: context.textTheme.bodyMedium?.copyWith(
                    color: greyTextColor.withOpacity(.8),
                    fontSize: 13,
                    height: 1,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
