import 'dart:async';
import 'dart:math' as math;
import 'package:student/model/Cellulo.dart';
import 'package:student/services/app_translations.dart';
import 'package:flutter/widgets.dart';
import 'package:student/model/student.dart';
import 'package:flutter/material.dart';
import 'package:student/widgets/message.dart';
import 'package:student/commonFunctions/checkstartgame.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:student/widgets/clearPosition.dart';

class Game5 extends ChangeNotifier {
  String instructionTextR = 'Waiting to start the game';
  String instructionTextB = 'Waiting to start the game';
  String instructionText =
      'Guide your teammates to find the spacemans while avoiding the rocks';
  List<double> targetx = [0.0];
  List<double> targety = [0.0];
  double currentTaregt = 0;
  List<List<double>> celluloxPositiontopaint =
      new List.generate(3, (int index) => [0.0, 0.0], growable: true);
  List<List<double>> celluloyPositiontopaint =
      new List.generate(3, (int index) => [0.0, 0.0], growable: true);
  bool allowPaint = false;
  List<int> saved = [0, 0];
  AnimationController controller;
  Timer curvesetpositiontimer;
  Timer animationlifespaceman;
  Timer timerColorButton;
  double step = 0.0;
  bool startGameV = false;
  double progress = 0.5;
  Offset beginpath = new Offset(70.0, 200.0);
  Offset endpath = new Offset(270.0, 300.0);
  bool trybuttonshow = false;
  double animationvalue = 0.0;
  int reward = 0;
  int counter = 0;
  bool istargetvisible = false;
  var originCoordinates = [123.5, 736.5];
  List<double> maptransferx = [0.05, 0.17, 0.29, 0.42, 0.55, 0.68, 0.80];
  List<double> maptransfery = [0.81, 0.67, 0.54, 0.42, 0.29, 0.16, 0.035];
  List<double> spacemantruex = [4, 4, 2, 7, 4, 3, 5, 7, 5, 2, 2, 1, 4, 3, 5, 4];
  List<double> spacemantruey = [6, 3, 7, 4, 4, 5, 2, 6, 7, 3, 2, 5, 6, 3];
  bool showreport = false;
  int activespaceman = 0;
  int limittime = 10;
  Timer changecolortasktext;
  Timer changecolortasktext2;
  Timer crashtimer;
  Timer reachendtimer;
  Timer animationtimer;
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
  Timer timerCelluloPositionPaint;
  Offset targetposition = new Offset(0.0, 0.0);
  Game5();
  bool gameover = false;
  bool showinstructionT = true;
  String tasktext = '';
  bool showinstruction = true;
  int maxreward = 5;
  double prevx = 0.0;
  double prevy = 0.0;

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

  List<double> valuelifespaceman = [
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
  ];
  List<double> velocity = [0.0, 0.0];
  List<double> a = [-0.5, -0.5, -2.5];
  int currenttrial = 0;
  int numtrials = 3;
  List<double> b = [1.0, 1.0, 1.0];

  List<double> c = [0.0, 0.0, 0.0];

  double score = 0.0;
  Timer timergamerules;
  Timer checkinitialposition;

  Timer timerfinishgame;
  int timealive = 4;
  List<Offset> celluloxpath = [Offset(0, 0)];
  List<Offset> celluloypath = [Offset(0, 0)];
  var targetpathx =
      List.generate(5, (i) => List.generate(1, (j) => 0.0), growable: true);
  var targetpathy =
      List.generate(5, (i) => List.generate(1, (j) => 0.0), growable: true);

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

