
class GPA {
  String gpaGrade;
  double gpaWeight;

  GPA(this.gpaGrade,this.gpaWeight);

  static List<GPA> getGPAGrades(){
    return <GPA> [
      GPA('A+',4.00),
      GPA('A',4.00),
      GPA('A-',3.70),
      GPA('B+',3.30),
      GPA('B',3.00),
      GPA('B-',2.70),
      GPA('C+',2.30),
      GPA('C',2.00),
      GPA('C-',1.70),
      GPA('D+',1.30),
      GPA('D',1.00),
      GPA('F',0.00),
    ];
  }
}