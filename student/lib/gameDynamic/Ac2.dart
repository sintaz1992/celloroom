import 'dart:async';
import 'package:student/commonFunctions/checkstartgame.dart';

import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:student/commonFunctions/groupnames.dart';
//import 'package:student/commonFunctions/initialposition.dart';
//import 'package:student/widgets/showAlertDialog.Dart';
//import 'package:student/Database.dart';
import 'package:student/model/student.dart';
import 'package:student/commonFunctions/playaudio.dart';
import 'package:flutter/material.dart';
import 'package:student/services/app_translations.dart';
import 'package:student/model/Cellulo.dart';

class Game2 extends ChangeNotifier {
  String instructionTextR = '';
  String instructionTextB = '';
  String instructionText = '';
  AnimationController controller;
  Timer curvesetpositiontimer;
  Timer animationlifespaceman;
  double step = 0.0;
  double progress = 0.5;
  double radiuosStart = 45;
  Offset beginpath = new Offset(70.0, 200.0);
  Offset endpath = new Offset(270.0, 300.0);
  double totaltimeanimation = 20;
  int reward = 0;
  bool startGameV;
  Color tasktextcolor = Colors.blueGrey;
// checkcellulorles
  int activestar = 0;

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
  Game2();
  bool gameover = false;
  bool showinstructionT = true;
  String tasktext = '';
  bool showinstruction = true;
  int maxreward = 5;
  int countertostart = 5;
  Timer crashtimer;
  int crashtime = 1000;
  bool showcrash = false;
  double mapSizeWidth = 760;
  double mapSizeHeight = 760;
  Timer timergamerules;
  Timer timerlifespaceman;
  Timer timerfinishgame;
  int timealive = 40;
  Timer timerstartGame2;
  Timer changecolortasktext;
  Timer checkinitialposition;
  Timer timerstartGame;
  void finishgame() {
    timerfinishgame = new Timer.periodic(new Duration(seconds: 5), (time) {
      student.dbGroupRef.update({
        'currentActivity': 'Acf',
      });
      timerfinishgame.cancel();
    });
  }

