import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/input_page/cumm_gpa.dart';
import 'package:gpa_calculator/screens/input_page/input_num.dart';
import 'package:gpa_calculator/screens/second_page/second_page.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //generating arguments while using pushNamed()..
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => InputPage());
      case "/second":
        //validations on the argument/s..
        if (args is CummGPA) {
          return MaterialPageRoute(
            builder: (_) => SecondPage(
              cummgpa: args,
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
    return MaterialPageRoute(builder: (_) {
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
