import 'package:student/model/student.dart';
import 'package:flutter/material.dart';

double mapSizeWidth = student.mapSizeWidth;
double mapSizeHeight = student.mapSizeHeight;
double posecirclex(int i) {
  List<Offset> starposelist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['originCircles'];
  Offset starpose = starposelist[i];
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['radiuosCircles'];
  return starpose.dx * student.playgroundheight / mapSizeWidth -
      radlist[i] * student.playgroundheight / mapSizeWidth;
}

Offset endpoint() {
  return student.mapShape[student.acList.indexOf(student.currentActivity)]
      [student.groupCurrentTurn - 1]['endCenter'];
}

double posecircley(int i) {
  List<Offset> starposelist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['originCircles'];
  Offset starpose = starposelist[i];
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['radiuosCircles'];
  return starpose.dy * student.playgroundheight / mapSizeHeight -
      radlist[i] * student.playgroundheight / mapSizeWidth;
}

double radcircle(int i) {
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['radiuosCircles'];

  return 2 * radlist[i] * student.playgroundheight / mapSizeWidth;
}

double radpol(int i) {
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['radiusPolygon'];

  return 2 * radlist[i] * student.playgroundheight / mapSizeWidth;
}

double radrecw(int i) {
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['widthRectangles'];

  return radlist[i] * student.playgroundheight / mapSizeWidth;
}

double radrech(int i) {
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['heightRectangles'];

  return radlist[i] * student.playgroundheight / mapSizeWidth;
}

double poserecx(int i) {
  List<Offset> starposelist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['originRectangles'];
  Offset starpose = starposelist[i];
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['widthRectangles'];
  return starpose.dx * student.playgroundheight / mapSizeWidth -
      radlist[i] / 2 * student.playgroundheight / mapSizeWidth;
}

double poserecy(int i) {
  List<Offset> starposelist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['originRectangles'];
  Offset starpose = starposelist[i];
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['heightRectangles'];

  return starpose.dy * student.playgroundheight / mapSizeHeight -
      radlist[i] / 2 * student.playgroundheight / mapSizeWidth;
}

double posepolx(int i) {
  List<Offset> starposelist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['centerPolygon'];
  Offset starpose = starposelist[i];
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['radiusPolygon'];
  return starpose.dx * student.playgroundheight / mapSizeWidth -
      radlist[i] * student.playgroundheight / mapSizeWidth;
}

double posepoly(int i) {
  List<Offset> starposelist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['centerPolygon'];
  Offset starpose = starposelist[i];
  List<double> radlist =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['radiusPolygon'];
  return starpose.dy * student.playgroundheight / mapSizeHeight -
      radlist[i] * student.playgroundheight / mapSizeWidth;
}
