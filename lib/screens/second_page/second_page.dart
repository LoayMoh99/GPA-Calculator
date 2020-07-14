import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpa_calculator/utilities/router_generator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/custom_droplist.dart';
import '../../utilities/gpa_grades.dart';
import '../input_page/cumm_gpa.dart';
import 'calculate_gpa.dart';

class SecondPage extends StatefulWidget {
  final String routeName = "/second";
  final CummGPA cummgpa;
  SecondPage({@required this.cummgpa});
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int noCourses;
  List<CustomDropDownList> myList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    noCourses = 1;
    Provider.of<GPACalculate>(context)
        .generateCustomDropDownList(noCourses, myList);
  }

  void onChangedGPAgrade(GPA selectedGPA, int index) {
    setState(() {
      myList[index].selectedGPA = selectedGPA;
    });
  }

  void onChangedCreditHours(int selectedHour, int index) {
    setState(() {
      myList[index].selectedHours = selectedHour;
    });
  }

  Widget rowBuilder(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            'Course ${index + 1}:',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),

        //two dropdownboxes for hours and expected grade
        DropdownButton<GPA>(
          value: myList[index].selectedGPA,
          items: myList[index].dropdownMenuItemsGPA,
          onChanged: (GPA gpa) => onChangedGPAgrade(gpa, index),
        ),
        DropdownButton<int>(
          value: myList[index].selectedHours,
          items: myList[index].dropdownMenuItemsCHS,
          onChanged: (int chs) => onChangedCreditHours(chs, index),
        ),
      ],
    );
  }

  _saveRecentResult(double gpa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('recent_result', gpa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: noCourses,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 14),
                      child: rowBuilder(index),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01),
                child: GestureDetector(
                  onTap: () async {
                    double gpa =
                        Provider.of<GPACalculate>(context, listen: false)
                            .calculateGPA(myList, widget.cummgpa);
                    _saveRecentResult(gpa);
                    Navigator.push(
                        context,
                        RouterGenerator.generateRoute(RouteSettings(
                          name: '/result',
                          arguments: gpa,
                        )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Center(
                      child: Text(
                        'CALCULATE!!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    customButton(
                      text: 'Clear ALL',
                      onPress: () {
                        myList = [];
                        noCourses = 1;
                        setState(() {
                          Provider.of<GPACalculate>(context, listen: false)
                              .generateCustomDropDownList(noCourses, myList);
                        });
                      },
                    ),
                    customButton(
                      text: 'Remove Recent',
                      onPress: () {
                        (noCourses <= 1) ? noCourses = 1 : noCourses--;
                        setState(() {
                          Provider.of<GPACalculate>(context, listen: false)
                              .generateCustomDropDownList(noCourses, myList);
                        });
                      },
                    ),
                    customButton(
                      text: 'Add Course',
                      onPress: () {
                        noCourses++;
                        setState(() {
                          Provider.of<GPACalculate>(context, listen: false)
                              .generateCustomDropDownList(noCourses, myList);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton({String text, Function onPress}) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Theme.of(context).accentColor,
      onPressed: onPress,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
