import 'package:flutter/material.dart';
import 'package:stroll/src/constants/colors.dart';
import 'package:stroll/src/constants/text.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  useMaterial3: true,
  cardColor: cardColor,
  fontFamily: "ProximaNova",
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: backgroundColor),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    padding: EdgeInsets.zero,
  )),
  textTheme: darkTextTheme,
);
