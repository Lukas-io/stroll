import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/model/story_model.dart';

import '../widgets/story_indicator.dart';
import '../widgets/stroll_question_widget.dart';

class StoryScreen extends StatelessWidget {
  final StoryModel story;
  final String tag;

  const StoryScreen({super.key, required this.story, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Hero(
          tag: tag,
          child: Image.asset(
            story.decorationImage,
            height: MediaQuery.sizeOf(context).height / 4 * 3,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: MediaQuery.sizeOf(context).height / 4 * 3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [
                Colors.transparent,
                backgroundColor.withOpacity(.3),
              ],
              stops: const [0.1, 0.8],
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: StoryIndicator(
                      color: whiteTextColor,
                      padding: EdgeInsets.zero,
                    )),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                        child: StoryIndicator(
                      active: false,
                      padding: EdgeInsets.zero,
                      color: whiteTextColor,
                    )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.adaptive.arrow_back,
                        color: whiteTextColor,
                        size: 30,
                      )),
                  Text(
                    story.name,
                    style: context.textTheme.titleLarge?.copyWith(
                        color: whiteTextColor, fontWeight: FontWeight.w700),
                  ),
                  const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        size: 30,
                        color: whiteTextColor,
                      )),
                ],
              ),
              const Spacer(),
              StrollQuestionWidget(story: story)
                  .animate()
                  .fade(duration: 800.ms)
                  .moveY(begin: 10)
            ],
          ),
        )
      ],
    ));
  }
}
