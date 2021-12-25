import 'package:dashboard/model/Group.dart';

Teacher thisClass = new Teacher();

class Teacher {
  int inactivity;
  String teacherName;
  List<String> sessionIDs;
  List<Group> groups = [];

  Teacher();
}
