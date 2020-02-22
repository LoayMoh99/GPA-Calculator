import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/screen1.dart';

class InputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> {
  TextEditingController myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed. 
    myController.dispose();
    super.dispose();
  }
  double cgpa=0;
  int tHrs=0;
  String temp;
            
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 60, 30, 50),
                      child: Image.asset('assets/images/gpaLogo.png'),
                    )
                  ),
                ),
             TextField(
              decoration: InputDecoration(labelText: "Enter your Cumlative GPA"),
              keyboardType: TextInputType.number,
              controller: myController,
              // inputFormatters: <TextInputFormatter>[
              //     WhitelistingTextInputFormatter.digitsOnly,
              // ], // Only numbers can be entered
            ),
             TextField(
              decoration: InputDecoration(labelText: "Enter your Total Hours"),
              keyboardType: TextInputType.number,
              controller: myController,
              // inputFormatters: <TextInputFormatter>[
              //     WhitelistingTextInputFormatter.digitsOnly,
              // ], // Only numbers can be entered
            ),
            Padding(
              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.13),
                child: FlatButton(
                color: Theme.of(context).accentColor,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: 
                      (context)=> SecondPage()
                   ),
                  );
                },
                child: Text(
                  'Current Semester',
                ),
              ),
            ),
          ],
         ),
        ),
      ),
    );
  }
}