import 'package:flutter/material.dart';
import 'package:student/model/student.dart';

String capitanm() {
  if (student.groupCurrentTurn == 1) return student.groupmember3name;
  if (student.groupCurrentTurn == 2) return student.groupmember2name;
  if (student.groupCurrentTurn == 3) return student.groupmember1name;
}

String capitanr() {
  if (student.groupCurrentTurn == 1) return student.groupmember1name;
  if (student.groupCurrentTurn == 2) return student.groupmember1name;
  if (student.groupCurrentTurn == 3) return student.groupmember3name;
}

String capitanb() {
  if (student.groupCurrentTurn == 1) return student.groupmember2name;
  if (student.groupCurrentTurn == 2) return student.groupmember3name;
  if (student.groupCurrentTurn == 3) return student.groupmember2name;
}
