import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stroll/src/utils/extensions.dart';
import 'package:stroll/src/model/chat_model.dart';

import '../../constants/colors.dart';
import '../widgets/chat/chat_unlocked_widget.dart';
import '../widgets/chat/message_text_field.dart';
import '../widgets/chat/stroll_voice_question.dart';

class ChatScreen extends StatefulWidget {
  final ChatModel chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _myKey = GlobalKey();
  final GlobalKey _friendKey = GlobalKey();

  late ScrollController _scrollController;
  late AnimationController _animationController;

  double currentScrollOffset = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this, duration: 100.ms)
      ..addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom == 0
        ? 8
        : MediaQuery.of(context).padding.bottom;
    double topPadding = MediaQuery.of(context).viewPadding.top +
        MediaQuery.of(context).padding.top;
    double strollQuestionHeight = 180;
    double storyModeSpacing = MediaQuery.sizeOf(context).height * 4 / 7 -
        topPadding -
        strollQuestionHeight;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: _animationController.value * storyModeSpacing,
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    StrollVoiceQuestion(
                      key: _myKey,
                      chat: widget.chat,
                      mine: true,
                      onPop: () {
                        _scrollController.animateTo(currentScrollOffset,
                            duration: 700.ms,
                            curve: Curves.fastEaseInToSlowEaseOut);
                        _animationController.reverse();
                      },
                      onTap: () {
                        currentScrollOffset = _scrollController.offset;
                        _animationController.forward();
                        Scrollable.ensureVisible(
                          _myKey.currentContext!,
                          duration: 700.ms,
                          curve: Curves.fastEaseInToSlowEaseOut,
                        );
                      },
                    ),
                    StrollVoiceQuestion(
                      key: _friendKey,
                      chat: widget.chat,
                      onPop: () {
                        _scrollController.animateTo(currentScrollOffset,
                            duration: 700.ms,
                            curve: Curves.fastEaseInToSlowEaseOut);

                        _animationController.reverse();
                      },
                      onTap: () {
                        currentScrollOffset = _scrollController.offset;

                        _animationController.forward();

                        Scrollable.ensureVisible(
                          _friendKey.currentContext!,
                          duration: 700.ms,
                          curve: Curves.fastEaseInToSlowEaseOut,
                        );
                      },
                    ),
                    ChatUnlockedWidget(chat: widget.chat),
                    const SizedBox(
                      height: 500.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
          widget.chat.name,
          style: context.textTheme.titleLarge
              ?.copyWith(color: whiteTextColor, fontWeight: FontWeight.w700),
        ),
        actions: const [
          // CircleAvatar(
          //   backgroundImage: Image.asset(widget.chat.image).image,
          // ),
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_horiz_rounded,
                size: 30,
                color: whiteTextColor,
              )),
        ],
      ),
    );
  }
}
