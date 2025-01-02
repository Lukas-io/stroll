import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stroll/src/utils/extensions.dart';
import 'package:stroll/src/view/widgets/chat/question_answer_widget.dart';
import 'package:stroll/src/view/widgets/chat/simulated_waveform_widget.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../utils/hero_page_route.dart';
import '../../../model/chat_model.dart';

class StrollVoiceQuestion extends StatelessWidget {
  final ChatModel chat;
  final bool mine;
  final Function() onTap;
  final Function? onPop;

  const StrollVoiceQuestion({
    super.key,
    required this.chat,
    this.mine = false,
    required this.onTap,
    this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            HeroDialogRoute(
              builder: (BuildContext context) => QuestionAnswerWidget(
                chat: chat,
                mine: mine,
                onPop: () {
                  if (onPop != null) onPop!();
                },
              ),
            ));

        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: mine ? cardColor : secondaryCardColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  mine
                      ? "What is your favourite time of the day?"
                      : chat.question,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  "\n",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "image:${mine ? "mine" : chat.name}",
                  child: CircleAvatar(
                    backgroundImage:
                        Image.asset(mine ? imageAngelina : chat.image).image,
                    radius: 12,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  mine
                      ? '"Mine is definitely the peace in the morning."'
                      : chat.answer,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: context.textTheme.bodySmall?.copyWith(
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
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      Image.asset(mine ? chat.image : imageAngelina).image,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const SimulatedWaveformWidget(
                          waves: 40,
                          width: 1.4,
                          height: 40,
                          quietBeginning: true,
                          padding: EdgeInsets.zero,
                          color: greyColor),
                      Positioned(
                          bottom: -20.0,
                          right: 0.0,
                          child: Text(
                            "00:38",
                            style: context.textTheme.bodySmall?.copyWith(
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
                    child: Icon(CupertinoIcons.play_fill),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
