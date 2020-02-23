import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/screen1.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InputPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InputPageState();
  }
}

class InputPageState extends State<InputPage> {
  TextEditingController myController = TextEditingController();
  TextEditingController myController2 = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  double cgpa = 0.0;
  int tHrs = 0;
  bool error;
  puttingValues() {
    try {
      cgpa = double.parse(myController.text);
      tHrs = int.parse(myController2.text);
       error = false;
      if(tHrs.isNegative) error=true;
      if(cgpa.isNegative) error=true;
    } catch (Exception) {
      error = true;
    }
  }

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
                )),
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: "Enter your Cumlative GPA"),
                keyboardType: TextInputType.number,
                controller: myController,
                // inputFormatters: <TextInputFormatter>[
                //     WhitelistingTextInputFormatter.digitsOnly,
                // ], // Only numbers can be entered
              ),
              TextField(
                decoration:
                    InputDecoration(labelText: "Enter your Total Hours"),
                keyboardType: TextInputType.number,
                controller: myController2,
                // inputFormatters: <TextInputFormatter>[
                //     WhitelistingTextInputFormatter.digitsOnly,
                // ], // Only numbers can be entered
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.13),
                child: FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    puttingValues();
                    if (!error) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondPage(
                          cummgpa:cgpa , totalHrs:tHrs
                        )),
                      );
                    } else {
                      //there is error(value unassigned)
                      Alert(
                              context: context,
                              title: 'Missing correct data!',
                              desc: 'Complete the data needed with non-negative numbers.')
                          .show();
                    }
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
