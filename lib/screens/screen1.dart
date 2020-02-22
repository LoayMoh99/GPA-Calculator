import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int noCourses=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                  itemCount:noCourses,
                  itemBuilder: (context, index) {
                    return Row(
                      children: <Widget>[
                        ListTile(
                          title: Text('Course ${index+1}'),
                        ),
                        //two dropdownboxes for hours and expected grade
                      ],
                    );
                  },
                ),
            ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*0.05),
                  child: FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: (){
                    noCourses++;
                    setState(() {});
                  },
                  child: Text(
                    'Add Course',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
