import 'package:flutter/material.dart';
import 'package:student/model/student.dart';

class PathPainter extends CustomPainter {
  Paint _paint;

  List<Offset> pathx = [];
  List<Offset> pathy = [];
  var path = Path();
  //var patendpathh=path();
  PathPainter(this.pathx, this.pathy) {
    _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //  path.moveTo(0, 0);
    //print(pathx.length);
    for (int i = 1; i < pathx.length; i++) {
      path.moveTo(pathx[i - 1].dx * student.playgroundheight,
          pathy[i - 1].dy * student.playgroundheight);
      path.lineTo(pathx[i].dx * student.playgroundheight,
          pathy[i].dy * student.playgroundheight);
      canvas.drawPath(path, _paint);
      // canvas.saveLayer(bounds, paint);
    }
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) {
    return true;
  }
}
