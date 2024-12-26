import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../model/chat_model.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final bool showPicture;
  final ChatModel? friend;

  const MessageBubble(
      {super.key, required this.text, this.friend, this.showPicture = false});

  @override
  Widget build(BuildContext context) {
    bool mine = friend == null;

    return Padding(
      padding: mine
          ? const EdgeInsets.only(
              left: 85,
              bottom: 2.0,
            )
          : const EdgeInsets.only(right: 85, bottom: 2.0),
      child: Row(
        mainAxisAlignment:
            mine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!mine)
            Opacity(
              opacity: showPicture ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 18.0,
                  backgroundImage: Image.asset(friend!.image).image,
                ),
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment:
                  mine ? MainAxisAlignment.end : MainAxisAlignment.center,
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth,
                      ),
                      decoration: BoxDecoration(
                        color: mine ? secondaryCardColor : cardColor,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 12.0),
                        child: Text(
                          text,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
