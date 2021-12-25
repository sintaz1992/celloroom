import 'package:flutter/material.dart';

class LinePainter2 extends CustomPainter {
  Paint _paint;
  List<int> gColor;
  List<double> x;
  List<double> y;
  var path = Path();
  //var patendpathh=path();
  LinePainter2(this.x, this.y) {
    _paint = Paint()
      //     ..color = Color.fromRGBO(38, gColor, 38, 0.9)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //  path.moveTo(0, 0);
    //canvas.restore();
    //print(x);
    // print(x);
    int v;
    for (int i = 3; i < x.length ; i++) {
     

      //path.moveTo(x[i - 2], y[i - 2]);
      // path.lineTo(x[i - 1], y[i - 1]);
      canvas.drawLine(Offset(x[i - 2], y[i - 2]), Offset(x[i - 1], y[i - 1]),
          _paint..color = Color.fromRGBO(0, 0, 255, 0.9));
      // canvas.save();
      //  debugPrint('v' + v.toString());
    }
  }

  @override
  bool shouldRepaint(LinePainter2 oldDelegate) {
    return true;
  }
}

class LinePainter3 extends CustomPainter {
  Paint _paint;
  List<int> gColor;
  List<double> x;
  List<double> y;
  var path = Path();
  //var patendpathh=path();
  LinePainter3(this.x, this.y, this.gColor) {
    _paint = Paint()
      //     ..color = Color.fromRGBO(38, gColor, 38, 0.9)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //  path.moveTo(0, 0);
    //canvas.restore();
    //print(x);
    // print(x);

    for (int i = 3; i < x.length - 3; i++) {
      canvas.drawLine(Offset(x[i - 2], y[i - 2]), Offset(x[i - 1], y[i - 1]),
          _paint..color = Color.fromRGBO(0, 0, 255, 0.9));
      // canvas.save();

    }
  }

  @override
  bool shouldRepaint(LinePainter3 oldDelegate) {
    return true;
  }
}
