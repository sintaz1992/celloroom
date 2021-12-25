import 'dart:async';
import 'dart:math' as math;
import 'package:student/model/Cellulo.dart';
import 'package:student/services/app_translations.dart';
import 'package:flutter/widgets.dart';
import 'package:student/model/student.dart';
import 'package:flutter/material.dart';
import 'package:student/widgets/message.dart';
import 'package:student/commonFunctions/checkstartgame.dart';

class Game3 extends ChangeNotifier {
  String instructionTextR = 'Waiting to start the game';
  String instructionTextB = 'Waiting to start the game';
  String instructionText =
      'Guide your teammates to find the spacemans while avoiding the rocks';
  List<double> targetx = [0.0];
  List<double> targety = [0.0];
  double currentTaregt = 0;
  List<int> saved = [0, 0];
  AnimationController controller;
  Timer curvesetpositiontimer;
  Timer animationlifespaceman;
  Timer timerColorButton;
  double step = 0.0;
  double progress = 0.5;
  Offset beginpath = new Offset(70.0, 200.0);
  Offset endpath = new Offset(270.0, 300.0);
  double totaltimeanimation = 20;
  int reward = 0;
  bool istargetvisible = false;
  List<double> maptransferx = [0.05, 0.17, 0.29, 0.42, 0.55, 0.68, 0.80];
  List<double> maptransfery = [0.81, 0.67, 0.54, 0.42, 0.29, 0.16, 0.035];
  List<double> spacemantruex = [4, 4, 2, 7, 4, 3, 5, 7, 5, 2, 2, 1, 4, 3, 5, 4];
  List<double> spacemantruey = [6, 3, 7, 4, 4, 5, 2, 6, 7, 3, 2, 5, 6, 3];
  bool showreport = false;
  int activespaceman = 0;
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "Here you can indicate the radar position",
        messageType: "receiver"),
  ];
  List<ChatMessage> messagesx = [
    ChatMessage(
        messageContent: "Here is the history of target commands",
        messageType: "receiver"),
  ];
  List<ChatMessage> messagesy = [
    ChatMessage(
        messageContent: "Here is the history of target commands",
        messageType: "receiver"),
  ];
  List<int> spacemanVisible = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  List<bool> spacemanalive = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  List<bool> spacemanpassed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Timer changecolortasktext;
  Timer changecolortasktext2;
  Timer crashtimer;
  int crashtime = 1000;
  bool showcrash = false;
  Color tasktextcolor = Colors.blueGrey;
