import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String routeName = "/result";
  final double gpa;
  ResultPage(this.gpa);
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Text(
          'Results',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your GPA is',
                style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenWidth * 0.05,
              ),
              Text(
                '${gpa.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 50,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
