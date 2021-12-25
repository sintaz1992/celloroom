import 'package:flutter/material.dart';
//import 'package:flutter_png/flutter_png.dart';
import 'package:dashboard/widgets/linePainter.Dart';

Widget celluloMap(
  String gridPath,
  int trial,
  int turn,
  int acID,
  bool robotpatternSwitch,
  List<double> celluloxPositiontopaint,
  List<double> celluloyPositiontopaint,
  double mapSizeScreenWidth,
  double mapSizeScreenHeight,
) {
  // Activity-Dependent
  var imagespath = [
   [
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
    [
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
    [
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
    [
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1.png',
      'assets/images/Ac6_function2.png',
      'assets/images/Ac6_function3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
 
   
 
    [
      [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
     'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
      'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
    [
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
     [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      [
       'assets/images/Ac6_function1_trial1.png',
      'assets/images/Ac6_function1_trial2.png',
      'assets/images/Ac6_function1_trial3.png',
      // 'assets/images/GridOnlyPositive.png',
    ],
      // 'assets/images/GridOnlyPositive.png',
    ],
    
  ];
  // 'assets/images/GridOnlyPositive.png',

  

  List<double> normalizecellulopath(List<double> path) {
    List<double> pathnorm = new List();
    for (int i = 0; i < path.length; i++) {
      pathnorm.add(path[i] * mapSizeScreenWidth );
    }
    return pathnorm;
  }

  return Stack(children: <Widget>[
    Image.asset(imagespath[acID][turn - 1][trial]),
   // Image.asset(gridPath),
    CustomPaint(
            size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
            painter: LinePainter2(normalizecellulopath(celluloxPositiontopaint),
                normalizecellulopath(celluloyPositiontopaint)),
          )
        ,
  ]);
}

Widget celluloMap2(
    int turn,
    int acID,
    bool robotpatternSwitch,
    List<double> cellulovxPositiontopaint,
    List<double> cellulovyPositiontopaint,
    List<double> celluloxxPositiontopaint,
    List<double> celluloxyPositiontopaint,
    List<double> celluloyxPositiontopaint,
    List<double> celluloyyPositiontopaint,
    double mapSizeScreenWidth,
    double mapSizeScreenHeight) {
  // Activity-Dependent

  // 'assets/images/GridOnlyPositive.png',

  final double mapSizeWidth = 500;
  final double mapSizeHeight = 500;

  List<double> normalizecellulopath(List<double> path) {
    List<double> pathnorm = new List();
    //print(path);
    for (int i = 0; i < path.length; i++) {
      pathnorm.add(path[i] * mapSizeScreenWidth / mapSizeWidth);
    }
    return pathnorm;
  }

  return Stack(children: <Widget>[
    CustomPaint(
      size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
      painter: LinePainter3(normalizecellulopath(cellulovxPositiontopaint),
          normalizecellulopath(cellulovyPositiontopaint), [100, 00, 100]),
    ),
    CustomPaint(
      size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
      painter: LinePainter3(normalizecellulopath(celluloxxPositiontopaint),
          normalizecellulopath(celluloxyPositiontopaint), [200, 0, 100]),
    ),
    CustomPaint(
      size: Size(mapSizeScreenWidth, mapSizeScreenHeight),
      painter: LinePainter3(normalizecellulopath(celluloyxPositiontopaint),
          normalizecellulopath(celluloyyPositiontopaint), [20, 0, 200]),
    ),
  ]);
}
