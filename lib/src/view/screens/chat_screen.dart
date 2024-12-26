import 'package:flutter/material.dart';
import 'package:stroll/src/constants/extensions.dart';
import 'package:stroll/src/model/chat_model.dart';

import '../../constants/colors.dart';
import '../widgets/chat_unlocked_widget.dart';
import '../widgets/message_text_field.dart';
import '../widgets/stroll_voice_question.dart';

class ChatScreen extends StatelessWidget {
  final ChatModel chat;

  const ChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom == 0
        ? 8
        : MediaQuery.of(context).padding.bottom;
    return Scaffold(
      bottomSheet: MessageTextField(
        bottomPadding: bottomPadding,
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.adaptive.arrow_back,
              color: whiteTextColor,
              size: 30,
            )),
        title: Text(
          chat.name,
          style: context.textTheme.titleLarge
              ?.copyWith(color: whiteTextColor, fontWeight: FontWeight.w700),
        ),
        actions: const [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_horiz_rounded,
                size: 30,
                color: whiteTextColor,
              )),
        ],
      ),
      body: Stack(
        children: [
          // QuestionAnswerWidget(
          //   chat: chat,
          //   mine: true,
          // ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StrollVoiceQuestion(chat: chat, mine: true),
                  StrollVoiceQuestion(chat: chat),
                  ChatUnlockedWidget(chat: chat),
                  const SizedBox(
                    height: 300.0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
