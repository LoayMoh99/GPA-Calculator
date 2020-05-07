import 'package:flutter/material.dart';
import 'package:gpa_calculator/utilities/gpa_grades.dart';

class CustomDropDownList{
  List<GPA> _gpaGrades = GPA.getGPAGrades();
  List<GPA> get gpaGrades => _gpaGrades;
  List<int> _creditHours = [1,2,3,4,5];
  List<int> get creditHours => _creditHours;
  List<DropdownMenuItem<GPA>> dropdownMenuItemsGPA;
  List<DropdownMenuItem<int>> dropdownMenuItemsCHS;
  GPA selectedGPA;
  int selectedHours;
}