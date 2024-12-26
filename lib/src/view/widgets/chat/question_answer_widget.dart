import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/constants/assets.dart';
import 'package:stroll/src/utils/extensions.dart';
import 'package:stroll/src/view/widgets/flame/profile_avatar.dart';
import 'package:stroll/src/view/widgets/chat/waveform_widget.dart';

import '../../../constants/colors.dart';
import '../../../model/chat_model.dart';

class QuestionAnswerWidget extends StatelessWidget {
  final ChatModel chat;
  final bool mine;
  final Function onPop;

  const QuestionAnswerWidget(
      {super.key, required this.chat, required this.mine, required this.onPop});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popped) {
        onPop();
      },
      child: GestureDetector(
        onPanUpdate: (pointer) => Navigator.pop(context),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 4 / 7,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                children: [
                  Image.asset(
                    mine ? imageAngelina : chat.image,
                    fit: BoxFit.cover,
                    height: MediaQuery.sizeOf(context).height * 4 / 7,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          stops: [
                            0.1,
                            0.4
                          ]),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          stops: const [
                            0,
                            0.7
                          ]),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: 110.0,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                ProfileAvatar(
                                  text:
                                      "${mine ? "Angelina" : chat.name}'s Question",
                                  image: mine ? imageAngelina : chat.image,
                                  tag: "image:${mine ? "mine" : chat.name}",
                                  fontSize: 12.0,
                                  backGroundColor:
                                      backgroundColor.withOpacity(.8),
                                  radius: 25,
                                ).animate().moveY(
                                    begin: 35,
                                    delay: 1000.milliseconds,
                                    duration: 600.milliseconds,
                                    curve: Curves.fastOutSlowIn),
                                Positioned(
                                  top: 35.0,
                                  left: 70.0,
                                  child: SizedBox(
                                    width: MediaQuery.sizeOf(context).width -
                                        80 -
                                        16,
                                    child: Text(
                                      mine
                                          ? "What is your favourite time of the day?"
                                          : chat.question,
                                      maxLines: 2,
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            mine
                                ? '"Mine is definitely the peace in the morning."'
                                : chat.answer,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: purpleTextColor,
                              shadows: const [
                                BoxShadow(
                                    color: whiteTextColor,
                                    blurRadius: 0.3,
                                    spreadRadius: 1),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      const WaveformWidget(
                                          waves: 45,
                                          width: 2,
                                          quietBeginning: true,
                                          height: 60,
                                          padding: EdgeInsets.zero,
                                          animate: true,
                                          color: greyColor),
                                      Positioned(
                                          bottom: -20.0,
                                          right: 0.0,
                                          child: Text(
                                            "00:38",
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              color: greyColor,
                                              shadows: const [
                                                BoxShadow(
                                                    color: whiteTextColor,
                                                    blurRadius: 0.3,
                                                    spreadRadius: 1),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Hero(
                                  tag: "play:${mine ? "mine" : chat.name}",
                                  child: const CircleAvatar(
                                    backgroundColor: primaryColor,
                                    radius: 22.0,
                                    child: Icon(
                                      CupertinoIcons.play_fill,
                                      size: 28.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          )
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fade(duration: 600.milliseconds, curve: Curves.easeOut),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
