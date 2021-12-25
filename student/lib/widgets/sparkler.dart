import 'dart:math';
import 'package:flutter/material.dart';
import 'particle.dart';

class Sparkler extends StatefulWidget {
  @override
  _SparklerState createState() => _SparklerState();
}

class _SparklerState extends State<Sparkler> {
  final double width = 300;
  final double progress = 0.5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: width,
      child: SizedBox(
          height: 100,
          child: Stack(
            children: getParticles(),
          )),
    ));
  }

  List<Widget> getParticles() {
    List<Widget> particles = List();
    double width = 300;
    particles.add(CustomPaint(
        painter: StickPainter(progress: progress), child: Container()));

    int maxParticles = 160;
    for (var i = 1; i <= maxParticles; i++) {
      if (progress >= 1) {
        continue;
      }
      particles.add(Padding(
          padding: EdgeInsets.only(left: progress * width, top: 20),
          child: Transform.rotate(
              angle: maxParticles / i * pi,
              child: Padding(
                  padding: EdgeInsets.only(top: 30), child: Particle()))));
    }

    return particles;
  }
}

class StickPainter extends CustomPainter {
  StickPainter({@required this.progress, this.height = 4});

  final double progress;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    double burntStickHeight = height * 0.15;
    double burntStickWidth = progress * size.width;

    _drawBurntStick(burntStickHeight, burntStickWidth, size, canvas);
    _drawIntactStick(burntStickWidth, size, canvas);
  }

  void _drawIntactStick(double burntStickWidth, Size size, Canvas canvas) {
    Paint paint = Paint()..color = Color.fromARGB(255, 100, 100, 100);

    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(burntStickWidth, size.height / 2 - height / 2,
              size.width - burntStickWidth, height),
          Radius.circular(3)));

    canvas.drawPath(path, paint);
  }

  void _drawBurntStick(double burntStickHeight, double burntStickWidth,
      Size size, Canvas canvas) {
    double startHeat = progress - 0.1 <= 0 ? 0 : progress - 0.1;
    double endHeat = progress + 0.05 >= 1 ? 1 : progress + 0.05;

    LinearGradient gradient = LinearGradient(colors: [
      Color.fromARGB(255, 80, 80, 80),
      Color.fromARGB(255, 100, 80, 80),
      Colors.red,
      Color.fromARGB(255, 130, 100, 100),
      Color.fromARGB(255, 130, 100, 100)
    ], stops: [
      0,
      startHeat,
      progress,
      endHeat,
      1.0
    ]);

    Paint paint = Paint();
    Rect rect = Rect.fromLTWH(0, size.height / 2 - burntStickHeight / 2,
        size.width, burntStickHeight);
    paint.shader = gradient.createShader(rect);

    Path path = Path()..addRect(rect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
