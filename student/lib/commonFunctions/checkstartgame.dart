import 'package:student/model/Cellulo.dart';
import 'package:student/model/student.dart';
import 'dart:ui';
import 'dart:math' as math;

bool checkstartgame(double x, double y) {
  //double mapSizeWidth = 860;
  //double mapSizeHeight = 860;
  Offset startpoint;
  var curDistance;
  if (student.currentActivity == 'Ac3' ||
      student.currentActivity == 'Ac4' ||
      student.currentActivity == 'Ac2' ||
      student.currentActivity == 'Ac1') {
    startpoint =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['startCenter'];

    curDistance = math.sqrt(
        math.pow(x - startpoint.dx / student.mapSizeWidth, 2) +
            math.pow(y - startpoint.dy / student.mapSizeHeight, 2));

    if (curDistance > 0.15)
      return false;
    else
      return true;
  }
  if (student.currentActivity == 'Ac5' ||
      student.currentActivity == 'Ac6' ||
      student.currentActivity == 'Ac7' ||
      student.currentActivity == 'Ac8') {
    List<Offset> startpointlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['startCenter'];

    if (student.currentActivity == 'Ac5') {
      startpoint = startpointlist[student.acgame5.currenttrial];
    }

    if (student.currentActivity == 'Ac6') {
      startpoint = startpointlist[student.acgame6.currenttrial];
    }

    if (student.currentActivity == 'Ac7') {
      startpoint = startpointlist[student.acgame7.currenttrial];
    }

    var curDistance = math.sqrt(
        math.pow(x - startpoint.dx / student.mapSizeWidthfull, 2) +
            math.pow(y - startpoint.dy / student.mapSizeHeightfull, 2));

    if (curDistance > 0.15)
      return false;
    else
      return true;
  }
  if (student.currentActivity == 'Ac9') {
    List<Offset> startpointlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['startCenter'];
    Offset startpoint = startpointlist[student.acgame9.currenttrial];
    var curDistance = math.sqrt(
        math.pow(x - startpoint.dx / student.mapSizeWidthfull, 2) +
            math.pow(y - startpoint.dy / student.mapSizeHeightfull, 2));
    if (curDistance > 0.15)
      return false;
    else
      return true;
  }
  return false;
}

bool checkendgame(double x, double y) {
  //double mapSizeWidth = 860;
  //double mapSizeHeight = 860;
  Offset startpoint;
  var curDistance;
  if (student.currentActivity == 'Ac3' ||
      student.currentActivity == 'Ac4' ||
      student.currentActivity == 'Ac2' ||
      student.currentActivity == 'Ac1') {
    startpoint =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['endCenter'];

    curDistance = math.sqrt(
        math.pow(x - startpoint.dx / student.mapSizeWidth, 2) +
            math.pow(y - startpoint.dy / student.mapSizeHeight, 2));

    if (curDistance > 0.15)
      return false;
    else
      return true;
  }

  if (student.currentActivity == 'Ac5' ||
      student.currentActivity == 'Ac6' ||
      student.currentActivity == 'Ac7' ||
      student.currentActivity == 'Ac8') {
    List<Offset> startpointlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['endCenter'];

    if (student.currentActivity == 'Ac5') {
      startpoint = startpointlist[student.acgame5.currenttrial];
    }

    if (student.currentActivity == 'Ac6') {
      startpoint = startpointlist[student.acgame6.currenttrial];
    }
    if (student.currentActivity == 'Ac7') {
      startpoint = startpointlist[student.acgame7.currenttrial];
    }

    curDistance = math.sqrt(
        math.pow(x - startpoint.dx / student.mapSizeWidthfull, 2) +
            math.pow(y - startpoint.dy / student.mapSizeHeightfull, 2));

    if (curDistance > 0.15)
      return false;
    else
      return true;
  }

  if (student.currentActivity == 'Ac9') {
    List<Offset> startpointlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['endCenter'];
    startpoint = startpointlist[student.acgame9.currenttrial];

    curDistance = math.sqrt(
        math.pow(x - startpoint.dx / student.mapSizeWidthfull, 2) +
            math.pow(y - startpoint.dy / student.mapSizeHeightfull, 2));

    if (curDistance > 0.15)
      return false;
    else
      return true;
  }

  return false;
}
