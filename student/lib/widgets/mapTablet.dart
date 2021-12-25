import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/commonFunctions/poserocks.dart';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:student/gameDynamic/Ac3.dart';
import 'package:student/model/student.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:student/widgets/arrow.dart';
import 'package:student/widgets/guidegrid.dart';
import 'package:student/widgets/guideTarget.dart';
import 'package:student/widgets/onlineRobotMap.Dart';

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
  final double mapSizeWidthfull = 860;
  final double mapSizeHeightfull = 860;
  final double screenWidth = student.playgroundheight;
  final double screenHeight = student.playgroundheight;

  double celluloxleft = 0.0;
  double celluloxtop = 0.0;
  double celluloyleft = 0.0;
  double celluloytop = 0.0;
  double prevCelluloxx = 0.0;
  double prevCelluloxy = 0.0;
  double prevCelluloyx = 0.0;
  double prevCelluloyy = 0.0;
  final String mapPath = 'assets/images/Grid_Ac5_Screen.png';

  final List<String> linesPath = [
    'assets/images/Ac5/Ac5_function1_trial1.png',
    'assets/images/Ac5/Ac5_function1_trial2.png',
    'assets/images/Ac5/Ac5_function1_trial3.png',
    'assets/images/Ac5/Ac5_function2_trial1.png',
    'assets/images/Ac5/Ac5_function2_trial2.png',
    'assets/images/Ac5/Ac5_function2_trial3.png',
    'assets/images/Ac5/Ac5_function3_trial1.png',
    'assets/images/Ac5/Ac5_function3_trial2.png',
    'assets/images/Ac5/Ac5_function3_trial3.png',
    'assets/images/Ac6/Ac6_function1_trial1.png',
    'assets/images/Ac6/Ac6_function1_trial2.png',
    'assets/images/Ac6/Ac6_function1_trial3.png',
    'assets/images/Ac6/Ac6_function2_trial1.png',
    'assets/images/Ac6/Ac6_function2_trial2.png',
    'assets/images/Ac6/Ac6_function2_trial3.png',
    'assets/images/Ac6/Ac6_function3_trial1.png',
    'assets/images/Ac6/Ac6_function3_trial2.png',
    'assets/images/Ac6/Ac6_function3_trial3.png',
    'assets/images/Ac7/Ac7_function1_trial1.png',
    'assets/images/Ac7/Ac7_function1_trial2.png',
    'assets/images/Ac7/Ac7_function1_trial3.png',
    'assets/images/Ac7/Ac7_function2_trial1.png',
    'assets/images/Ac7/Ac7_function2_trial2.png',
    'assets/images/Ac7/Ac7_function2_trial3.png',
    'assets/images/Ac7/Ac7_function3_trial1.png',
    'assets/images/Ac7/Ac7_function3_trial2.png',
    'assets/images/Ac7/Ac7_function3_trial3.png',
    'assets/images/Ac6_function1_trial1.png',
    'assets/images/Ac6_function1_trial2.png',
    'assets/images/Ac6_function1_trial3.png',
    'assets/images/Ac6_function2_trial1.png',
    'assets/images/Ac6_function2_trial2.png',
    'assets/images/Ac6_function2_trial3.png',
    'assets/images/Ac6_function3_trial1.png',
    'assets/images/Ac6_function3_trial2.png',
    'assets/images/Ac6_function3_trial3.png',
    'assets/images/Ac9/Ac9_function1_trial1.png',
    'assets/images/Ac9/Ac9_function1_trial2.png',
    'assets/images/Ac9/Ac9_function1_trial3.png',
    'assets/images/Ac9/Ac9_function2_trial1.png',
    'assets/images/Ac9/Ac9_function2_trial2.png',
    'assets/images/Ac9/Ac9_function2_trial3.png',
    'assets/images/Ac9/Ac9_function3_trial1.png',
    'assets/images/Ac9/Ac9_function3_trial2.png',
    'assets/images/Ac9/Ac9_function3_trial3.png',
    'assets/images/island7.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];

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

  Offset endpoint(int currenttrial) {
    List<Offset> liststartpoint =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['endCenter'];
    return liststartpoint[currenttrial];
  }

  Offset startpoint(int currenttrial) {
    List<Offset> liststartpoint =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['startCenter'];
    return liststartpoint[currenttrial];
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

  void _handleMouseGesture(DragUpdateDetails details) {
    setState(() {
      // if delta is positive -> movement down
      if (details.primaryDelta > 0.0) {
        student.acgame7.cellulov.y = student.acgame7.cellulov.y +
            details.primaryDelta / student.playgroundheight;
        if (student.acgame7.cellulov.y > 0.95) {
          student.acgame7.cellulov.y = 0.95;
        }
        // if delta is negative -> movement up
      } else {
        student.acgame7.cellulov.y = student.acgame7.cellulov.y +
            details.primaryDelta / student.playgroundheight;
        if (student.acgame7.cellulov.y < 0) {
          student.acgame7.cellulov.y = 0;
        }
      }
    });

    student.acgame7.celluloxPositiontopaintvirtual
        .add(student.acgame7.cellulov.x);
    student.acgame7.celluloyPositiontopaintvirtual
        .add(student.acgame7.cellulov.y);
  }

  void _handleMouseGesture2(DragUpdateDetails details) {
    // if delta is positive -> movement down
    if (details.delta.dx > 0.0) {
      student.acgame7.cellulov.x = student.acgame7.cellulov.x +
          details.delta.dx / student.playgroundheight;
      if (student.acgame7.cellulov.x > 0.95) {
        student.acgame7.cellulov.x = 0.95;
      }
      // if delta is negative -> movement up
    } else {
      student.acgame7.cellulov.x = student.acgame7.cellulov.x +
          details.delta.dx / student.playgroundheight;
      if (student.acgame7.cellulov.x < 0) {
        student.acgame7.cellulov.x = 0;
      }
    }

    if (details.delta.dy > 0.0) {
      student.acgame7.cellulov.y = student.acgame7.cellulov.y +
          details.delta.dy / student.playgroundheight;
      if (student.acgame7.cellulov.y > 0.95) {
        student.acgame7.cellulov.y = 0.95;
      }
      // if delta is negative -> movement up
    } else {
      student.acgame7.cellulov.y = student.acgame7.cellulov.y +
          details.delta.dy / student.playgroundheight;
      if (student.acgame7.cellulov.y < 0) {
        student.acgame7.cellulov.y = 0;
      }
    }

    student.acgame7.celluloxPositiontopaintvirtual
        .add(student.acgame7.cellulov.x);
    student.acgame7.celluloyPositiontopaintvirtual
        .add(student.acgame7.cellulov.y);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  void dispose() {
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

                          (student.currentActivity == 'Ac5')
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: Image.asset(
                                    mapPath,
                                  ),
                                )
                              : Text(''),
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
                          (student.currentActivity == 'Ac2' ||
                                  student.currentActivity == 'Ac3' ||
                                  student.currentActivity == 'Ac4')
                              ? Positioned(
                                  left: student.cellulox.x *
                                      student.playgroundheight,
                                  top: student.playgroundheight -
                                      student.cellulosize -
                                      5 / 500 * student.playgroundheight,
                                  child: Image.asset(
                                      student.groupCurrentTurn == 3
                                          ? "assets/images/manM.png"
                                          : "assets/images/manR.png",
                                      height: student.cellulosize * 0.75,
                                      width: student.cellulosize * 0.75),
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
                          (student.currentActivity == 'Ac2' ||
                                  student.currentActivity == 'Ac3' ||
                                  student.currentActivity == 'Ac4')
                              ? Positioned(
                                  left: 5 / 500 * student.playgroundheight,
                                  top: student.celluloy.y *
                                      student.playgroundheight,
                                  child: Image.asset(
                                      student.groupCurrentTurn == 2
                                          ? "assets/images/manM.png"
                                          : "assets/images/manB.png",
                                      height: student.cellulosize * 0.75,
                                      width: student.cellulosize * 0.75),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac2' ||
                                  student.currentActivity == 'Ac3' ||
                                  student.currentActivity == 'Ac4')
                              ? Positioned(
                                  left: student.cellulox.x *
                                      student.playgroundheight,
                                  top: (student.celluloy.y) *
                                      student.playgroundheight,
                                  child: Image.asset(
                                      "assets/images/celluloPurple.png",
                                      height: student.cellulosize,
                                      width: student.cellulosize),
                                )
                              : Text(''),
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
                  for (int i = 0;
                      i <
                          student.mapShape[student.acList
                                  .indexOf(student.currentActivity)]
                              [student.groupCurrentTurn - 1]['numCircles'];
                      i++)
                    ((student.currentActivity == 'Ac1') &&
                            (i == student.acgame1.activespaceman))
                        ? Positioned(
                            left: posecirclex(i),
                            top: posecircley(i),
                            child: FittedBox(
                              child: RotationTransition(
                                  turns: _animation,
                                  child: Image.asset(radObstaclePath[i],
                                      height: radcircle(i),
                                      width: radcircle(i))),
                              fit: BoxFit.fill,
                            ),
                          )
                        : Text(''),
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
                  for (int i = 0;
                      i <
                          student.mapShape[student.acList
                                  .indexOf(student.currentActivity)]
                              [student.groupCurrentTurn - 1]['numPolygons'];
                      i++)
                    (((student.currentActivity == 'Ac2') &&
                            (i == student.acgame2.activestar)))
                        ? Positioned(
                            left: posepolx(i),
                            top: posepoly(i),
                            child: Image.asset(polObstaclePath[i],
                                height: radpol(i), width: radpol(i)),
                          )
                        : Text(''),
                  for (int i = 0;
                      i <
                          student.mapShape[student.acList
                                  .indexOf(student.currentActivity)]
                              [student.groupCurrentTurn - 1]['numPolygons'];
                      i++)
                    Consumer<Game4>(
                        builder: (context, model, child) =>
                            (student.currentActivity == 'Ac4' &&
                                    i == student.acgame4.activespaceman &&
                                    student.reachendV == false)
                                ? Positioned(
                                    left: posepolx(i),
                                    top: posepoly(i),
                                    child: RotationTransition(
                                      turns: _animation,
                                      child: Image.asset(polspacemanPath[i],
                                          height: radpol(i), width: radpol(i)),
                                    ))
                                : Text('')),
                  for (int i = 0;
                      i <
                          student.mapShape[student.acList
                                  .indexOf(student.currentActivity)]
                              [student.groupCurrentTurn - 1]['numPolygons'];
                      i++)
                    Consumer<Game3>(
                        builder: (context, model, child) =>
                            (student.currentActivity == 'Ac3' &&
                                    i == student.acgame3.activespaceman &&
                                    student.reachendV == false)
                                ? Positioned(
                                    left: posepolx(i),
                                    top: posepoly(i),
                                    child: RotationTransition(
                                      turns: _animation,
                                      child: Image.asset(polspacemanPath[i],
                                          height: radpol(i), width: radpol(i)),
                                    ))
                                : Text('')),
                  for (int i = 0;
                      i <
                          student.mapShape[student.acList
                                  .indexOf(student.currentActivity)]
                              [student.groupCurrentTurn - 1]['numPolygons'];
                      i++)
                    Consumer<Game4>(
                        builder: (context, model, child) => (student
                                        .currentActivity ==
                                    'Ac4' &&
                                student.acgame4.showreport == true)
                            ? Positioned(
                                left: posepolx(i),
                                top: posepoly(i),
                                child: GestureDetector(
                                  child: (student.acgame4.spacemanVisible[i] ==
                                          1)
                                      ? Image.asset(
                                          "assets/images/spacescorefull.png",
                                          height: radpol(i),
                                          width: radpol(i))
                                      : Image.asset(
                                          "assets/images/spacescoredead.png",
                                          height: radpol(i),
                                          width: radpol(i)),
                                  onTap: () {
                                    student.acgame4.visiblespacemanafter = [
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false
                                    ];
                                    student.acgame4.visiblespacemanafter[i] =
                                        true;
                                  },
                                ))
                            : Text('')),
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
            : Container(
                width: student.playgroundheight,
                height: student.playgroundheight,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Stack(children: <Widget>[
                  Container(
                      width: student.playgroundheight,
                      height: student.playgroundheight,
                      child: Stack(
                        children: <Widget>[
                          (student.currentActivity == 'Ac5')
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 0 / 500 * student.playgroundheight),
                                  child: Image.asset(
                                      linesPath[(student.acList.indexOf(
                                                      student.currentActivity) -
                                                  4) *
                                              9 +
                                          (student.groupCurrentTurn - 1) *
                                              student.acgame5.numtrials +
                                          student.acgame5.currenttrial],
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : Text(''),
                          (student.currentActivity == 'Ac6')
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 0 / 500 * student.playgroundheight),
                                  child: Image.asset(
                                      linesPath[(student.acList.indexOf(
                                                      student.currentActivity) -
                                                  4) *
                                              9 +
                                          (student.groupCurrentTurn - 1) *
                                              student.acgame6.numtrials +
                                          student.acgame6.currenttrial],
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : Text(''),
                          (student.currentActivity == 'Ac9')
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 0 / 500 * student.playgroundheight),
                                  child: Image.asset(
                                      linesPath[(student.acList.indexOf(
                                                      student.currentActivity) -
                                                  4) *
                                              9 +
                                          (student.groupCurrentTurn - 1) *
                                              student.acgame9.numtrials +
                                          student.acgame9.currenttrial],
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : Text(''),
                          (student.currentActivity == 'Ac7' &&
                                  !student.acgame7.emptygridshow)
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 0 / 500 * student.playgroundheight),
                                  child: Image.asset(
                                      linesPath[(student.acList.indexOf(
                                                      student.currentActivity) -
                                                  4) *
                                              9 +
                                          (student.groupCurrentTurn - 1) *
                                              student.acgame7.numtrials +
                                          student.acgame7.currenttrial],
                                      height: student.playgroundheight,
                                      width: student.playgroundheight))
                              : (student.currentActivity == 'Ac7')
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: 0 /
                                              500 *
                                              student.playgroundheight),
                                      child: Image.asset(
                                          'assets/images/emptygrid.png',
                                          height: student.playgroundheight,
                                          width: student.playgroundheight))
                                  : Text(''),
                          (student.currentActivity == 'Ac6')
                              ? Positioned(
                                  left: startpoint(student.acgame6.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: startpoint(student.acgame6.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/start.png",
                                      height: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac9')
                              ? Positioned(
                                  left: startpoint(student.acgame9.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: startpoint(student.acgame9.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/start.png",
                                      height: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac9')
                              ? Positioned(
                                  left: endpoint(student.acgame9.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: endpoint(student.acgame9.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/finish.png",
                                      height: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac5')
                              ? Positioned(
                                  left: endpoint(student.acgame5.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: endpoint(student.acgame5.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/finish.png",
                                      height: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac5')
                              ? Positioned(
                                  left: startpoint(student.acgame5.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: startpoint(student.acgame5.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/start.png",
                                      height: 100 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 100 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                          /*
                          (student.currentActivity == 'Ac7')
                              ? Positioned(
                                  left: endpoint(student.acgame7.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: endpoint(student.acgame7.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/finish.png",
                                      height: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 75 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac7')
                              ? Positioned(
                                  left: startpoint(student.acgame7.currenttrial)
                                          .dx *
                                      student.playgroundheight /
                                      mapSizeWidthfull,
                                  top: startpoint(student.acgame7.currenttrial)
                                          .dy *
                                      student.playgroundheight /
                                      mapSizeHeightfull,
                                  child: Image.asset("assets/images/start.png",
                                      height: 100 *
                                          student.playgroundheight /
                                          mapSizeWidthfull,
                                      width: 100 *
                                          student.playgroundheight /
                                          mapSizeWidthfull),
                                )
                              : Text(''),
                         */
                          (student.currentActivity == 'Ac5')
                              ? CustomPaint(
                                  size: Size(student.playgroundheight,
                                      student.playgroundheight),
                                  painter: LinePainter2(
                                      student
                                          .acgame5.celluloxPositiontopaint[0],
                                      student
                                          .acgame5.celluloyPositiontopaint[0],
                                      Colors.blue),
                                )
                              : Text(''),
                          /*
                          (student.currentActivity == 'Ac5')
                              ? CustomPaint(
                                  size: Size(student.playgroundheight,
                                      student.playgroundheight),
                                  painter: LinePainter2([
                                    0,
                                    0,
                                    startpoint(student.acgame5.currenttrial)
                                                .dx /
                                            mapSizeHeightfull +
                                        50 / mapSizeHeightfull,
                                    (startpoint(student.acgame5.currenttrial)
                                                .dx +
                                            50 +
                                            student.acgame5.animationvalue *
                                                (endpoint(student.acgame5
                                                            .currenttrial)
                                                        .dx -
                                                    startpoint(student.acgame5
                                                            .currenttrial)
                                                        .dx -
                                                    (25) / 2)) /
                                        mapSizeHeightfull,
                                    0
                                  ], [
                                    0,
                                    0,
                                    startpoint(student.acgame5.currenttrial)
                                                .dy /
                                            mapSizeHeightfull +
                                        50 / mapSizeWidthfull,
                                    (startpoint(student.acgame5.currenttrial)
                                                .dy +
                                            50 +
                                            student.acgame5.animationvalue *
                                                (endpoint(student.acgame5
                                                            .currenttrial)
                                                        .dy -
                                                    startpoint(student.acgame5
                                                            .currenttrial)
                                                        .dy -
                                                    (25) / 2)) /
                                        mapSizeHeightfull,
                                    0
                                  ], Colors.pink),
                                )
                              : Text(''),
                              */
                          (student.currentActivity == 'Ac6')
                              ? CustomPaint(
                                  size: Size(student.playgroundheight,
                                      student.playgroundheight),
                                  painter: LinePainter2(
                                      student
                                          .acgame6.celluloxPositiontopaint[0],
                                      student
                                          .acgame6.celluloyPositiontopaint[0],
                                      Colors.blue),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac9')
                              ? CustomPaint(
                                  size: Size(student.playgroundheight,
                                      student.playgroundheight),
                                  painter: LinePainter2(
                                      student
                                          .acgame9.celluloxPositiontopaint[0],
                                      student
                                          .acgame9.celluloyPositiontopaint[0],
                                      Colors.blue),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac7' &&
                                  student.acgame7.showline)
                              ? CustomPaint(
                                  size: Size(student.playgroundheight,
                                      student.playgroundheight),
                                  painter: LinePainter2(
                                      student
                                          .acgame7.celluloxPositiontopaint[0],
                                      student
                                          .acgame7.celluloyPositiontopaint[0],
                                      Colors.blue),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac7')
                              ? CustomPaint(
                                  size: Size(student.playgroundheight,
                                      student.playgroundheight),
                                  painter: LinePainter2(
                                      student.acgame7
                                          .celluloxPositiontopaintvirtual,
                                      student.acgame7
                                          .celluloyPositiontopaintvirtual,
                                      Colors.green),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac5' ||
                                  student.currentActivity == 'Ac6' ||
                                  student.currentActivity == 'Ac9')
                              ? Positioned(
                                  left: student.cellulox.x *
                                      student.playgroundheight,
                                  top: (student.celluloy.y) *
                                      student.playgroundheight,
                                  child: Image.asset(
                                      "assets/images/celluloPurple.png",
                                      height: student.cellulosize,
                                      width: student.cellulosize),
                                )
                              : Text(''),
                          (student.currentActivity == 'Ac7')
                              ? Positioned(
                                  left: (student.acgame7.cellulov.x) *
                                      student.playgroundheight,
                                  top: (student.acgame7.cellulov.y) *
                                      student.playgroundheight,
                                  child: Draggable(
                                      child: Image.asset(
                                          "assets/images/celluloPurple.png",
                                          height: student.cellulosize,
                                          width: student.cellulosize),
                                      feedback: Text(''),
                                      onDragUpdate: (e) {
                                        _handleMouseGesture2(e);
                                      }))
                              : Text(''),
                        ],
                      )),
                ]),
              ));
  }
}
