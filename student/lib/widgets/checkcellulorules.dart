import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:student/model/student.dart';
//int student.groupCurrentTurn = 1;

bool checkCelluloGame(var mapShape, Offset celluloTargetPosition, int id) {
  final double mapSizeWidth = 860;
  final double mapSizeHeight = 860;
  final double screenWidth = student.playgroundheight;
  final double screenHeight = student.playgroundheight;

  var insideBorder = false;
  var insideShape = false;
  final double coeffHaptic = 10;
  double radiuosBorder = 40;
  bool enterShape = false;

  if (true) {
    for (int i = 0; i < mapShape['numCircles']; i++) {
      var distancePointCenter = math.sqrt(math.pow(
              (celluloTargetPosition.dx -
                  mapShape['originCircles'][i].dx / mapSizeWidth),
              2) +
          math.pow(
              (celluloTargetPosition.dy -
                  mapShape['originCircles'][i].dy / mapSizeHeight),
              2));
      if (distancePointCenter <=
          mapShape['radiuosCircles'][i] / mapSizeHeight +
              student.cellulosize / 2 / student.playgroundheight -
              30 / 500) {
        return false;
      }
      /*
      
      insideBorder = false;
     
    if (distancePointCenter <= mapShape['radiuosCircles'][i]) {
      insideShape = true;
    } else {
      insideShape = false;
      enterShape = false;
    }

    if (insideShape == true) {
      if (enterShape == false) {
        score = score - 1;
        enterShape = true;
      }
    }
  */

    }
/*
    for (int i = 0; i < mapShape['numRectangles']; i++) {
      if ((Rect.fromCenter(
                  center: Offset(
                      mapShape['originRectangles'][i].dx *
                          student.playgroundheight /
                          mapSizeWidth,
                      mapShape['originRectangles'][i].dy *
                          student.playgroundheight /
                          mapSizeHeight),
                  width: mapShape['widthRectangles'][i] *
                          student.playgroundheight /
                          mapSizeWidth -
                      15 * student.playgroundheight / 500,
                  height: mapShape['heightRectangles'][i] *
                          student.playgroundheight /
                          mapSizeHeight -
                      15 * student.playgroundheight / 500)
              .contains(Offset(
                  celluloTargetPosition.dx * student.playgroundheight,
                  celluloTargetPosition.dy * student.playgroundheight)) ==
          true)) {
        return false;
      }
      //  if (id == 0) cellulox.clearship();
      //if (id == 1) celluloy.clearship();
    }
*/
    if (student.currentActivity != 'Ac4') {
      for (int i = 0; i < mapShape['numPolygons']; i++) {
        var distancePointCenter = math.sqrt(math.pow(
                (celluloTargetPosition.dx -
                    mapShape['centerPolygon'][i].dx / mapSizeWidth),
                2) +
            math.pow(
                (celluloTargetPosition.dy -
                    mapShape['centerPolygon'][i].dy / mapSizeHeight),
                2));
        if (distancePointCenter <=
            mapShape['radiusPolygon'][i] / mapSizeHeight +
                student.cellulosize / 2 / student.playgroundheight -
                30 / 500) {
          return false;
        }
      }
    }
  }
  return true;
}
