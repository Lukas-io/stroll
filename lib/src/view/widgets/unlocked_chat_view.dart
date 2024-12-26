import 'package:flutter/material.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/model/chat_model.dart';

import 'chat_widget.dart';

class UnlockedChatView extends StatelessWidget {
  const UnlockedChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Unlocked",
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Container(
                    color: whiteTextColor,
                    height: 3.0,
                    width: 70.0,
                  )
                ],
              ),
              const SizedBox(
                width: 16.0,
              ),
              Text(
                "Pending",
                style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: greyTextColor.withOpacity(.6)),
              ),
            ],
          ),
          ...chats.map((chat) {
            return InkWell(
              child: ChatWidget(
                chat: chat,
              ),
            );
          })
        ],
      ),
    );
  }
}
