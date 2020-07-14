import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/input_page/cumm_gpa.dart';
import 'package:gpa_calculator/utilities/custom_button.dart';
import 'package:gpa_calculator/utilities/router_generator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  double cgpa = 0.0, recentGpa = 0.0;
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
      } else if ((cgpa == 0.0 && tHrs > 0) || (cgpa > 0 && tHrs == 0)) {
        tHrs = 0;
        cgpa = 0;
      }
    } catch (Exception) {
      error = true;
      errorMsg = "Please write the data correctly and don't leave it empty..";
    }
  }

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recentGpa = prefs.getDouble('recent_result') ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  String _recentGpa() {
    getSharedPrefs();
    return '${recentGpa.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 40,
                    ),
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
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Recent Result: ',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        _recentGpa(),
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton(
                        btnText: 'Current Semester',
                        textColor: Colors.white,
                        backColor: Theme.of(context).accentColor,
                        onPress: () {
                          puttingValues();
                          if (!error) {
                            CummGPA cummGpa = CummGPA(
                              gpa: cgpa,
                              tHrs: tHrs,
                            );
                            Navigator.push(
                                context,
                                RouterGenerator.generateRoute(RouteSettings(
                                  name: '/second',
                                  arguments: cummGpa,
                                )));
                          } else {
                            //there is error(value unassigned)
                            Alert(
                                    context: context,
                                    title: 'ERROR!',
                                    desc: errorMsg)
                                .show();
                          }
                        },
                      ),
                      CustomButton(
                        btnText: 'First Semester',
                        backColor: Color(0xCCFFFFFF),
                        textColor: Theme.of(context).accentColor,
                        onPress: () {
                          CummGPA cummGpa = CummGPA(
                            gpa: 0,
                            tHrs: 0,
                          );
                          Navigator.push(
                              context,
                              RouterGenerator.generateRoute(RouteSettings(
                                name: '/second',
                                arguments: cummGpa,
                              )));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
