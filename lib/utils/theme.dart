import 'package:flutter/material.dart';

ThemeData customTheme() {
  final ThemeData darkTheme = ThemeData.dark();
  return darkTheme.copyWith(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ));
}
