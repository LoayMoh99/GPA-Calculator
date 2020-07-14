import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/input_page/cumm_gpa.dart';
import 'package:gpa_calculator/screens/input_page/input_num.dart';
import 'package:gpa_calculator/screens/result_page/result_page.dart';
import 'package:gpa_calculator/screens/second_page/second_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //generating arguments while using pushNamed()..
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => InputPage());
      case "/second":
        //validations on the argument/s..
        if (args is CummGPA) {
          return MaterialPageRoute(
            builder: (context) => SecondPage(
              cummgpa: args,
            ),
          );
        }
        return _errorRoute();
      case "/result":
        //validations on the argument/s..
        if (args is double) {
          return MaterialPageRoute(
            builder: (context) => ResultPage(
              gpa: args,
            ),
          );
        }

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
