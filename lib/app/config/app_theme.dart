import 'package:flutter/material.dart';

import '../utils/color.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  primaryColor: PRIMARY_COLOR,
  scaffoldBackgroundColor: BACKGROUND_COLOR,
  appBarTheme: const AppBarTheme(
    backgroundColor: PRIMARY_COLOR,
    foregroundColor: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: PRIMARY_COLOR),
  ),
);

final ThemeData dartkTheme = ThemeData(
  brightness: Brightness.dark,
);
