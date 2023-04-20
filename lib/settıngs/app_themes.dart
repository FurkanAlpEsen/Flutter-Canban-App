import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorSchemeSeed: Colors.white,
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: const TextTheme(
    displayMedium: TextStyle(color: Colors.red),
    bodyLarge: TextStyle(color: Colors.blue),
  ),
);

final ThemeData darkTheme = ThemeData(
  colorSchemeSeed: Colors.amber,
  brightness: Brightness.dark,
  useMaterial3: true,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: Colors.amber,
    ),
  ),
);
