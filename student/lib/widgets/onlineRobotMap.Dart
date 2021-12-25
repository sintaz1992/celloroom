import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
 
class LinePainter extends CustomPainter {
  Paint _paint;

  Offset beginpath;
  Offset endpath;
  var path = Path();
  //var patendpathh=path();
  LinePainter(this.beginpath, this.endpath) {
    _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //  path.moveTo(0, 0);

    path.moveTo(beginpath.dx, beginpath.dy);
    path.lineTo(endpath.dx, endpath.dy);
    canvas.drawPath(path, _paint);
    // canvas.saveLayer(bounds, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return true;
  }
}

class LinePainter2 extends CustomPainter {
  Paint _paint;
  double _progress;
  List<double> x;
  List<double> y;
  Color linecolor;
  var path = Path();
  //var patendpathh=path();
  LinePainter2(this.x, this.y, this.linecolor) {
    _paint = Paint()
      ..color = this.linecolor
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //  path.moveTo(0, 0);
    for (int i = 4; i < x.length; i++) {
      //path.moveTo(x[i - 2], y[i - 2]);
      // path.lineTo(x[i - 1], y[i - 1]);
      //  canvas.drawPath(path, _paint);
      canvas.drawLine(
          Offset(x[i - 2]* student.playgroundheight, y[i - 2]* student.playgroundheight), Offset(x[i - 1]* student.playgroundheight, y[i - 1]* student.playgroundheight), _paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter2 oldDelegate) {
    return true;
  }
}

LinePainter linepainter = new LinePainter(Offset(0, 0), Offset(0, 10));
