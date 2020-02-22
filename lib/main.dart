import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpa_calculator/screens/input_num.dart';
import './utilities/my_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: InputPage(),
      );
  }
}