import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/view/widgets/waveform_widget.dart';

import '../../constants/colors.dart';
import '../../model/chat_model.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel chat;

  const ChatWidget({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    const double verticalPadding = 16.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.asset(chat.image).image,
          radius: 28.0,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: verticalPadding),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                chat.name,
                                style: context.textTheme.titleLarge?.copyWith(
                                    color: whiteTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(360.0)),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Text(
                                  chat.tag,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                      letterSpacing: -.3),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            children: [
                              if (chat.voice)
                                const Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    CupertinoIcons.mic_solid,
                                    size: 18.0,
                                    color: purpleTextColor,
                                  ),
                                ),
                              if (chat.voice)
                                const WaveformWidget(
                                    waves: 6,
                                    width: 1.8,
                                    height: 20.0,
                                    color: purpleTextColor),
                              Expanded(
                                child: Text(
                                  (chat.draft ? "Draft: " : "") + chat.message,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                          color: chat.voice
                                              ? purpleTextColor
                                              : whiteTextColor,
                                          fontWeight: chat.draft || chat.voice
                                              ? null
                                              : FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "",
                          style: context.textTheme.titleLarge?.copyWith(
                              color: whiteTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0),
                        ),
                        Text(
                          chat.dateTime,
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: greyTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: verticalPadding,
                ),
                Container(
                  width: double.infinity,
                  height: .7,
                  color: greyColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
