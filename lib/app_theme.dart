import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
      primaryColor: Colors.white,
      accentColor: Colors.blue,
      textTheme: TextTheme(
        headline4: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w300,
          color: Colors.black26,
        ),
        subtitle2: TextStyle(fontSize: 17, color: Colors.black87),
        bodyText2: TextStyle(fontSize: 17, color: Colors.black54),
      ));
}
