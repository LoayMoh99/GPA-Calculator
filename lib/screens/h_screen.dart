import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 60, 30, 50),
                child: Image.asset('assets/images/gpaLogo.png'),
              )
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // child: TextField(
                  //   controller: myController,
                  // ),
                  child: Column(
                    children: <Widget>[
                      // Expanded(
                      //     child: TextField(
                      //         onChanged: (changedValue){},
                      //       decoration:InputDecoration.collapsed(hintText:'Type your message..'),
                      //   ),
                      // ),
                      Text('Cumulative GPA'),
                    ],
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // child: TextField(
                  //   controller: myController,
                  // ),
                  child: Column(
                    children: <Widget>[
                      Text('Cumulative GPA'),
                      Text('Cumulative GPA'),
                    ],
                  ),
                ), 
              ],
            ),
        ],
      ),
    );
  }
}
