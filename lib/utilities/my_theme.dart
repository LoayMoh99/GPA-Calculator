import 'package:flutter/material.dart';

ThemeData myTheme = new ThemeData(
  backgroundColor: Colors.white,
  primaryColor: Colors.green,
  accentColor: Colors.greenAccent,
  fontFamily: 'Schyler',
  textTheme: TextTheme(
    title: TextStyle(
      fontSize: 60,
    ),
    subtitle: TextStyle(
      fontSize: 40,
      fontStyle: FontStyle.italic,
    ),
  ),
);
