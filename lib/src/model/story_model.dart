import 'package:stroll/src/constants/assets.dart';

class StoryModel {
  final String decorationImage;
  final String name;
  final String question;
  final String timeLeft;
  final bool urgent;

  const StoryModel(
      {required this.decorationImage,
      required this.name,
      required this.question,
      required this.timeLeft,
      required this.urgent});
}

const List<StoryModel> stories = [
  StoryModel(
      decorationImage: imageAmanda,
      name: "Joey, 20",
      timeLeft: "22h",
      question: "What is your favourite time of the day?",
      urgent: false),
  StoryModel(
      decorationImage: imageBinghan,
      name: "Binghan, 22",
      timeLeft: "2m",
      question: "Mountain or Ocean?",
      urgent: true),
  StoryModel(
      decorationImage: imageAngelina,
      name: "Amanda, 22",
      timeLeft: "3m",
      question: "What you usually do when you're alone?",
      urgent: true),
];
