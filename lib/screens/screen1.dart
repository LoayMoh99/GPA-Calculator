import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gpa_calculator/utilities/gpa_grades.dart';

class SecondPage extends StatefulWidget {
  final double cummgpa;
  final int totalHrs;
  SecondPage({@required this.cummgpa, @required this.totalHrs});
  @override
  _SecondPageState createState() =>
      _SecondPageState(cgpa: cummgpa, tHrs: totalHrs);
}

class CustomDropDownList{
  List<GPA> gpaGrades = GPA.getGPAGrades();
  List<int> creditHours = [1,2,3,4,5];
  List<DropdownMenuItem<GPA>> dropdownMenuItems;
  List<DropdownMenuItem<int>> dropdownMenuItems2;
  GPA selectedGPA;
  int selectedHours;
}

class _SecondPageState extends State<SecondPage> {
  final double cgpa;
  final int tHrs;
  _SecondPageState({@required this.cgpa, @required this.tHrs});
  int noCourses = 1;
  List<CustomDropDownList> myList =[];
 generateCustomDropDownList(int noCourses){
    CustomDropDownList ddl;
    for(int i=0;i<noCourses;i++)
      myList.add(ddl);
  }
  


  @override
  void initState() {
    generateCustomDropDownList(noCourses);
    myList[0].dropdownMenuItems = buildDropDownMenuItems(myList[0].gpaGrades);
    myList[0].dropdownMenuItems2 = buildDropDownMenuItems2(myList[0].creditHours);
    myList[0].selectedGPA = myList[0].dropdownMenuItems[0].value;
    myList[0].selectedHours = myList[0].dropdownMenuItems2[0].value;
    super.initState();
  }

  List<DropdownMenuItem<GPA>> buildDropDownMenuItems(List gpaGrades) {
    List<DropdownMenuItem<GPA>> items = List();
    for (GPA gpa in gpaGrades){
      items.add(DropdownMenuItem(
        value: gpa,
        child: Text(gpa.gpaGrade),
      ));
    }
    return items;
  }

  List<DropdownMenuItem<int>> buildDropDownMenuItems2(List creditHours) {
    List<DropdownMenuItem<int>> items = List();
    for (int hour in creditHours){
      items.add(DropdownMenuItem(
        value: hour,
        child: Text(hour.toString()),
      ));
    }
    return items;
  }

  onChangedGPAgrade(GPA selectedGPA,int index)
  {
    setState(() {
      myList[index].selectedGPA =selectedGPA;
    });
  }

  onChangedCreditHours(int selectedHour,int index)
  {
    setState(() {
      myList[index].selectedHours =selectedHour;
    });
  }

  Widget rowBuilder(int index){
    return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Course ${index + 1} name:'),
            //two dropdownboxes for hours and expected grade
            SizedBox(width: 40,),
            DropdownButton<GPA>(
              value: myList[index].selectedGPA,
              items:myList[index].dropdownMenuItems,
              onChanged: onChangedGPAgrade(myList[index].selectedGPA,index),
            ),
            SizedBox(width: 40,),
            DropdownButton<int>(
              value: myList[index].selectedHours,
              items:myList[index].dropdownMenuItems2,
              onChanged: onChangedCreditHours(myList[index].selectedHours,index),
            ),
          ],
        );
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: noCourses,
                itemBuilder: (context, index) {
                  return rowBuilder(index);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: FlatButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  noCourses++;
                  setState(() {
                    generateCustomDropDownList(noCourses);
                  });
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
