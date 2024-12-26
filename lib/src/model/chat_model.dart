import 'package:stroll/src/constants/assets.dart';

class ChatModel {
  final String image;
  final String name;
  final String message;
  final String question;
  final String answer;
  final String tag;
  final String dateTime;
  final bool voice;
  final bool draft;

  const ChatModel({
    required this.image,
    required this.name,
    required this.message,
    required this.question,
    required this.answer,
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
      question:
          "A friend from overseas is visiting, where would you bring them to?",
      voice: false,
      answer: '"A spontaneous city adventure!"'),
  ChatModel(
      image: imageBinghan,
      name: "Jasmine",
      message: "00:58  Voice answer.",
      tag: "New Chat Unlocked",
      question: "Mountain or Ocean?",
      dateTime: "9:30",
      voice: true,
      answer: '"Definitely ocean vibes. I love the beach!"'),
  ChatModel(
      image: imageJosiah,
      name: "Josiah",
      message:
          "You must be kidding that is what freaking happened, Call up your fucking mum let's settle this!",
      tag: "Your Turn",
      dateTime: "Dec 05",
      draft: true,
      question: "What do you usually do when you're alone?",
      voice: false,
      answer: '"I binge documentaries drinking coffee ☕️."'),
];
