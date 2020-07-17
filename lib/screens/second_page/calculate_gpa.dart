import 'package:flutter/material.dart';
import 'package:gpa_calculator/screens/input_page/cumm_gpa.dart';
import 'package:gpa_calculator/utilities/custom_droplist.dart';
import 'package:gpa_calculator/utilities/gpa_grades.dart';

class GPACalculate extends ChangeNotifier {
  double recentGPA = 0.0;

  ///this function 2 ddl for the hours and the gpa grade..
  generateCustomDropDownList(int noCourses, List<CustomDropDownList> myList) {
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

  ///these are two helper functions for generating the 2xDropDownLists
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

  ///this will calculate the gpa from the list
  double calculateGPA(List<CustomDropDownList> myList, CummGPA cummgpa) {
    if (myList == null) {
      notifyListeners();
      return recentGPA;
    }
    int sumHours = 0;
    double sumGPAs = 0.0;
    print(myList.length);
    for (int i = 0; i < myList.length; i++) {
      sumHours += myList[i].selectedHours;
      sumGPAs += myList[i].selectedGPA.gpaWeight * myList[i].selectedHours;
    }
    recentGPA =
        (cummgpa.gpa * cummgpa.tHrs + sumGPAs) / (cummgpa.tHrs + sumHours);
    notifyListeners();
    return recentGPA;
  }
}
