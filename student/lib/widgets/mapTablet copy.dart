import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:student/gameDynamic/Ac3.dart';
import 'package:student/model/student.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:student/widgets/arrow.dart';
import 'package:student/widgets/guidegrid.dart';
import 'package:student/widgets/guideTarget.dart';

class Map extends StatefulWidget {
  final int curTurn;
  Map({Key key, this.curTurn}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with TickerProviderStateMixin {
  Timer timerCelluloPosition;
  List<int> ages = [1, 2, 4];
  AnimationController _controller;
  Animation<double> _animation;
  final double mapSizeWidth = 760;
  final double mapSizeHeight = 760;
  final double screenWidth = student.playgroundheight;
  final double screenHeight = student.playgroundheight;
  static Offset startPoint =
      student.mapShape[student.acList.indexOf(student.currentActivity)]
          [student.groupCurrentTurn - 1]['startCenter'];

  double celluloxleft = 0.0;
  double celluloxtop = 0.0;
  double celluloyleft = 0.0;
  double celluloytop = 0.0;
  double prevCelluloxx = 0.0;
  double prevCelluloxy = 0.0;
  double prevCelluloyx = 0.0;
  double prevCelluloyy = 0.0;
  final String mapPath = 'assets/images/Grid_Ac5_Screen.png';
  final List<String> radObstaclePath = [
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/starred.png',
    'assets/images/starblue.png',
    'assets/images/island3.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island6.png',
    'assets/images/island7.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];
  final List<String> recObstaclePath = [
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];
  final List<String> polObstaclePath = [
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/star.png',
    'assets/images/island3.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];

  final List<String> polspacemanPath = [
    'assets/images/spacer3.png',
    'assets/images/spacer2.png',
    'assets/images/spacer1.png',
    'assets/images/spacer1.png',
    'assets/images/spacer3.png',
    'assets/images/spacer2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island5.png',
    'assets/images/island4.png',
    'assets/images/island3.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];

  Offset origin = new Offset(106, 572.0); // should be calibrated for a new map
  var step = 75.0;

  double posecirclex(int i) {
    List<Offset> starposelist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['originCircles'];
    Offset starpose = starposelist[i];
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['radiuosCircles'];
    return starpose.dx * student.playgroundheight / mapSizeWidth -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  Offset endpoint() {
    return student.mapShape[student.acList.indexOf(student.currentActivity)]
        [student.groupCurrentTurn - 1]['endCenter'];
  }

  double posecircley(int i) {
    List<Offset> starposelist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['originCircles'];
    Offset starpose = starposelist[i];
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['radiuosCircles'];
    return starpose.dy * student.playgroundheight / mapSizeHeight -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radcircle(int i) {
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['radiuosCircles'];

    return 2 * radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radpol(int i) {
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['radiusPolygon'];

    return 2 * radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radrecw(int i) {
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['widthRectangles'];

    return radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radrech(int i) {
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['heightRectangles'];

    return radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double poserecx(int i) {
    List<Offset> starposelist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['originRectangles'];
    Offset starpose = starposelist[i];
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['widthRectangles'];
    return starpose.dx * student.playgroundheight / mapSizeWidth -
        radlist[i] / 2 * student.playgroundheight / mapSizeWidth;
  }

  double poserecy(int i) {
    List<Offset> starposelist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['originRectangles'];
    Offset starpose = starposelist[i];
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['heightRectangles'];

    return starpose.dy * student.playgroundheight / mapSizeHeight -
        radlist[i] / 2 * student.playgroundheight / mapSizeWidth;
  }

  double posepolx(int i) {
    List<Offset> starposelist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['centerPolygon'];
    Offset starpose = starposelist[i];
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['radiusPolygon'];
    return starpose.dx * student.playgroundheight / mapSizeWidth -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double posepoly(int i) {
    List<Offset> starposelist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['centerPolygon'];
    Offset starpose = starposelist[i];
    List<double> radlist =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['radiusPolygon'];
    return starpose.dy * student.playgroundheight / mapSizeHeight -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  @override
  void initState() {
    super.initState();

    // dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    //dbRef.child('students').child(student.id).child('currentActivity').set("Ac1");
    // elapseTimer.start();

    timerCelluloPosition = new Timer.periodic(
        new Duration(milliseconds: Student.serverSpeed), (time) {
      student.cellulov.x = (student.cellulox.x);

      student.cellulov.y = (student.celluloy.y);

      print(student.cellulox.x);
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void dispose() {
    timerCelluloPosition.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Consumer<Student>(
        builder: (context, model, child) => (student.currentActivity == 'Ac0' ||
                student.currentActivity == 'Ac1' ||
                student.currentActivity == 'Ac2' ||
                student.currentActivity == 'Ac3' ||
                student.currentActivity == 'Ac4')
            ? Container(
                width: student.playgroundheight,
                height: student.playgroundheight,
                child: Stack(children: <Widget>[
                  Container(
                      width: student.playgroundheight,
                      height: student.playgroundheight,
                      child: Stack(
                        children: <Widget>[
                          (student.currentActivity == 'Ac3' ||
                                  student.currentActivity == 'Ac2' ||
                                  student.currentActivity == 'Ac1' ||
                                  student.currentActivity == 'Ac4' ||
                                  student.currentActivity == 'Ac0')
                              ? Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Image.asset('assets/images/sea.png',
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : Text(''),
                          (student.currentActivity == 'Ac4')
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0 /
                                          500 *
                                          student.playgroundheight),
                                  child: Image.asset(
                                      'assets/images/Grid_Ac3_Screen.png',
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : Text(''),
                          (student.currentActivity == 'Ac2' ||
                                  student.currentActivity == 'Ac3')
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0 /
                                          500 *
                                          student.playgroundheight),
                                  child: Image.asset(
                                      'assets/images/Grid_Ac2_Screen.png',
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : Text(''),
                          /*
                          Positioned(
                            left: startPoint.dx *
                                student.playgroundheight /
                                mapSizeWidth,
                            top: startPoint.dy *
                                student.playgroundheight /
                                mapSizeHeight,
                            child: Image.asset("assets/images/start2.png",
                                height: 75 *
                                    student.playgroundheight /
                                    mapSizeWidth,
                                width: 75 *
                                    student.playgroundheight /
                                    mapSizeWidth),
                          ),
*/
                          /*
                          (student.currentActivity == 'Ac1' ||
                                  student.currentActivity == 'Ac2' ||
                                  student.currentActivity == 'Ac3')
                              ? Positioned(
                                  left: endpoint().dx *
                                          student.playgroundheight /
                                          mapSizeWidth -
                                      student.radfinish *
                                          student.playgroundheight /
                                          mapSizeHeight,
                                  top: endpoint().dy *
                                          student.playgroundheight /
                                          mapSizeHeight -
                                      student.radfinish *
                                          student.playgroundheight /
                                          mapSizeHeight,
                                  child: Image.asset("assets/images/finish.png",
                                      height:
                                          80 / 500 * student.playgroundheight,
                                      width:
                                          80 / 500 * student.playgroundheight),
                                )
                              : Text(''),
                              */
                          /*
                          Consumer<Game4>(
                              builder: (context, model, child) => (student
                                          .currentActivity ==
                                      'Ac4')
                                  ? Visibility(
                                      visible: student.acgame4.istargetvisible,
                                      child: Positioned(
                                        left: student.acgame4.targetposition.dx,
                                        top: student.acgame4.targetposition.dy,
                                        child: Image.asset(
                                            "assets/images/target2.png",
                                            height: 80 /
                                                500 *
                                                student.playgroundheight,
                                            width: 80 /
                                                500 *
                                                student.playgroundheight),
                                      ))
                                  : Text('')),
                                  */
                          /*
                          (student.currentActivity == 'Ac4' ||
                                  student.currentActivity == 'Ac5')
                              ? CustomPaint(
                                  //size: Size(200, 200),
                                  painter: BezierCurvePainter(
                                      student.mapShape[2]
                                              [student.groupCurrentTurn - 1]
                                          ['startCenter'],
                                      student.mapShape[2]
                                              [student.groupCurrentTurn - 1]
                                          ['endCenter'],
                                      screenWidth / mapSizeWidth,
                                      screenHeight / mapSizeHeight,
                                      student.groupCurrentTurn,
                                      15)
                                  //LinePainter2(celluloxPositiontopaint, celluloyPositiontopaint),

                                  )
                              : Text(''),
                              */

                          (student.currentActivity == 'Ac1' ||
                                  student.currentActivity == 'Ac0')
                              ? Positioned(
                                  left: student.cellulox.x *
                                      student.playgroundheight,
                                  top: student.cellulox.y *
                                      student.playgroundheight,
                                  child: Image.asset(
                                      "assets/images/celluloRed.png",
                                      height: student.cellulosize,
                                      width: student.cellulosize),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac1' ||
                                  student.currentActivity == 'Ac0')
                              ? Positioned(
                                  left: student.celluloy.x *
                                      student.playgroundheight,
                                  top: student.celluloy.y *
                                      student.playgroundheight,
                                  child: Image.asset(
                                      "assets/images/celluloBlue.png",
                                      height: student.cellulosize,
                                      width: student.cellulosize),
                                )
                              : Text(''),

/*
                          (student.currentActivity == 'Ac5')
                              ? CustomPaint(
                                  //size: Size(200, 200),
                                  painter: GuideGrid(
                                  origin,
                                  step,
                                  screenWidth / mapSizeWidth,
                                  screenHeight / mapSizeHeight,
                                  [student.cellulox.x, student.cellulox.y],
                                  [student.celluloy.x, student.celluloy.y],
                                ))
                              : Text(''),
                          */
                          /*
                          (student.currentActivity == 'Ac4')
                              ? Consumer<Game4>(
                                  builder: (context, model, child) =>
                                      Visibility(
                                          visible:
                                              student.acgame4.istargetvisible,
                                          child: CustomPaint(
                                              //size: Size(200, 200),
                                              painter: GuideTarget())))
                              : Text(''),
                              */
                          /*
                          (student.currentActivity == 'Ac6')
                              ? CustomPaint(
                                  //size: Size(200, 200),
                                  painter:
                                      //LinePainter2(celluloxPositiontopaint, celluloyPositiontopaint),
                                      Arrow(
                                  student.cellulox.x,
                                  student.celluloy.y,
                                  screenWidth / mapSizeWidth,
                                  screenHeight / mapSizeHeight,
                                  2,
                                  2,
                                ))
                              : Text(''),
                              */

                          /*
                          (student.currentActivity == 'Ac1' &&
                                  student.acgame1.showcrashY)
                              ? Positioned(
                                  left: student.celluloy.x *
                                          student.playgroundheight +
                                      10 / 500 * student.playgroundheight,
                                  top: student.celluloy.y *
                                          student.playgroundheight +
                                      10 / 500 * student.playgroundheight,
                                  child: Column(children: [
                                    Image.asset("assets/images/crash.jpg",
                                        height: student.cellulosize * 0.75,
                                        width: student.cellulosize * 0.75),
                                  ]))
                              : Text(''),
                          (student.currentActivity == 'Ac1' &&
                                  student.acgame1.showcrashX)
                              ? Positioned(
                                  left: student.cellulox.x *
                                          student.playgroundheight +
                                      10 / 500 * student.playgroundheight,
                                  top: student.cellulox.y *
                                          student.playgroundheight +
                                      10 / 500 * student.playgroundheight,
                                  child: Column(children: [
                                    Image.asset("assets/images/crash.jpg",
                                        height: student.cellulosize * 0.75,
                                        width: student.cellulosize * 0.75),
                                  ]))
                              : Text(''),
                          ((student.currentActivity == 'Ac2' &&
                                      student.acgame2.showcrash) ||
                                  (student.currentActivity == 'Ac3' &&
                                      student.acgame3.showcrash) ||
                                  (student.currentActivity == 'Ac4' &&
                                      student.acgame4.showcrash))
                              ? Positioned(
                                  left: student.cellulox.x *
                                          student.playgroundheight +
                                      10 / 500 * student.playgroundheight,
                                  top: student.celluloy.y *
                                          student.playgroundheight +
                                      10 / 500 * student.playgroundheight,
                                  child: Column(children: [
                                    Image.asset("assets/images/crash.jpg",
                                        height: student.cellulosize * 0.75,
                                        width: student.cellulosize * 0.75),
                                  ]))
                              : Text(''),
                              */
                        ],
                      )),

                  /*
                  for (int i = 0;
                      i <
                          student.mapShape[student.acList
                                  .indexOf(student.currentActivity)]
                              [student.groupCurrentTurn - 1]['numRectangles'];
                      i++)
                    (student.currentActivity == 'Ac2' ||
                            student.currentActivity == 'Ac3' ||
                            student.currentActivity == 'Ac1')
                        ? Positioned(
                            left: poserecx(i),
                            top: poserecy(i),
                            child: FittedBox(
                              child: Image.asset(recObstaclePath[i],
                                  height: radrech(i), width: radrecw(i)),
                              fit: BoxFit.fill,
                            ),
                          )
                        : Text(''),
                        */

                  /*
                  for (int j = 0; j < 5; j++)
                    for (int i = 0;
                        i < student.acgame4.targetpathx[j].length;
                        i++)
                      Consumer<Game4>(
                          builder: (context, model, child) => (student
                                      .currentActivity ==
                                  'Ac4')
                              ? Visibility(
                                  visible:
                                      student.acgame4.visiblespacemanafter[j] &&
                                          student.acgame4.showreport,
                                  child: Positioned(
                                    left: student.acgame4.targetpathx[j][i] *
                                        student.playgroundheight,
                                    top: student.acgame4.targetpathy[j][i] *
                                        student.playgroundheight,
                                    child: Image.asset(
                                        "assets/images/target2.png",
                                        height:
                                            80 / 500 * student.playgroundheight,
                                        width: 80 /
                                            500 *
                                            student.playgroundheight),
                                  ))
                              : Text('')),
                              */
                ]),
              )
            : Text(''));
  }
}
