import 'package:stroll/src/constants/assets.dart';

class ChatModel {
  final String image;
  final String name;
  final String message;
  final String tag;
  final String dateTime;
  final bool voice;
  final bool draft;

  const ChatModel({
    required this.image,
    required this.name,
    required this.message,
    required this.tag,
    required this.dateTime,
    required this.voice,
    this.draft = false,
  });
}

const List<ChatModel> chats = [
  ChatModel(
      image: imageSplashScreen,
      name: "Pearl🦋",
      message:
          "Wow that was really unexpected, I thought he was loved in his home",
      tag: "Your Turn",
      dateTime: "3 mins",
      voice: false),
  ChatModel(
      image: imageBinghan,
      name: "Jasmine",
      message: "00:58  Voice answer.",
      tag: "New Chat Unlocked",
      dateTime: "9:30",
      voice: true),
  ChatModel(
      image: imageJosiah,
      name: "Josiah",
      message:
          "You must be kidding that is what freaking happened, Call up your fucking mum let's settle this!",
      tag: "Your Turn",
      dateTime: "Dec 05",
      draft: true,
      voice: false),
];
