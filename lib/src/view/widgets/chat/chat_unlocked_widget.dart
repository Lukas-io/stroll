import 'package:flutter/material.dart';
import 'package:stroll/src/utils/extensions.dart';

import '../../../model/chat_model.dart';
import 'message_bubble.dart';

class ChatUnlockedWidget extends StatelessWidget {
  final ChatModel chat;

  const ChatUnlockedWidget({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                const Expanded(
                    child: Divider(
                  indent: 30.0,
                  endIndent: 20.0,
                  thickness: 2.5,
                )),
                Text(
                  "Chat Unlocked",
                  maxLines: 2,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Expanded(
                    child: Divider(
                  endIndent: 30.0,
                  indent: 20.0,
                  thickness: 2.5,
                )),
              ],
            ),
          ),
          MessageBubble(
            text: "Hello 😉",
            friend: chat,
          ),
          MessageBubble(
            text:
                "Is there anybody in there? Just nod if you can hear me. Is there anyone home?",
            friend: chat,
            showPicture: true,
          ),
          const SizedBox(
            height: 12.0,
          ),
          const MessageBubble(text: "Come on now"),
          const MessageBubble(text: "I hear you're feeling down"),
        ],
      ),
    );
  }
}