// checkcellulorles
  bool enterBorder = false;
  bool startgame = false;
  bool enterBorderpolygon = false;
  bool insideBorder = false;
  int trappedPolygon = 0;
  int trappedCircle = 0;
  bool starttouch = false;
  double setx = 1;
  double sety = 1;

  Offset targetposition = new Offset(0.0, 0.0);
  Game3();
  bool gameover = false;
  bool showinstructionT = true;
  String tasktext = '';
  bool showinstruction = true;
  int maxreward = 5;
  Color startButtonColor = Colors.grey;
  Color chatcolor = Colors.green[200];
  List<bool> visiblespacemanafter = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool startGameV = false;
  double mapSizeWidth = 760;
  double mapSizeHeight = 760;
  List<double> valuelifespaceman = [
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  Timer timergamerules;
  Timer checkinitialposition;
  Timer timerlifespaceman;
  Timer timerfinishgame;
  int timealive = 4;
  List<Offset> celluloxpath = [Offset(0, 0)];
  List<Offset> celluloypath = [Offset(0, 0)];
  var targetpathx =
      List.generate(5, (i) => List.generate(1, (j) => 0.0), growable: true);
  var targetpathy =
      List.generate(5, (i) => List.generate(1, (j) => 0.0), growable: true);

  void targetSet(double targetx, double targety) {
    if ((targetx.toInt() - 1) > -1) {
      istargetvisible = true;
      student.acgame3.setx = targetx;
      student.acgame3.sety = targety;
      student.acgame3.targetposition = new Offset(
          maptransferx[targetx.toInt() - 1] * student.playgroundheight,
          maptransfery[targety.toInt() - 1] * student.playgroundheight);
      student.acgame3.targetpathx[activespaceman]
          .add(maptransferx[targetx.toInt() - 1]);
      student.acgame3.targetpathy[activespaceman]
          .add(maptransfery[targety.toInt() - 1]);
      //student.acgame4.notifyListeners();
    }
  }

  void targetClear() {
    istargetvisible = false;
  }

  void chnagecolor2() {
    chatcolor = Colors.orange;

    changecolortasktext2 =
        new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      chatcolor = Colors.green[300];
      changecolortasktext2.cancel();
      notifyListeners();
    });
  }

  void chnagecolor() {
    tasktextcolor = Colors.orange;

    changecolortasktext =
        new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      tasktextcolor = Colors.blueGrey;
      notifyListeners();
      changecolortasktext.cancel();
    });
  }

  void funcstartgame() {
    student.acgame3.startgame = true;
    student.permisMoveV = true;
    student.acgame3.timerset();

    student.acgame3.instructionText = '';
    student.acgame3.showinstruction = true;
    student.acgame3.showinstructionT = false;
    student.acgame3.notifyListeners();
    // notifyListeners();
    if ((student.role != 3 && student.is4person == true) ||
        (student.is4person == false)) {
      student.acgame3.tasktext =
          AppTranslations.of(student.navigatorKeygame.currentState.context)
              .text("instruction_40seconds");
    }
    student.dbGroupRef.collection("gamevents").add({
      "event": 'startgame',
      'finishedactivity': student.currentActivity,
      'turnto': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });
  }

  void definetimer() {
    dynamic mapShape = student.mapShape[2][student.groupCurrentTurn - 1];
    timerlifespaceman =
        new Timer.periodic(new Duration(seconds: timealive * 2), (time) {
      if (activespaceman < mapShape['numPolygons']) {
        if (spacemanVisible[activespaceman] == 0) {
          spacemanVisible[activespaceman] = -1;
          student.dbGroupRef.collection("gamevents").add({
            "event": 'dead',
            'object': 'spacman',
            'number': activespaceman,
            "cellulo": 'purple',
            'Ac': student.currentActivity,
            'turn': student.groupCurrentTurn,
            'timepassed': student.elapseTimer.elapsedMilliseconds
          });

          if (activespaceman < mapShape['numPolygons'] - 1) {
            activespaceman = activespaceman + 1;
            spacemanVisible[activespaceman] = 0;
          } else {
            reachend();
          }

          student.dbGroupRef.collection("spacemans").add({
            "value": spacemanVisible,
          });
        }
      }
    });
  }

  void reachend() {
    student.reachendV = true;
    student.acgame3.showinstruction = true;
    student.acgame3.showinstructionT = true;
    student.dbGroupRef.collection("spacemans").add({
      "value": spacemanVisible,
    });
    student.dbGroupRef.collection("gamevents").add({
      "event": 'reachend',
      'number': activespaceman,
      'Ac': student.currentActivity,
      'turn': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });
    timerlifespaceman.cancel();

    student.acgame3.notifyListeners();

    student.activityTime[2] =
        ((student.elapseTimer.elapsedMilliseconds - student.starttimer[2]) /
                1000)
            .round();
    student.dbSessionRef.collection("scores").doc(student.groupname).update({
      'time': student.activityTime,
    });
  }

  void begingame() {
    showinstructionT = true;
    startGameV = false;
    student.acgame3.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("robot_start_game_position");
    print('impassing ac3');
    tasktext = '';
    student.scoreV = 0;
    student.acgame3.spacemanVisible = [0, 0, 0, 0, 0, 0];
    for (int i = 6; i > 0; i--) {
      cellulox.setColor(0, 0, 0, 1, i - 1, 0);
    }
    for (int i = 6; i > 0; i--) {
      celluloy.setColor(0, 0, 0, 1, i - 1, 1);
    }
    student.acgame3.startgame = false;
    student.reachendV = false;
    // showinstructionT = false;
    student.acgame3.activespaceman = 0;
    student.acgame3.reward = 0;
    student.acgame3.showreport = false;
    student.acgame3.valuelifespaceman = [1, 0, 0, 0, 0, 0];
    student.acgame3.spacemanalive = [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true
    ];
    student.acgame3.spacemanpassed = [
      false,
      false,
      false,
      false,
      false,
      false,
    ];

    // initialposition();

    checkinitialposition =
        new Timer.periodic(new Duration(milliseconds: 400), (time) {
      if ((checkstartgame(student.cellulox.x, student.celluloy.y))) {
        funcstartgame();
        startGameV = true;
        /*
        if ((student.role != 3 && student.is4person) || (!student.is4person)) {
          student.acgame4.instructionText =
              AppTranslations.of(student.navigatorKeygame.currentState.context)
                  .text("instruction_beforestart");
          student.acgame4.showinstruction = true;
          student.acgame4.showinstructionT = true;
        } else {
          // student.acgame4.showinstruction = false;
          student.acgame4.showinstructionT = false;
        }

        {
          if (student.is4person) {
            if (student.role != 3) {
              student.acgame4.tasktext = AppTranslations.of(
                      student.navigatorKeygame.currentState.context)
                  .text("instruction_ac4_t");
            } else {
              tasktext = AppTranslations.of(
                      student.navigatorKeygame.currentState.context)
                  .text("guide4person");
            }
          } else {
            student.acgame4.tasktext = AppTranslations.of(
                    student.navigatorKeygame.currentState.context)
                .text("instruction_ac4_t");
          }
        }
        */
        checkinitialposition.cancel();
      }
    });
  }

  void timerset() {
    dynamic mapShape = student.mapShape[3][student.groupCurrentTurn - 1];
/*
    if (student.groupCurrentTurn == 1)
      animationlifespaceman =
          new Timer.periodic(new Duration(seconds: 1), (time) {
        valuelifespaceman[0] = valuelifespaceman[0] - 1 / timealive / 2;
        //   print(valuelifespaceman);
        if (valuelifespaceman[0] < 2 / timealive / 2) {
          valuelifespaceman[0] = 0;

          animationlifespaceman.cancel();
        }
      });
  
    if (student.groupCurrentTurn != 1) {
      animationlifespaceman.cancel();
      animationlifespaceman =
          new Timer.periodic(new Duration(seconds: 1), (time) {
        valuelifespaceman[0] = valuelifespaceman[0] - 1 / timealive / 2;
        //   print(valuelifespaceman);
        if (valuelifespaceman[0] < 2 / timealive / 2) {
          valuelifespaceman[0] = 0;

          animationlifespaceman.cancel();
        }
      });
    }
*/
    definetimer();
  }

