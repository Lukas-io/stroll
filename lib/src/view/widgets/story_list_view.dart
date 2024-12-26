import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/view/widgets/percentage_arc.dart';

import '../../model/story_model.dart';
import '../screens/story_screen.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3.5 + 10,
      child: ListView.separated(
        itemCount: stories.length,
        scrollDirection: Axis.horizontal,
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

class StoryBoxWidget extends StatefulWidget {
  final StoryModel story;

  const StoryBoxWidget({super.key, required this.story});

  @override
  State<StoryBoxWidget> createState() => _StoryBoxWidgetState();
}

class _StoryBoxWidgetState extends State<StoryBoxWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: 150.ms,
    )..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1 - (_controller.value * 0.05),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: GestureDetector(
          onTapDown: (pointer) {
            _controller.forward();
          },
          onTapUp: (pointer) {
            _controller.reverse();
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => StoryScreen(
                  story: widget.story,
                  tag: widget.story.name,
                ),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Hero(
            tag: widget.story.name,
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset(widget.story.decorationImage).image,
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: greyColor.withOpacity(.5),
                      radius: 18.0,
                      child: PercentageArc(
                        centerText: widget.story.timeLeft,
                        urgent: widget.story.urgent,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      widget.story.name,
                      style: context.textTheme.titleMedium?.copyWith(
                          color: whiteTextColor, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "${widget.story.question}\n\n",
                      // To give the widget preferred height
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
          ),
        ),
      ),
    );
  }
}
