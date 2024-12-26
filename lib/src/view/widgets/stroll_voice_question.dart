import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/view/widgets/waveform_widget.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../model/chat_model.dart';

class StrollVoiceQuestion extends StatelessWidget {
  const StrollVoiceQuestion({
    super.key,
    required this.chat,
    this.mine = false,
  });

  final ChatModel chat;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              CircleAvatar(
                backgroundImage:
                    Image.asset(mine ? imageAngelina : chat.image).image,
                radius: 12,
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
                    const WaveformWidget(
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
              const CircleAvatar(
                backgroundColor: primaryColor,
                child: Icon(CupertinoIcons.play_fill),
              )
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
