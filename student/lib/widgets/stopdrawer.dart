import 'package:flutter/material.dart';
import "dart:math" as math;

class StopDrawer extends CustomPainter {
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
  int axisX;
  int axisY;
  Offset boxCenter;
  Offset boxCenterM;
  final _textPainter = TextPainter(textDirection: TextDirection.ltr);
  StopDrawer(
      this.coeffScreenMapWidth, this.coeffScreenMapHeight, this.boxCenter) {
    _paintBlue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
    _paintRed = Paint()
      ..color = Colors.red
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
    boxCenterM = Offset(boxCenter.dx * coeffScreenMapWidth,
        boxCenter.dy * coeffScreenMapHeight);
  }

  Path createStartPath(Offset center, double radius) {
    final path = Path();
    var angle = (math.pi * 2) / 6;
    Offset firstPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
    path.moveTo(firstPoint.dx + center.dx, firstPoint.dy + center.dy);
    for (int j = 1; j <= 6; j++) {
      double x = radius * math.cos(angle * j) + center.dx;
      double y = radius * math.sin(angle * j) + center.dy;
      path.lineTo(x, y);
    }
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _textPainter.text = TextSpan(
        text: 'Stop here',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

//    canvas.drawRect(
    //      Offset(origin.dx + axisX * step, origin.dy), 11.0, _paintRed);
    canvas.drawPath(createStartPath(boxCenterM, 40), _paintBlue);
    _textPainter.paint(canvas, Offset(boxCenterM.dx - 27, boxCenterM.dy - 10));
  }

  @override
  bool shouldRepaint(StopDrawer oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
