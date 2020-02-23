import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SecondPage extends StatefulWidget {
  final double cummgpa;
  final int totalHrs;
  SecondPage({@required this.cummgpa,@required this.totalHrs});
  @override
  _SecondPageState createState() => _SecondPageState(cgpa:cummgpa , tHrs:totalHrs);
}

class _SecondPageState extends State<SecondPage> {
  final double cgpa;
  final int tHrs;
  _SecondPageState({@required this.cgpa,@required this.tHrs});
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
                        Text('Course ${index+1} name:'),
                        //two dropdownboxes for hours and expected grade
                        Text('Expected grade $cgpa'),
                        Text("It'\s Credit hours $tHrs"),
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
