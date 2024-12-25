import 'package:flutter/material.dart';
import 'package:stroll/src/constants/theme.dart';
import 'package:stroll/src/view/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroll',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const SplashScreen(),
    );
  }
}
