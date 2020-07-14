import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpa_calculator/screens/input_page/input_num.dart';
import 'package:gpa_calculator/screens/second_page/calculate_gpa.dart';
import 'package:provider/provider.dart';
import './utilities/my_theme.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => GPACalculate(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: InputPage(),
      ),
    );
  }
}
