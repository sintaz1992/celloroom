import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:student/model/student.dart';

class PointPainter extends CustomPainter {
  Paint _paint;
  double _progress;
  Offset beginpath;
  Offset endpath;
  List<Offset> points;
  double scale = 500 / 860;
  PointPainter(this.points) {
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 6.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (points != null) canvas.drawPoints(PointMode.points, points, _paint);
    for (int i = 1; i < points.length; i++) {
      _paint.color = Colors.red;
      canvas.drawLine(
          new Offset(points[i].dx * student.playgroundheight - 5,
              points[i].dy * student.playgroundheight - 5),
          new Offset(points[i].dx * student.playgroundheight + 5,
              points[i].dy * student.playgroundheight + 5),
          _paint);
      canvas.drawLine(
          new Offset(points[i].dx * student.playgroundheight - 5,
              points[i].dy * student.playgroundheight + 5),
          new Offset(points[i].dx * student.playgroundheight + 5,
              points[i].dy * student.playgroundheight - 5),
          _paint);
    }
  }

  @override
  bool shouldRepaint(PointPainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
