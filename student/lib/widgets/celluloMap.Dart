import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:student/widgets/onlineRobotMap.Dart';

Widget celluloMap(
  BuildContext context,
  List<List<double>> celluloxPositiontopaint,
  List<List<double>> celluloyPositiontopaint,
  celluloxPosition,
  celluloyPosition,
  String workspacePath,
  String targetLinePath,
  String celluloXPath,
  String celluloYPath,
  double mapSizeWidth,
  double mapSizeHeight,
  String xlabel,
  String ylabel,
  var xlabelposition,
  var ylabelposition,
  var lineallow,
) {
  final double mapSizeScreenWidth = 500;
  final double mapSizeScreenHeight = 500;
  final double celluloSize = 48;
  final double scaleWidth = mapSizeScreenWidth / mapSizeWidth;
  final double scaleHeight = mapSizeScreenHeight / mapSizeHeight;
  return Container(
      height: mapSizeScreenWidth,
      width: mapSizeScreenHeight,
      decoration: BoxDecoration(),
      child: Stack(children: <Widget>[
        Container(
            height: mapSizeScreenWidth,
            width: mapSizeScreenHeight,
            child: Image.asset(targetLinePath)),
        Container(
            height: mapSizeScreenWidth,
            width: mapSizeScreenHeight,
            child: Image.asset(workspacePath)),
        Container(
            width: mapSizeScreenWidth,
            height: mapSizeScreenHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  //  x: Alignment(
                  //     2 * ((celluloyPosition[0] + 40) / mapSizeWidth) - 1,
                  //   2 * ((celluloyPosition[1] + 40) / mapSizeHeight) - 1),
                  left: (celluloxPosition[0] + celluloxPosition[0]) /
                          2 *
                          mapSizeScreenWidth /
                          mapSizeWidth -
                      30,
                  top: (celluloyPosition[1] + celluloyPosition[1]) /
                          2 *
                          mapSizeScreenHeight /
                          mapSizeHeight -
                      30,
                  width: 60,
                  height: 60,
                  child: Card(
                    child: Image.asset("assets/images/celluloPurple.png",
                        height: 60, width: 60),
                  ),
                ),
              ],
            )),
        Container(
            width: mapSizeScreenWidth,
            height: mapSizeScreenHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  //  x: Alignment(
                  //     2 * ((celluloyPosition[0] + 40) / mapSizeWidth) - 1,
                  //   2 * ((celluloyPosition[1] + 40) / mapSizeHeight) - 1),
                  left: (celluloxPosition[0]) *
                          mapSizeScreenWidth /
                          mapSizeWidth -
                      30,
                  top: (celluloxPosition[1]) *
                          mapSizeScreenHeight /
                          mapSizeHeight -
                      30,
                  width: 60,
                  height: 60,
                  child: Card(
                    child: Image.asset("assets/images/celluloRed.png",
                        height: 60, width: 60),
                  ),
                ),
              ],
            )),
        Container(
            width: mapSizeScreenWidth,
            height: mapSizeScreenHeight,
            child: Stack(
              children: <Widget>[
                Positioned(
                  //  x: Alignment(
                  //     2 * ((celluloyPosition[0] + 40) / mapSizeWidth) - 1,
                  //   2 * ((celluloyPosition[1] + 40) / mapSizeHeight) - 1),
                  left: (celluloyPosition[0]) *
                          mapSizeScreenWidth /
                          mapSizeWidth -
                      30,
                  top: (celluloyPosition[1]) *
                          mapSizeScreenHeight /
                          mapSizeHeight -
                      30,
                  width: 60,
                  height: 60,
                  child: Card(
                    child: Image.asset("assets/images/celluloBlue.png",
                        height: 60, width: 60),
                  ),
                ),
              ],
            )),
        Align(
          alignment: Alignment(xlabelposition[0], xlabelposition[1]),
          child: Text(
            xlabel,
            style: new TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment(ylabelposition[0], ylabelposition[1]),
          child: Text(
            ylabel,
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        (lineallow[0])
            ? CustomPaint(
                size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
                painter: LinePainter2(celluloxPositiontopaint[0],
                    celluloyPositiontopaint[0], Colors.blue),
              )
            : Text(''),
        (lineallow[1])
            ? CustomPaint(
                size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
                painter: LinePainter2(celluloxPositiontopaint[1],
                    celluloyPositiontopaint[1], Colors.green),
              )
            : Text(''),
        (lineallow[2])
            ? CustomPaint(
                size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
                painter: LinePainter2(celluloxPositiontopaint[2],
                    celluloyPositiontopaint[2], Colors.yellow),
              )
            : Text(''),
      ]));
}
