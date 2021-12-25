import 'package:flutter/material.dart';
import 'dart:math' as math;

class MapShapeMaker extends CustomPainter {
  Paint _paint;
  Paint _paintStartEnd;
  int numCircles;
  List<Offset> originCircles;
  List<double> radiuosCircles;
  int numRectangles;
  List<Offset> originRectangles;
  List<double> widthRectangles;
  List<double> heightRectangles;
  int numPolygons;
  List<int> sidesofPolygon;
  List<double> radiusPolygon;
  List<Offset> centerPolygon;
  List<Color> colorHexagon;
  Offset startCenter;
  Offset endCenter;
  double radiuosStart = 45;
  var mapHitColor = {
    'Circles': [0, 0, 0, 0, 0, 0, 0, 0],
    'Rectangles': [0, 0, 0, 0, 0, 0, 0, 0],
    'Polygons': [0, 0, 0, 0, 0, 0, 0, 0, 0],
  };

  var pointOrder = ['A', 'B', 'C', 'D'];
  List<Offset> pointPosition = [
    Offset(80.0, 80.0),
    Offset(760.0, 80.0),
    Offset(80.0, 760.0),
    Offset(760.0, 760.0)
  ];
  List<Offset> pointPositionM = [
    Offset(80.0, 80.0),
    Offset(760.0, 80.0),
    Offset(80.0, 760.0),
    Offset(760.0, 760.0)
  ];
  List<Offset> originCirclesM;
  List<double> radiuosCirclesM;
  List<Offset> originRectanglesM;
  List<double> widthRectanglesM;
  List<double> heightRectanglesM;

