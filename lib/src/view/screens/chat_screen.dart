import 'package:flutter/material.dart';
import 'package:stroll/src/constants/assets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          )
        ],
      ),
    );
  }
}
