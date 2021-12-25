import 'package:flutter/material.dart';

class GuideGrid extends CustomPainter {
  Paint _paintBlue;
  Paint _paintRed;
  double _progress;
  Offset beginpath;
  Offset endpath;
  Offset origin;
  var step = 0.0;
  List<double> celluloxposition;
  List<double> celluloyposition;
  double coeffScreenMapHeight;
  double coeffScreenMapWidth;
  double xaxis = 750;
  double yaxis = 80;
  int axisX;
  int axisY;
  var steps = [0.0, 80.0, 157.0, 235.0, 312.0, 389.0, 467.0];

  GuideGrid(this.origin, this.step, this.coeffScreenMapWidth,
      this.coeffScreenMapHeight, this.celluloxposition, this.celluloyposition) {
    _paintBlue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;
    _paintRed = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    axisX = 0;
    axisY = 0;
    for (int i = 1; i < 4; i++) {
      if (steps[2 * (i - 1)] / coeffScreenMapWidth <
              (celluloxposition[0] - (origin.dx / coeffScreenMapWidth)) &&
          (celluloxposition[0] - (origin.dx / coeffScreenMapWidth)) <
              steps[2 * i] / coeffScreenMapWidth) {
        axisX = 2 * (i - 1);
        break;
      }
    }

    if ((celluloxposition[0] - origin.dx / coeffScreenMapWidth) < 0) axisX = 0;

    if ((celluloxposition[0] - origin.dx / coeffScreenMapWidth) >
        steps[6] / coeffScreenMapHeight) axisX = 6;

    for (int i = 1; i < 4; i++) {
      if (steps[2 * (i - 1)] / coeffScreenMapHeight <
              (-celluloyposition[1] + origin.dy / coeffScreenMapHeight) &&
          (-celluloyposition[1] + origin.dy / coeffScreenMapHeight) <
              steps[2 * i] / coeffScreenMapHeight) {
        axisY = 2 * (i - 1);
        break;
      }
    }

    if ((-celluloyposition[1] + origin.dy / coeffScreenMapHeight) < 0)
      axisY = 0;

    if ((-celluloyposition[1] + origin.dy / coeffScreenMapHeight) >
        steps[6] / coeffScreenMapHeight) axisY = 6;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print('axisX' + axisX.toString());
    //print('axisY' + axisY.toString());
    canvas.drawCircle(
        Offset(origin.dx + steps[axisX], origin.dy), 11.0, _paintRed);
    canvas.drawCircle(
        Offset(origin.dx, origin.dy - steps[axisY]), 11.0, _paintBlue);

    canvas.drawLine(
        Offset(celluloxposition[0] * coeffScreenMapWidth,
            celluloyposition[1] * coeffScreenMapHeight),
        Offset(celluloxposition[0] * coeffScreenMapWidth,
            xaxis * coeffScreenMapHeight),
        _paintRed);
    canvas.drawLine(
        Offset(celluloxposition[0] * coeffScreenMapWidth,
            celluloyposition[1] * coeffScreenMapHeight),
        Offset(yaxis * coeffScreenMapWidth,
            celluloyposition[1] * coeffScreenMapHeight),
        _paintBlue);
  }

  @override
  bool shouldRepaint(GuideGrid oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
