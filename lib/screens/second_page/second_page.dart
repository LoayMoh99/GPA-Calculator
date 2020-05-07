import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpa_calculator/screens/input_page/cumm_gpa.dart';
import 'package:gpa_calculator/screens/result_page/result_page.dart';
import 'package:gpa_calculator/utilities/custom_droplist.dart';
import 'package:gpa_calculator/utilities/gpa_grades.dart';

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

  generateCustomDropDownList(int noCourses) {
    for (int i = myList.length; i < noCourses; i++) {
      CustomDropDownList ddl = new CustomDropDownList();
      myList.add(ddl);
      myList[i].dropdownMenuItemsGPA =
          buildDropDownMenuItemsGPA(myList[i].gpaGrades);
      myList[i].dropdownMenuItemsCHS =
          buildDropDownMenuItemsCHS(myList[i].creditHours);
      myList[i].selectedGPA = myList[i].dropdownMenuItemsGPA[1].value;
      myList[i].selectedHours = myList[i].dropdownMenuItemsCHS[2].value;
    }
  }

  @override
  void initState() {
    super.initState();
    noCourses = 1;
    generateCustomDropDownList(noCourses);
  }

  List<DropdownMenuItem<GPA>> buildDropDownMenuItemsGPA(List<GPA> gpaGrades) {
    List<DropdownMenuItem<GPA>> items = [];
    for (GPA gpa in gpaGrades) {
      items.add(DropdownMenuItem(
        value: gpa,
        child: Text(gpa.gpaGrade),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> buildDropDownMenuItemsCHS(List<int> creditHours) {
    List<DropdownMenuItem<int>> items = [];
    for (int hour in creditHours) {
      items.add(DropdownMenuItem(
        value: hour,
        child: Text(hour.toString()),
      ));
    }
    return items;
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

  double calculateGPA(List<CustomDropDownList> myList) {
    int sumHours = 0;
    double sumGPAs = 0.0;
    print(myList.length);
    for (int i = 0; i < myList.length; i++) {
      sumHours += myList[i].selectedHours;
      sumGPAs += myList[i].selectedGPA.gpaWeight * myList[i].selectedHours;
    }
    return (widget.cummgpa.gpa * widget.cummgpa.tHrs + sumGPAs) /
        (widget.cummgpa.tHrs + sumHours);
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
                  onTap: () {
                    double gpa = calculateGPA(myList);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ResultPage(gpa),
                      ),
                    );
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        myList = [];
                        noCourses = 1;
                        setState(() {
                          generateCustomDropDownList(noCourses);
                        });
                      },
                      child: Text(
                        'Clear ALL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        noCourses--;
                        setState(() {
                          generateCustomDropDownList(noCourses);
                        });
                      },
                      child: Text(
                        'Remove Recent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        noCourses++;
                        setState(() {
                          generateCustomDropDownList(noCourses);
                        });
                      },
                      child: Text(
                        'ADD Course',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
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
}
