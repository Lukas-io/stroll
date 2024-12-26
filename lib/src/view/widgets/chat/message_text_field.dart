import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.bottomPadding,
  });

  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: bottomPadding, top: 12.0, left: 16.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                hintText: "Type your message...",
              ),
              maxLines: 6,
              minLines: 1,
            ),
          ),
          const IconButton(
              onPressed: null,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.send,
                size: 30.0,
                color: primaryColor,
              ))
        ],
      ),
    );
  }
}
