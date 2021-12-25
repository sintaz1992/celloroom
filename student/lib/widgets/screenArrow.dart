import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/model/student.dart';
import 'package:provider/provider.dart';
import 'package:student/widgets/animationSpacema.dart';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:student/widgets/checkcellulorules.dart';
import 'package:student/services/app_translations.dart';

class ScreenArrow extends StatefulWidget {
  final int curTurn;

  ScreenArrow({Key key, this.curTurn}) : super(key: key);

  @override
  _ScreenArrowState createState() => _ScreenArrowState();
}

class _ScreenArrowState extends State<ScreenArrow> {
  double step = 5 / 500;
  double end = 0.9;
  Widget build(BuildContext context) {
    return Container(
        width: (student.currentActivity == 'Ac4')
            ? 25 / 50 * student.playgroundheight
            : student.playgroundheight,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    color: Colors.blueGrey),
                width: 17 / 50 * student.playgroundheight,
                // height: 295,

                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: InkWell(
                          onTap: () {
                            if (student.permisMoveY) {
                              if (student.currentActivity == 'Ac1') {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'B')) {
                                  bool permis = checkCelluloGame(
                                      student.mapShape[student.acList
                                              .indexOf(student.currentActivity)]
                                          [student.groupCurrentTurn - 1],
                                      new Offset(
                                          student.celluloy.x +
                                              student.initialcellulosize /
                                                  2 /
                                                  500,
                                          student.celluloy.y -
                                              step +
                                              student.initialcellulosize /
                                                  2 /
                                                  500),
                                      0);
                                  //print(permis);
                                  if (permis)
                                  // print('p presses');
                                  {
                                    if (!student.reachendY)
                                      //  student.acgame1.showinstructionB = false;
                                      student.celluloy.y =
                                          student.celluloy.y - step;
                                    if (student.celluloy.y < 0) {
                                      student.celluloy.y = 0;
                                    }
                                  }
                                }
                              }
                            }

                            if (student.permisMoveX) {
                              if (student.currentActivity == 'Ac1') {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'R')) {
                                  bool permis = checkCelluloGame(
                                      student.mapShape[student.acList
                                              .indexOf(student.currentActivity)]
                                          [student.groupCurrentTurn - 1],
                                      new Offset(
                                          student.cellulox.x +
                                              student.initialcellulosize /
                                                  2 /
                                                  500,
                                          student.cellulox.y -
                                              step +
                                              student.initialcellulosize /
                                                  2 /
                                                  500),
                                      0);
                                  //print(permis);
                                  if (permis)
                                  // print('p presses');
                                  {
                                    if (!student.reachendX)
                                      // student.acgame1.showinstructionR = false;
                                      student.cellulox.y =
                                          student.cellulox.y - step;
                                    if (student.cellulox.y < 0) {
                                      student.cellulox.y = 0;
                                    }
                                  }
                                }
                              }
                            }

                            if (student.currentActivity == 'Ac2' ||
                                student.currentActivity == 'Ac3' ||
                                student.currentActivity == 'Ac4') {
                              if (student.permisMoveV) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'B')) {
                                  {
                                    bool permis = true;

                                    permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.cellulox.x +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.celluloy.y -
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);

                                    if (permis) {
                                      if (student.currentActivity == 'Ac2' &&
                                          !student.reachendV)
                                        student.acgame2.showinstruction = false;
                                      if (student.currentActivity == 'Ac3' &&
                                          !student.reachendV)
                                        student.acgame3.showinstruction = false;
                                      if (student.currentActivity == 'Ac4' &&
                                          !student.reachendV)
                                        student.acgame4.showinstruction = false;
                                      student.celluloy.y =
                                          student.celluloy.y - step;
                                      if (student.celluloy.y < 0) {
                                        student.celluloy.y = 0;
                                      }
                                    }
                                    // This will only print useful information in debug mode.
                                    //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';

                                  }
                                }
                              }
                            }
                          },
                          child: Image.asset("assets/images/up.png",
                              height: student.playgroundheight * 50 / 500,
                              width: student.playgroundheight * 50 / 500))),
                ]),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.blueGrey),
                width: 17 / 50 * student.playgroundheight,

                // height: 295,

                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: InkWell(
                          onTap: () {
                            if (student.currentActivity == 'Ac1') {
                              if (student.permisMoveY) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'B')) {
                                  {
                                    bool permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.celluloy.x -
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.celluloy.y +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);
                                    if (permis) {
                                      if (!student.reachendY)
                                        // student.acgame1.showinstructionB =
                                        false;
                                      student.celluloy.x =
                                          student.celluloy.x - step;
                                      if (student.celluloy.x < 0) {
                                        student.celluloy.x = 0;
                                      }
                                      // This will only print useful information in debug mode.
                                      //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
                                    }
                                  }
                                }
                              }
                            }

                            if (student.currentActivity == 'Ac1') {
                              if (student.permisMoveY) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'R')) {
                                  {
                                    bool permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.cellulox.x -
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.cellulox.y +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);
                                    if (permis) {
                                      if (!student.reachendX)
                                        //  student.acgame1.showinstructionR =
                                        false;
                                      student.cellulox.x =
                                          student.cellulox.x - step;
                                      if (student.cellulox.x < 0) {
                                        student.cellulox.x = 0;
                                      }
                                      // This will only print useful information in debug mode.
                                      //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
                                    }
                                  }
                                }
                              }
                            }

                            if (student.currentActivity == 'Ac2' ||
                                student.currentActivity == 'Ac3' ||
                                student.currentActivity == 'Ac4') {
                              if (student.permisMoveV) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'R')) {
                                  {
                                    // print('p presses');
                                    bool permis = true;

                                    permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.cellulox.x -
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.celluloy.y +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);

                                    if (permis) {
                                      if (student.currentActivity == 'Ac2' &&
                                          !student.reachendV)
                                        student.acgame2.showinstruction = false;
                                      if (student.currentActivity == 'Ac3' &&
                                          !student.reachendV)
                                        student.acgame3.showinstruction = false;
                                      if (student.currentActivity == 'Ac4' &&
                                          !student.reachendV)
                                        student.acgame4.showinstruction = false;
                                      student.cellulox.x =
                                          student.cellulox.x - step;
                                      if (student.cellulox.x < 0) {
                                        student.cellulox.x = 0;
                                      }
                                    }
                                    // This will only print useful information in debug mode.
                                    //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';

                                    // This will only print useful information in debug mode.
                                    //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
                                  }
                                }
                              }
                            }
                          },
                          child: Image.asset("assets/images/left.png",
                              height: student.playgroundheight * 50 / 500,
                              width: student.playgroundheight * 50 / 500))),
                  SizedBox(width: student.playgroundheight * 60 / 500),
                  InkWell(
                      onTap: () {
                        {
                          if (student.currentActivity == 'Ac1') {
                            if (student.permisMoveY) {
                              if ((student.groupPolicy[student.role - 1]
                                      [student.groupCurrentTurn - 1] ==
                                  'B')) {
                                // print('p presses');
                                bool permis = checkCelluloGame(
                                    student.mapShape[student.acList
                                            .indexOf(student.currentActivity)]
                                        [student.groupCurrentTurn - 1],
                                    new Offset(
                                        student.celluloy.x +
                                            step +
                                            student.initialcellulosize /
                                                2 /
                                                500,
                                        student.celluloy.y +
                                            student.initialcellulosize /
                                                2 /
                                                500),
                                    0);
                                if (permis) {
                                  if (!student.reachendY)
                                    // student.acgame1.showinstructionB = false;
                                    student.celluloy.x =
                                        student.celluloy.x + step;
                                  if (student.celluloy.x > end) {
                                    student.celluloy.x = end -
                                        student.initialcellulosize / 2 / 500;
                                  }
                                }
                              }
                            }
                          }

                          if (student.currentActivity == 'Ac1') {
                            if (student.permisMoveX) {
                              if ((student.groupPolicy[student.role - 1]
                                      [student.groupCurrentTurn - 1] ==
                                  'R')) {
                                // print('p presses');
                                bool permis = checkCelluloGame(
                                    student.mapShape[student.acList
                                            .indexOf(student.currentActivity)]
                                        [student.groupCurrentTurn - 1],
                                    new Offset(
                                        student.cellulox.x +
                                            step +
                                            student.initialcellulosize /
                                                2 /
                                                500,
                                        student.cellulox.y +
                                            student.initialcellulosize /
                                                2 /
                                                500),
                                    0);
                                if (permis) {
                                  if (!student.reachendX)
                                    // student.acgame1.showinstructionR = false;
                                    student.cellulox.x =
                                        student.cellulox.x + step;
                                  if (student.cellulox.x > end) {
                                    student.cellulox.x = end -
                                        student.initialcellulosize / 2 / 500;
                                  }
                                }
                              }
                            }
                          }

                          if (student.currentActivity == 'Ac2' ||
                              student.currentActivity == 'Ac3' ||
                              student.currentActivity == 'Ac4') {
                            if (student.permisMoveV) {
                              if ((student.groupPolicy[student.role - 1]
                                      [student.groupCurrentTurn - 1] ==
                                  'R')) {
                                {
                                  // print('p presses');
                                  bool permis = true;

                                  permis = checkCelluloGame(
                                      student.mapShape[student.acList
                                              .indexOf(student.currentActivity)]
                                          [student.groupCurrentTurn - 1],
                                      new Offset(
                                          student.cellulox.x +
                                              step +
                                              student.initialcellulosize /
                                                  2 /
                                                  500,
                                          student.celluloy.y +
                                              student.initialcellulosize /
                                                  2 /
                                                  500),
                                      0);

                                  if (permis) {
                                    if (student.currentActivity == 'Ac2' &&
                                        !student.reachendV)
                                      student.acgame2.showinstruction = false;
                                    if (student.currentActivity == 'Ac3' &&
                                        !student.reachendV)
                                      student.acgame3.showinstruction = false;
                                    if (student.currentActivity == 'Ac4' &&
                                        !student.reachendV)
                                      student.acgame4.showinstruction = false;
                                    student.cellulox.x =
                                        student.cellulox.x + step;
                                    if (student.cellulox.x > end) {
                                      student.cellulox.x = end -
                                          student.initialcellulosize / 2 / 500;
                                    }
                                  }
                                  // This will only print useful information in debug mode.
                                  //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';

                                  // This will only print useful information in debug mode.
                                  //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
                                }
                              }
                            }
                          }
                        }
                      },
                      child: Image.asset("assets/images/right.png",
                          height: student.playgroundheight * 50 / 500,
                          width: student.playgroundheight * 50 / 500))
                ]),
              ),
              Container(
                // height: 295,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.blueGrey),
                width: 17 / 50 * student.playgroundheight,

                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                        Widget>[
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: InkWell(
                          onTap: () {
                            if (student.currentActivity == 'Ac1') {
                              if (student.permisMoveY) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'B')) {
                                  {
                                    bool permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.celluloy.x +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.celluloy.y +
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);
                                    //print(permis);
                                    if (permis)
                                    // print('p presses');
                                    {
                                      if (!student.reachendY)
                                        // student.acgame1.showinstructionB =
                                        false;
                                      student.celluloy.y =
                                          student.celluloy.y + step;
                                      if (student.celluloy.y > end) {
                                        student.celluloy.y = end -
                                            student.initialcellulosize /
                                                2 /
                                                500;
                                      }
                                    }
                                  }
                                }
                              }
                            }

                            if (student.currentActivity == 'Ac1') {
                              if (student.permisMoveX) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'R')) {
                                  {
                                    bool permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.cellulox.x +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.cellulox.y +
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);
                                    //print(permis);
                                    if (permis)
                                    // print('p presses');
                                    {
                                      if (!student.reachendX)
                                        // student.acgame1.showinstructionR =
                                        false;
                                      student.cellulox.y =
                                          student.cellulox.y + step;
                                      if (student.cellulox.y > end) {
                                        student.cellulox.y = end -
                                            student.initialcellulosize /
                                                2 /
                                                500;
                                      }
                                    }
                                  }
                                }
                              }
                            }

                            if (student.currentActivity == 'Ac2' ||
                                student.currentActivity == 'Ac3' ||
                                student.currentActivity == 'Ac4') {
                              if (student.permisMoveV) {
                                if ((student.groupPolicy[student.role - 1]
                                        [student.groupCurrentTurn - 1] ==
                                    'B')) {
                                  {
                                    bool permis = true;

                                    permis = checkCelluloGame(
                                        student.mapShape[student.acList.indexOf(
                                                student.currentActivity)]
                                            [student.groupCurrentTurn - 1],
                                        new Offset(
                                            student.cellulox.x +
                                                student.initialcellulosize /
                                                    2 /
                                                    500,
                                            student.celluloy.y +
                                                step +
                                                student.initialcellulosize /
                                                    2 /
                                                    500),
                                        0);

                                    //print(permis);
                                    if (permis)
                                    // print('p presses');
                                    {
                                      if (student.currentActivity == 'Ac2' &&
                                          !student.reachendV)
                                        student.acgame2.showinstruction = false;
                                      if (student.currentActivity == 'Ac3' &&
                                          !student.reachendV)
                                        student.acgame3.showinstruction = false;
                                      if (student.currentActivity == 'Ac4' &&
                                          !student.reachendV)
                                        student.acgame4.showinstruction = false;
                                      student.celluloy.y =
                                          student.celluloy.y + step;
                                      if (student.celluloy.y > end) {
                                        student.celluloy.y = end -
                                            student.initialcellulosize /
                                                2 /
                                                500;
                                      }
                                    }
                                    // This will only print useful information in debug mode.
                                    //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';

                                    // This will only print useful information in debug mode.
                                    //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
                                  }
                                }
                              }
                            }
                          },
                          child: Image.asset("assets/images/down.png",
                              height: student.playgroundheight * 50 / 500,
                              width: student.playgroundheight * 50 / 500))),
                ]),
              ),
            ])));
  }
}
