import 'package:flutter/material.dart';

ThemeData customTheme() {
  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
    primaryColor: Colors.black38,
    indicatorColor: const Color(0xFF807A6B),
    primaryIconTheme: darkTheme.primaryIconTheme.copyWith(
      color: Colors.green,
      size: 20,
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFFF8E1)),
  );
}
