import 'package:flutter/material.dart';

class BezierCurvePainter extends CustomPainter {
  Paint _paint;
  double _progress;
  Offset beginpath;
  Offset endpath;
  Offset beginpathM;
  Offset endpathM;
  int currentTurn;
  double coeffScreenMapHeight;
  double coeffScreenMapWidth;
  double strokeWidth;
  var midddlePoint1 = [
    Offset(291.1, 176.2),
    Offset(110.2, 632.8),
    Offset(610.2, 732.8)
  ];
  var midddlePoint2 = [
    Offset(410.2, 532.8),
    Offset(356, 357),
    Offset(110.2, 232.8)
  ];
  var midddlePoint1M = [
    Offset(291.1, 176.2),
    Offset(110.2, 232.8),
    Offset(110.2, 232.8)
  ];
  var midddlePoint2M = [
    Offset(291.1, 176.2),
    Offset(110.2, 232.8),
    Offset(110.2, 232.8)
  ];
  BezierCurvePainter(this.beginpath, this.endpath, this.coeffScreenMapWidth,
      this.coeffScreenMapHeight, this.currentTurn, this.strokeWidth) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = Colors.white
      ..strokeWidth = strokeWidth;
    beginpathM = Offset(this.beginpath.dx * coeffScreenMapWidth,
        beginpath.dy * coeffScreenMapHeight);
    endpathM = Offset(this.endpath.dx * coeffScreenMapWidth,
        endpath.dy * coeffScreenMapHeight);
    for (int i = 0; i < 3; i++) {
      midddlePoint1M[i] = Offset(midddlePoint1[i].dx * coeffScreenMapWidth,
          midddlePoint1[i].dy * coeffScreenMapHeight);
      midddlePoint2M[i] = Offset(midddlePoint2[i].dx * coeffScreenMapWidth,
          midddlePoint2[i].dy * coeffScreenMapHeight);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(beginpathM.dx, beginpathM.dy)
      ..cubicTo(
          midddlePoint1M[currentTurn - 1].dx,
          midddlePoint1M[currentTurn - 1].dy,
          midddlePoint2M[currentTurn - 1].dx,
          midddlePoint2M[currentTurn - 1].dy,
          endpathM.dx,
          endpathM.dy);

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(BezierCurvePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
