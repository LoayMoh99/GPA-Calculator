import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/input_page/cumm_gpa.dart';
import 'package:gpa_calculator/screens/second_page/second_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class InputPage extends StatefulWidget {
  final String routeName = "/";
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
  String errorMsg;
  puttingValues() {
    try {
      cgpa = double.parse(myController.text);
      tHrs = int.parse(myController2.text);
      error = false;
      if (tHrs.isNegative) {
        error = true;
        errorMsg = "Hours can't be negative";
      } else if (cgpa.isNegative) {
        error = true;
        errorMsg = "GPA can't be negative";
      } else if (cgpa > 4.0) {
        error = true;
        errorMsg = "GPA can't be more than 4.0";
      }
    } catch (Exception) {
      error = true;
      errorMsg = "Please write the data correctly and don't leave it empty..";
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "C-GPA",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    hintText: "Enter your Cumlative GPA here..",
                  ),
                  keyboardType: TextInputType.number,
                  controller: myController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Total Hours",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    hintText: "Enter your Total Hours here..",
                  ),
                  keyboardType: TextInputType.number,
                  controller: myController2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.13),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    puttingValues();
                    if (!error) {
                      CummGPA cummGpa = CummGPA(
                        gpa: cgpa,
                        tHrs: tHrs,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondPage(
                            cummgpa: cummGpa,
                          ),
                        ),
                      );
                    } else {
                      //there is error(value unassigned)
                      Alert(context: context, title: 'ERROR!', desc: errorMsg)
                          .show();
                    }
                  },
                  child: Text(
                    'Current Semester',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
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