  void startgameposition() {
    student.acgame5.showinstructionT = true;
    student.acgame5.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("robot_start_game_position");
    checkinitialposition =
        new Timer.periodic(new Duration(milliseconds: 400), (time) {
      if ((checkstartgame(student.cellulox.x, student.celluloy.y))) {
        celluloxPositiontopaint[0] = [0.0, 0.0];
        celluloyPositiontopaint[0] = [0.0, 0.0];
        clearPosition(currenttrial, 5);
        allowPaint = true;
        startGameV = true;
        student.acgame5.showinstructionT = false;
        student.acgame5.instructionText = '';
        animationvalue = 0.0;
        animationtimer = new Timer.periodic(new Duration(seconds: 1), (time) {
          animationvalue = animationvalue + 1 / limittime;
          student.acgame5.notifyListeners();
          if (animationvalue > (limittime - 1) / limittime) {
            animationtimer.cancel();
          }
        });
        checkinitialposition.cancel();
      }
    });
  }

  void newtrial() {
    student.velocityx[(student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = velocity[0] * student.mapSizeHeightfull / limittime;
    student.velocityy[(student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = -velocity[1] * student.mapSizeHeightfull / limittime;

    student.error[(student.groupCurrentTurn - 1) * numtrials + currenttrial] =
        score;
    student.dbSessionRef.collection("velocity").doc(student.groupname).update({
      'velocityx': student.velocityx,
      'velocityy': student.velocityy,
      'error': student.error,
    });
    score = 0;
    velocity = [0.0, 0.0];
    student.acgame5.currenttrial = student.acgame5.currenttrial + 1;
    celluloxPositiontopaint[0] = [0.0, 0.0];
    celluloyPositiontopaint[0] = [0.0, 0.0];
    clearPosition(currenttrial, 5);
    trybuttonshow = false;

    if (animationvalue <= (limittime - 1) / limittime) {
      animationtimer.cancel();
    }

    startGameV = false;

    counter = 0;

    animationvalue = 0.0;
    startgameposition();
    notifyListeners();
  }

  void reachend() {
    student.reachendV = true;
    student.acgame5.showinstruction = true;
    student.acgame5.showinstructionT = true;
    instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("victoryEnd");
    animationvalue = 0;
    student.dbGroupRef.collection("gamevents").add({
      "event": 'reachend',
      'number': activespaceman,
      'Ac': student.currentActivity,
      'turn': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });

    student.acgame5.notifyListeners();

    student.activityTime[4] =
        ((student.elapseTimer.elapsedMilliseconds - student.starttimer[4]) /
                1000)
            .round();
    student.dbSessionRef.collection("scores").doc(student.groupname).update({
      'time': student.activityTime,
    });

    print('vel');

    print(velocity);
//    print(velocity[0] / limittime);
    //  print(velocity[1] / limittime);
    student.velocityx[(student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = velocity[0] * student.mapSizeHeightfull / limittime;
    student.velocityy[(student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = -velocity[1] * student.mapSizeHeightfull / limittime;

    student.error[(student.groupCurrentTurn - 1) * numtrials + currenttrial] =
        score;
    student.dbSessionRef.collection("velocity").doc(student.groupname).update({
      'velocityx': student.velocityx,
      'velocityy': student.velocityy,
      'error': student.error,
    });
    score = 0;
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
    student.acgame5.startgame = true;
    student.permisMoveV = true;

    student.acgame5.instructionText = '';
    student.acgame5.showinstruction = true;
    student.acgame5.showinstructionT = false;
    student.acgame5.notifyListeners();
    //  allowPaint = false;
    velocity = [0.0, 0.0];
    counter = 0;

    prevx = student.cellulox.x;
    prevy = student.celluloy.y;
    timerCelluloPositionPaint =
        new Timer.periodic(new Duration(milliseconds: 100), (time) {
      if (allowPaint == true) {
        counter = counter + 1;
        celluloxPositiontopaint[0].add(student.cellulox.x);
        celluloyPositiontopaint[0].add(student.celluloy.y);

        score = score +
            (a[currenttrial] *
                            (student.cellulox.x * 2 - 1) *
                            student.mapSizeHeightfull /
                            2 /
                            66.1 +
                        b[currenttrial] *
                            (-student.celluloy.y * 2 + 1) *
                            student.mapSizeHeightfull /
                            2 /
                            66.1)
                    .abs() /
                math.sqrt(math.pow(a[currenttrial], 2) +
                    math.pow(b[currenttrial], 2));

        print('x');

        print((student.cellulox.x * 2 - 1) *
            student.mapSizeHeightfull /
            2 /
            66.1);
        print('y');

        print((-student.celluloy.y * 2 + 1) *
            student.mapSizeHeightfull /
            2 /
            66.1);

        print('score');

        print((a[currenttrial] *
                        (student.cellulox.x * 2 - 1) *
                        student.mapSizeHeightfull /
                        2 /
                        66.1 +
                    b[currenttrial] *
                        (-student.celluloy.y * 2 + 1) *
                        student.mapSizeHeightfull /
                        2 /
                        66.1)
                .abs() /
            math.sqrt(
                math.pow(a[currenttrial], 2) + math.pow(b[currenttrial], 2)));

        //student.gscore[4] = score.toInt();

        velocity[0] = velocity[0] + student.cellulox.x - prevx;
        velocity[1] = velocity[1] + student.celluloy.y - prevy;

        prevx = student.cellulox.x;
        prevy = student.celluloy.y;

        student.dbSessionRef
            .collection("celluloPosition")
            .doc(student.groupname)
            .collection('Activities')
            .doc('5')
            .collection('turns')
            .doc(student.groupCurrentTurn.toString())
            .collection('trials')
            .doc(currenttrial.toString())
            .collection("celluloPosition")
            .doc(counter.toString())
            .set({
          "x": student.cellulox.x,
          "y": student.celluloy.y,
          'time': student.elapseTimer.elapsedMilliseconds
        });
      }
    });
    currenttrial = 0;
    animationtimer = new Timer.periodic(new Duration(seconds: 1), (time) {
      animationvalue = animationvalue + 1 / limittime;
      student.acgame5.notifyListeners();
      if (animationvalue > (limittime - 1) / limittime) {
        animationtimer.cancel();
      }
    });

    reachendtimer = new Timer.periodic(new Duration(seconds: 1), (time) {
      if (checkendgame(student.cellulox.x, student.celluloy.y) && startGameV) {
        if (animationvalue <= (limittime - 1) / limittime) {
          animationtimer.cancel();
        }

        if (currenttrial == numtrials - 1) {
          reachend();

          timerCelluloPositionPaint.cancel();
          reachendtimer.cancel();
        } else {
          trybuttonshow = true;
          startGameV = false;
          allowPaint = false;
        }
      }
    });
    // notifyListeners();

    student.acgame5.tasktext =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("instruction_followline_ac5");

    student.dbGroupRef.collection("gamevents").add({
      "event": 'startgame',
      'finishedactivity': student.currentActivity,
      'turnto': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });
  }

  void begingame() {
    showinstructionT = true;
    student.acgame5.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("robot_start_game_position");
    tasktext = '';
    student.scoreV = 0;

    for (int i = 6; i > 0; i--) {
      cellulox.setColor(0, 0, 0, 1, i - 1, 0);
    }
    for (int i = 6; i > 0; i--) {
      celluloy.setColor(0, 0, 0, 1, i - 1, 1);
    }
    student.acgame5.startgame = false;
    student.reachendV = false;
    startGameV = false;
    student.acgame5.reward = 0;
    student.acgame5.showreport = false;
    // initialposition();
    celluloxPositiontopaint[0] = [0.0, 0.0];
    celluloyPositiontopaint[0] = [0.0, 0.0];
    currenttrial = 0;
    clearPosition(currenttrial, 5);

    checkinitialposition =
        new Timer.periodic(new Duration(milliseconds: 400), (time) {
      if ((checkstartgame(student.cellulox.x, student.celluloy.y))) {
        startGameV = true;
        allowPaint = true;
        funcstartgame();

        checkinitialposition.cancel();
      }
    });
  }
}