  List<double> radiusPolygonM;
  List<Offset> centerPolygonM;
  Offset startCenterM;
  Offset endCenterM;
  double radiuosStartM = 45;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);
  final _textPainter2 = TextPainter(textDirection: TextDirection.ltr);
  final _textPainter3 = TextPainter(textDirection: TextDirection.ltr);
  final _textPainter4 = TextPainter(textDirection: TextDirection.ltr);
  double coeffScreenMapHeight;
  double coeffScreenMapWidth;
  MapShapeMaker(
      coeffScreenMapWidth,
      this.coeffScreenMapHeight,
      this.numRectangles,
      this.originRectangles,
      this.widthRectangles,
      this.heightRectangles,
      this.numCircles,
      this.originCircles,
      this.radiuosCircles,
      this.numPolygons,
      this.sidesofPolygon,
      this.radiusPolygon,
      this.centerPolygon,
      this.startCenter,
      this.endCenter,
      this.mapHitColor) {
    _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
    _paintStartEnd = Paint()
      ..color = Colors.green
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;

    // print(originRectangles[0].dx);
    // print('coeff' + coeffScreenMapWidth.toString());
    originCirclesM = new List<Offset>(numCircles);
    radiuosCirclesM = new List<double>(numCircles);

    for (int i = 0; i < numCircles; i++) {
      originCirclesM[i] = Offset(originCircles[i].dx * coeffScreenMapWidth,
          originCircles[i].dy * coeffScreenMapHeight);
      radiuosCirclesM[i] = radiuosCircles[i] * coeffScreenMapWidth;
    }

    radiuosStartM = radiuosStart * coeffScreenMapWidth;

    originRectanglesM = new List<Offset>(numRectangles);
    widthRectanglesM = new List<double>(numRectangles);
    heightRectanglesM = new List<double>(numRectangles);

    for (int i = 0; i < numRectangles; i++) {
      originRectanglesM[i] = Offset(
          originRectangles[i].dx * coeffScreenMapWidth,
          originRectangles[i].dy * coeffScreenMapHeight);
      widthRectanglesM[i] = widthRectangles[i] * coeffScreenMapWidth;
      heightRectanglesM[i] = heightRectangles[i] * coeffScreenMapHeight;
    }

    centerPolygonM = new List<Offset>(numPolygons);
    radiusPolygonM = new List<double>(numPolygons);
    startCenterM = Offset(startCenter.dx * coeffScreenMapWidth,
        startCenter.dy * coeffScreenMapHeight);
    endCenterM = Offset(endCenter.dx * coeffScreenMapWidth,
        endCenter.dy * coeffScreenMapHeight);

    for (int i = 0; i < numPolygons; i++) {
      centerPolygonM[i] = Offset(centerPolygon[i].dx * coeffScreenMapWidth,
          centerPolygon[i].dy * coeffScreenMapHeight);
      radiusPolygonM[i] = radiusPolygon[i] * coeffScreenMapWidth;
    }

    for (int i = 0; i < 4; i++) {
      pointPositionM[i] = Offset(pointPosition[i].dx * coeffScreenMapWidth,
          pointPosition[i].dy * coeffScreenMapHeight);
    }
  }

  Path createPolygonPath(int i) {
    final path = Path();
    var angle = (math.pi * 2) / sidesofPolygon[i];
    Offset firstPoint = Offset(
        radiusPolygonM[i] * math.cos(0.0), radiusPolygonM[i] * math.sin(0.0));
    path.moveTo(firstPoint.dx + centerPolygonM[i].dx,
        firstPoint.dy + centerPolygonM[i].dy);
    for (int j = 1; j <= sidesofPolygon[i]; j++) {
      double x = radiusPolygonM[i] * math.cos(angle * j) + centerPolygonM[i].dx;
      double y = radiusPolygonM[i] * math.sin(angle * j) + centerPolygonM[i].dy;
      path.lineTo(x, y);
    }
    path.close();
    return path;
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
    for (int i = 0; i < numCircles; i++) {
      double x = ((originCirclesM[i].dx));
      double y = (originCirclesM[i].dy);
      canvas.drawCircle(
          Offset(x, y),
          radiuosCirclesM[i],
          _paint
            ..color = Color.fromRGBO(mapHitColor['Circles'][i], 0, 255, 1.0));
    }

    for (int i = 0; i < numRectangles; i++) {
      // canvas.translate(0, 90);
      // canvas.rotate(1.3);
      canvas.drawRect(
          Rect.fromCenter(
              center: Offset(originRectanglesM[i].dx, originRectanglesM[i].dy),
              width: widthRectanglesM[i],
              height: heightRectanglesM[i]),
          _paint
            ..color =
                Color.fromRGBO(mapHitColor['Rectangles'][i], 0, 255, 1.0));
    }

    for (int i = 0; i < numPolygons; i++) {
      Path path = createPolygonPath(i);
      canvas.drawPath(
          path,
          _paint
            ..color = Color.fromRGBO(mapHitColor['Polygons'][i], 0, 255, 1.0));
    }

    canvas.drawPath(
        createStartPath(pointPositionM[2], radiuosStartM),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        createStartPath(pointPositionM[2], radiuosStartM - 10),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        createStartPath(pointPositionM[3], radiuosStartM),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        createStartPath(pointPositionM[3], radiuosStartM - 10),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);

    _textPainter2.text = TextSpan(
        text: pointOrder[1],
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    _textPainter2.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    _textPainter.text = TextSpan(
        text: pointOrder[0],
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    _textPainter3.text = TextSpan(
        text: pointOrder[2],
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    _textPainter3.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    _textPainter4.text = TextSpan(
        text: pointOrder[3],
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    _textPainter4.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    canvas.drawPath(
        createStartPath(pointPositionM[0], radiuosStartM),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        createStartPath(pointPositionM[0], radiuosStartM - 10),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        createStartPath(pointPositionM[1], radiuosStartM),
        Paint()
          ..color = Colors.green
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        createStartPath(pointPositionM[1], radiuosStartM - 10),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill);

    _textPainter.paint(
        canvas, Offset(pointPositionM[0].dx - 6, pointPositionM[0].dy - 5));
    _textPainter2.paint(
        canvas, Offset(pointPositionM[1].dx - 6, pointPositionM[1].dy - 5));
    _textPainter3.paint(
        canvas, Offset(pointPositionM[2].dx - 6, pointPositionM[2].dy - 5));
    _textPainter4.paint(
        canvas, Offset(pointPositionM[3].dx - 6, pointPositionM[3].dy - 5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