/*
  void gameoverfunction() {
    if (student.scoreV <= 0 && gameover == false) {
      starttouch = false;
      gameover = true;

      student.permisMoveV = false;
      student.acgame4.showinstruction = true;

      student.acgame4.notifyListeners();

      if ((student.groupPolicy2[student.role - 1]
              [student.groupCurrentTurn - 1] !=
          'T')) showinstructionT = true;
      instructionText =
          AppTranslations.of(student.navigatorKeygame.currentState.context)
              .text("instruction_repair");
      student.acgame4.notifyListeners();
      //  onDataSend();
      playHandler('images/gameover.mp3');

      timergamerules = new Timer.periodic(new Duration(seconds: 15), (time) {
        showinstruction = false;
        showinstructionT = false;
        student.scoreV = student.scoreMax;
        student.listen();
        if (student.permisMoveV == false) student.permisMoveV = true;
        if (student.groupPolicy2[student.role - 1]
                [student.groupCurrentTurn - 1] ==
            'T') {
          student.dbGroupRef.update({
            'scoreV': student.scoreV,
          });
        }

        //starttouchX = false;
        gameover = false;

        timergamerules.cancel();
        playHandler('images/smb_powerup.mp3');

        instructionText = '';
      });

      if (student.report == true) {
        student.dbGroupRef.collection("gamevents").add({
          "event": 'gameover',
          'Ac': student.currentActivity,
          "cellulo": 'purple',
          'turn': student.groupCurrentTurn,
          "studentName": student.name,
          'timepassed': student.elapseTimer.elapsedMilliseconds
        });
      }
    }
  }
*/
  void checkCelluloGame() {
    dynamic mapShape = student.mapShape[2][student.groupCurrentTurn - 1];
/*
    for (int i = 0; i < mapShape['numCircles']; i++) {
      var distancePointCenter = math.sqrt(math.pow(
              ((student.cellulox.x) * student.playgroundheight +
                  student.cellulosize / 2 -
                  mapShape['originCircles'][i].dx *
                      student.playgroundheight /
                      mapSizeWidth),
              2) +
          math.pow(
              ((student.celluloy.y) * student.playgroundheight +
                  student.cellulosize / 2 -
                  mapShape['originCircles'][i].dy *
                      student.playgroundheight /
                      mapSizeHeight),
              2));
      if (distancePointCenter <=
          mapShape['radiuosCircles'][i] *
                  student.playgroundheight /
                  mapSizeHeight +
              student.cellulosize / 2 -
              10 / 500 * student.playgroundheight) {
        if (student.scoreV > 0 && student.reachendV == false) {
          if (enterBorder == false) {
            if (student.groupPolicy2[student.role - 1]
                    [student.groupCurrentTurn - 1] ==
                'T') {
              student.scoreV = student.scoreV - 1;
              student.listen();
              student.dbGroupRef.update({
                'scoreV': student.scoreV,
              });
            }
            if (student.report == true &&
                (student.groupPolicy2[student.role - 1]
                        [student.groupCurrentTurn - 1] ==
                    'R')) {
              student.dbGroupRef.collection("events").add({
                "type": 'scorechanged',
                "cellulo": 'red',
                'score': student.scoreV,
                'Ac': student.currentActivity,
                'turn': student.groupCurrentTurn,
                "studentName": student.name,
              });
            }
            // mapHitX[student.groupCurrentTurn - 1]['Circles'][i] =
            //   mapHitX[student.groupCurrentTurn - 1]['Circles'][i] + 1;

            //
            if (student.report == true &&
                (student.groupPolicy2[student.role - 1]
                        [student.groupCurrentTurn - 1] ==
                    'T')) {
              student.dbGroupRef.collection("gamevents").add({
                "type": 'hit',
                'object': 'circle',
                'number': i,
                "cellulo": 'red',
                'Ac': student.currentActivity,
                'turn': student.groupCurrentTurn,
                "studentName": student.name,
              });
            }

            playHandler('images/smb_coin.mp3');
            student.acgame4.showcrash = true;
            crashtimer = new Timer.periodic(
                new Duration(milliseconds: crashtime), (time) {
              student.acgame4.showcrash = false;
              crashtimer.cancel();
            });
            // starttouchX = false;
            enterBorder = true;

            trappedCircle = i;
          }

          break;
        }
      } else if (i == trappedCircle) {
        enterBorder = false;
      }
    }
*/
    //  gameoverfunction();
    if (student.acgame3.startGameV) {
      var distancePointCenter = math.sqrt(math.pow(
              ((student.cellulox.x) * student.playgroundheight +
                  student.cellulosize / 2 -
                  mapShape['centerPolygon'][activespaceman].dx *
                      student.playgroundheight /
                      mapSizeWidth),
              2) +
          math.pow(
              ((student.celluloy.y) * student.playgroundheight +
                  student.cellulosize / 2 -
                  mapShape['centerPolygon'][activespaceman].dy *
                      student.playgroundheight /
                      mapSizeHeight),
              2));

      if (distancePointCenter <=
          mapShape['radiusPolygon'][activespaceman] *
                  student.playgroundheight /
                  mapSizeHeight +
              student.cellulosize / 2 +
              0 / 500 * student.playgroundheight) {
        if (student.acgame3.reward < maxreward) {
          if (enterBorderpolygon == false) {
            student.acgame3.reward = student.acgame3.reward + 1;

            student.dbGroupRef.collection("rewards").add({
              "value": student.acgame3.reward,
              "studentName": student.name,
            });

            starttouch = false;
            enterBorderpolygon = true;

            if (student.report == true) {
              student.dbGroupRef.collection("gamevents").add({
                "event": 'save',
                'object': 'spacman',
                'number': activespaceman,
                "cellulo": 'purple',
                'Ac': student.currentActivity,
                'turn': student.groupCurrentTurn,
                'timepassed': student.elapseTimer.elapsedMilliseconds
              });
            }

            trappedPolygon = activespaceman;
            timerlifespaceman.cancel();
            spacemanVisible[activespaceman] = 1;
            colorRobots();
            if (activespaceman < (mapShape['numPolygons'] - 1)) {
              activespaceman = activespaceman + 1;
              // valuelifespaceman[activespaceman] = 1.0;

              student.dbGroupRef.collection("spacemans").add({
                "value": spacemanVisible,
              });

              definetimer();
            } else {
              reachend();
            }
          }
        }
      } else {
        enterBorderpolygon = false;
      }
    }
  }
}
