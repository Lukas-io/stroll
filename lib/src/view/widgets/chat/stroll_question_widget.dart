import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/utils/extensions.dart';

import '../../../constants/colors.dart';
import '../../../model/story_model.dart';
import '../story/recording_widgets.dart';

class StrollQuestionWidget extends StatefulWidget {
  final StoryModel story;

  const StrollQuestionWidget({super.key, required this.story});

  @override
  State<StrollQuestionWidget> createState() => _StrollQuestionWidgetState();
}

class _StrollQuestionWidgetState extends State<StrollQuestionWidget> {
  Key _canvasKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            backgroundColor,
          ],
          stops: [0.1, 0.3],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: secondaryCardColor, width: 4.0),
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Image.asset(
                          widget.story.decorationImage,
                          height: 60.0,
                          width: 60.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 85.0,
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: -20.0,
                      child: Align(
                          // alignment: Alignment.bottomCenter,
                          child: Container(
                              // alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: secondaryCardColor.withOpacity(.8),
                              ),
                              // width: 300,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              child: Text(
                                "Stroll Question",
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ).animate().then(delay: 2.seconds).shimmer(
                                  color: primaryColor,
                                  duration: 1000.ms,
                                  curve: Curves.easeOut))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  widget.story.question,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  '"Mine is definitely the peace in the morning."',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: whiteTextColor,
                    shadows: const [
                      BoxShadow(
                          color: whiteTextColor,
                          blurRadius: 0.3,
                          spreadRadius: 1),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
              ],
            )
                .animate()
                .then(delay: 300.ms)
                .fadeIn(
                  duration: 700.ms,
                  curve: Curves.easeOut,
                )
                .moveY(
                  duration: 500.ms,
                  curve: Curves.easeOut,
                  begin: -8,
                  delay: 50.ms,
                )
                .scale(
                  begin: const Offset(0.9, 0.9),
                  duration: 500.ms,
                  curve: Curves.easeOut,
                  delay: 100.ms,
                ),
          ),
          RecordingWidgets(
            key: _canvasKey,
            onDelete: () => setState(() {
              // This will force Flutter to dispose the old widget
              // and create a completely new instance
              _canvasKey = UniqueKey();
            }),
          )
        ],
      ),
    );
  }
}