  void chnagecolor() {
    tasktextcolor = Colors.orange;

    changecolortasktext =
        new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      tasktextcolor = Colors.blueGrey;
      changecolortasktext.cancel();
    });
  }

  void begingame() {
    showinstruction = true;
    startGameV = false;
    student.acgame2.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("robot_start_game_position");
    print('impassing ac2');
    tasktext = '';
    student.scoreV = 0;
    colorRobots();
    activestar = 0;
    checkinitialposition =
        new Timer.periodic(new Duration(milliseconds: 400), (time) {
      if ((checkstartgame(student.cellulox.x, student.celluloy.y))) {
        student.acgame2.startGameV = true;

        tasktext = (student.curLang == 'fa')
            ? AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("guide")
            : AppTranslations.of(student.navigatorKeygame.currentState.context)
                    .text("guide") +
                capitanr() +
                AppTranslations.of(
                        student.navigatorKeygame.currentState.context)
                    .text("and") +
                capitanb() +
                AppTranslations.of(
                        student.navigatorKeygame.currentState.context)
                    .text("avoidmessage");

        student.acgame2.startgame = false;

        // initialposition();
        countertostart = 5;

        timerstartGame =
            new Timer.periodic(new Duration(milliseconds: 1000), (time) {
          student.acgame2.instructionText =
              AppTranslations.of(student.navigatorKeygame.currentState.context)
                      .text("startmessage") +
                  countertostart.toString() +
                  ' ...';
          notifyListeners();

          countertostart = countertostart - 1;

          if (countertostart == 0) {
            showinstruction = false;
            timerstartGame.cancel();
          }
        });
        student.activityChanged();
        checkinitialposition.cancel();
      }
    });
    student.dbGroupRef.collection("gamevents").add({
      "event": 'startgame',
      'finishedactivity': student.currentActivity,
      'turnto': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });
  }

  void reachendfunction() {
    dynamic mapShape = student.mapShape[1][student.groupCurrentTurn - 1];
    if (activestar == mapShape['numPolygons']) {
      student.reachendV = true;
      student.acgame2.startGameV = false;

      if (student.groupCurrentTurn == 3) {
        playHandler('images/win2.mp3');

        student.acgame2.showinstruction = true;
        instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("victoryEnd");
        student.acgame2.notifyListeners();
        tasktext =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_nextmission");
        chnagecolor();
        student.dbSessionRef.collection("turnFinished").add({
          "d_group": student.groupname,
          "numAc": 1,
          'numTurn': student.groupCurrentTurn,
          'rolevalue': 6,
        });
      } else {
        playHandler('images/score.mp3');
        instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("victory");
        student.acgame2.notifyListeners();

        student.dbSessionRef.collection("turnFinished").add({
          "d_group": student.groupname,
          "numAc": 1,
          'numTurn': student.groupCurrentTurn,
          'rolevalue': 6,
        });

        tasktext =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_nextturn_t");
        chnagecolor();
        student.acgame2.showinstruction = true;
        student.listen();
      }
      if (student.report == true) {
        student.dbGroupRef.collection("gamevents").add({
          "event": 'reachendV',
          'finishedactivity': student.currentActivity,
          'turnto': student.groupCurrentTurn,
          'timepassed': student.elapseTimer.elapsedMilliseconds
        });
      }

      student.activityTime[1] =
          ((student.elapseTimer.elapsedMilliseconds - student.starttimer[1]) /
                  1000)
              .round();

      student.dbSessionRef.collection("scores").doc(student.groupname).update({
        'time': student.activityTime,
      });
    }
  }

  void checkCelluloGame(var mapShape, Offset celluloTargetPosition) {
    if (student.acgame2.startGameV == true) {
      // gameoverfunction();
      reachendfunction();
      for (int i = 0; i < mapShape['numPolygons']; i++) {
        var distancePointCenter = math.sqrt(math.pow(
                (celluloTargetPosition.dx -
                    mapShape['centerPolygon'][i].dx *
                        student.playgroundheight /
                        mapSizeWidth),
                2) +
            math.pow(
                (celluloTargetPosition.dy -
                    mapShape['centerPolygon'][i].dy *
                        student.playgroundheight /
                        mapSizeHeight),
                2));
        if (distancePointCenter <=
                mapShape['radiusPolygon'][i] *
                        student.playgroundheight /
                        mapSizeHeight +
                    student.cellulosize / 2 -
                    10 / 500 * student.playgroundheight &&
            activestar == i) {
          insideBorder = true;
          if (student.scoreV < student.scoreMax && student.reachendV == false) {
            if (enterBorderpolygon == false) {
              student.scoreV = student.scoreV + 1;
              activestar = activestar + 1;
              colorRobots();

              //       mapHit[student.groupCurrentTurn - 1]['Polygons'][i] =
              //         mapHit[student.groupCurrentTurn - 1]['Polygons'][i] + 1;

              starttouch = false;
              enterBorderpolygon = true;

              playHandler('images/smb_coin.mp3');
              student.acgame2.showcrash = true;
              crashtimer = new Timer.periodic(
                  new Duration(milliseconds: crashtime), (time) {
                student.acgame2.showcrash = false;
                crashtimer.cancel();
              });

              if (student.report == true) {
                student.dbGroupRef.collection("gamevents").add({
                  "type": 'hit',
                  'object': 'pol',
                  'number': i,
                  "cellulo": 'purple',
                  'Ac': student.currentActivity,
                  'turn': student.groupCurrentTurn,
                  "studentName": student.name,
                  'timepassed': student.elapseTimer.elapsedMilliseconds
                });
              }
              if (student.groupCurrentTurn == 1) {
                student.gscore[1] = student.scoreV;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 2) {
                student.gscore[1] = student.scoreV + 6;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 3) {
                student.gscore[1] = student.scoreV + 12;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              student.dbGroupRef.collection("events").add({
                "type": 'scorechanged',
                "cellulo": 'purple',
                'score': student.scoreV,
                'Ac': student.currentActivity,
                'turn': student.groupCurrentTurn,
                "studentName": student.name,
              });
            }
            trappedPolygon = i;
          }

          break;
        } else if (i == trappedPolygon) {
          enterBorderpolygon = false;
        }
      }
    }
  }
}
