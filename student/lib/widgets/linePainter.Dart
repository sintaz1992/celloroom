import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  Paint _paint;
  double _progress;
  Offset beginpath;
  Offset endpath;
  double scale = 500 / 860;

  LinePainter(this._progress, this.beginpath, this.endpath) {
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 6.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(beginpath.dx * scale, beginpath.dy * scale),
        Offset(scale * (beginpath.dx + _progress * (endpath.dx - beginpath.dx)),
            scale * (beginpath.dy + _progress * (endpath.dy - beginpath.dy))),
        _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
