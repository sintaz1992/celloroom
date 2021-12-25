import 'package:flutter/material.dart';
import 'package:arrow_path/arrow_path.dart';
import 'package:student/model/Cellulo.dart';
import "dart:math" as math;

class Arrow extends CustomPainter {
  //         <-- CustomPainter class

  var celluloxPosition;
  var celluloyPosition;
  var coeffScreenMapWidth;
  var coeffScreenMapHeight;
  double directionx;
  double directiony;
  Offset celluloyM;
  Offset celluloxM;
  Arrow(this.celluloxPosition, this.celluloyPosition, this.coeffScreenMapWidth,
      this.coeffScreenMapHeight, this.directionx, this.directiony) {
    celluloxM = Offset(celluloxPosition[0] * coeffScreenMapWidth,
        celluloxPosition[1] * coeffScreenMapHeight);
    celluloyM = Offset(celluloyPosition[0] * coeffScreenMapWidth,
        celluloyPosition[1] * coeffScreenMapHeight);
/*
    directionx = 0;
    directiony = 0;
    if (math.sqrt(math.pow(directionx, 2) + math.pow(directiony, 2)) < 80)
      directionx = 0;
    else if (directionx > 40)
      directionx = 1;
    else if (directionx < -40) {
      directionx = -1;
    } else {
      directionx = 0;
    }
    if (math.sqrt(math.pow(directionx, 2) + math.pow(directiony, 2)) < 80)
      directiony = 0;
    else if (directiony > 40)
      directiony = 1;
    else if (directiony < -40) {
      directiony = -1;
    } else {
      directiony = 0;
    }
  */

    if (directionx > 40) directionx = 40;
    if (directionx < -40) directionx = -40;

    if (directiony > 40) directiony = 40;
    if (directiony < -40) directiony = -40;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print('ddddd' + directiony.toString());
    Path path;
    Path path2;
    Paint paintblue = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;
    Paint paintRed = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;
    if (directionx.abs() > 20) {
      path = Path();
      path.moveTo(celluloxM.dx - 10, celluloxM.dy - 10);
      path.relativeCubicTo(0, 0, 0, 0, directionx, 0);
      path = ArrowPath.make(path: path);
      canvas.drawPath(path, paintRed);
    }
    if (directiony.abs() > 20) {
      path2 = Path();
      path2.moveTo(celluloyM.dx + 20, celluloyM.dy + 15);
      path2.relativeCubicTo(0, 0, 0, 0, 0, directiony);
      path2 = ArrowPath.make(path: path2);
      canvas.drawPath(path2, paintblue);
    }
    //canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
