import 'package:flutter/material.dart';
import 'package:stroll/src/constants/assets.dart';
import 'package:stroll/src/view/widgets/story_list_view.dart';
import 'package:stroll/src/view/widgets/unlocked_chat_view.dart';

import '../widgets/locked_header_widget.dart';
import '../widgets/match_like_tab.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF13171C),
      body: Stack(
        children: [
          Image.asset(imageSplashScreen),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0xFF13171C),
                ],
                stops: [0.3, 0.5],
              ),
            ),
            child: const SafeArea(
              child: Column(
                children: [
                  MatchLikeTab(),
                  LockedHeaderWidget(),
                  StoryListView(),
                  UnlockedChatView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
