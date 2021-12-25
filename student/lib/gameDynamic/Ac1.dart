import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:student/commonFunctions/groupnames.dart';
import 'package:student/model/Cellulo.dart';
//import 'package:student/commonFunctions/initialposition.dart';
import 'package:student/model/student.dart';
import 'package:student/commonFunctions/playaudio.dart';
import 'package:student/services/app_translations.dart';
import 'package:student/commonFunctions/checkstartgame.dart';

class Game1 extends ChangeNotifier {
  String instructionTextR = '';
  String instructionTextB = '';
  String instructionText = '';
  List<double> targetx = [0.0];
  List<double> targety = [0.0];
  double currentTaregt = 0;
  AnimationController controller;
  Timer curvesetpositiontimer;
  Timer animationlifespaceman;
  Timer timergamerulesX;
  Timer timergamerulesY;
  double step = 0.0;
  double progress = 0.5;
  Offset beginpath = new Offset(70.0, 200.0);
  Offset endpath = new Offset(270.0, 300.0);
  double totaltimeanimation = 20;
  bool startGameX = false;
  bool startGameY = false;
  bool gameoverX = false;
  bool gameoverY = false;
  int reward = 0;
  bool istargetvisible = false;
  bool showcrash = false;
  bool showcrashX = false;
  bool showcrashY = false;
  bool showreport = false;
  int activespaceman = 0;
  Timer changecolortasktext;
// checkcellulorles
  bool instructions2 = false;
  bool afterinstructions2 = false;
  bool enterBorderX = false;
  bool enterBorderY = false;
  bool startgame = false;
  bool enterBorderpolygon = false;
  bool insideBorder = false;
  int trappedPolygon = 0;
  int trappedCircleX = 0;
  int trappedCircleY = 0;
  bool starttouch = false;
  double setx = 1;
  double sety = 1;
  Color tasktextcolor = Colors.blueGrey;
  Offset targetposition = new Offset(0.0, 0.0);
  Game1();
  bool gameover = false;
  bool showinstructionT = true;
  String tasktext = '';

  bool showinstruction = true;
  int maxreward = 5;
  Timer timerstartGame;
  Timer crashtimer;
  Timer crashtimerX;
  Timer crashtimerY;
  double mapSizeWidth = 760;
  double mapSizeHeight = 760;
  int crashtime = 1000;
  Timer timergamerules;
  Timer timerlifespaceman;
  Timer timerfinishgame;
  int countertostart = 5;
  int timealive = 40;
  Timer checkinitialposition;
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
    student.acgame1.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("robot_start_game_position");
    print('impassing ac1');
    tasktext = '';
    student.scoreX = 0;
    student.scoreY = 0;
    student.acgame1.startGameX = false;
    student.acgame1.startGameY = false;
    colorRobots();
    activespaceman = 0;
    checkinitialposition =
        new Timer.periodic(new Duration(milliseconds: 400), (time) {
      if ((checkstartgame(student.cellulox.x, student.cellulox.y)) &&
          (checkstartgame(student.celluloy.x, student.celluloy.y))) {
        student.acgame1.startGameX = true;
        student.acgame1.startGameY = true;
        //  showinstruction = false;
        checkinitialposition.cancel();
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

        student.acgame1.startgame = false;

        // initialposition();
        countertostart = 5;
        student.acgame1.instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                    .text("startmessage") +
                countertostart.toString() +
                ' ...';
        notifyListeners();
        timerstartGame =
            new Timer.periodic(new Duration(milliseconds: 5000), (time) {
          print('timergame1');
          countertostart = 0;
          showinstruction = false;
          timerstartGame.cancel();
        });
        student.activityChanged();
      }
    });
    student.dbGroupRef.collection("gamevents").add({
      "event": 'startgame',
      'finishedactivity': student.currentActivity,
      'turnto': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });
  }

/*
  void gameoverfunction() {
    if (student.scoreX <= 0 &&
        gameoverX == false &&
        student.reachendX == false) {
      gameoverX = true;

      student.permisMoveX = false;

      instructionText =
          AppTranslations.of(student.navigatorKeygame.currentState.context)
              .text("instruction_repair");
      //  student.showinstruction = true;
      //showinstructionR = true;

      playHandler('images/gameover.mp3');
      timergamerulesX = new Timer.periodic(new Duration(seconds: 15), (time) {
        //student.showinstruction = false;
        // showinstructionR = false;

        if (student.permisMoveX == false) student.permisMoveX = true;
        student.scoreX = student.scoreMax;
        student.dbGroupRef.update({
          'scoreX': student.scoreX,
        });

        //starttouchX = false;
        gameoverX = false;

        timergamerulesX.cancel();
        playHandler('images/smb_powerup.mp3');
        instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_move_ac1");
      });

      if (student.report == true &&
          (student.groupPolicy[student.role - 1]
                  [student.groupCurrentTurn - 1] ==
              'T')) {
        student.dbGroupRef.collection("gamevents").add({
          "event": 'gameover',
          "cellulo": 'red',
          'Ac': student.currentActivity,
          'turn': student.groupCurrentTurn,
          "studentName": student.name,
          'timepassed': student.elapseTimer.elapsedMilliseconds
        });
      }
    }
    if (student.scoreY <= 0 &&
        gameoverY == false &&
        student.reachendY == false) {
      gameoverY = true;

      // tapCounter = tapCounter + 1;
      student.permisMoveY = false;

      instructionText =
          AppTranslations.of(student.navigatorKeygame.currentState.context)
              .text("instruction_repair");

      // showinstructionB = true;

      playHandler('images/gameover.mp3');
      timergamerulesY = new Timer.periodic(new Duration(seconds: 15), (time) {
        //  showinstructionB = false;

        if (student.permisMoveY == false) student.permisMoveY = true;
        {
          student.scoreY = student.scoreMax;
          student.dbGroupRef.update({
            'scoreY': student.scoreY,
          });
          if (student.report == true &&
              (student.groupPolicy[student.role - 1]
                      [student.groupCurrentTurn - 1] ==
                  'T')) {
            student.dbGroupRef.collection("events").add({
              "type": 'scorechanged',
              "cellulo": 'blue',
              'score': student.scoreY,
              'Ac': student.currentActivity,
              'turn': student.groupCurrentTurn,
              "studentName": student.name,
            });
          }
        }

        //starttouchX = false;
        gameoverY = false;
        student.reachendY = false;

        timergamerulesY.cancel();
        playHandler('images/smb_powerup.mp3');
        instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_move_ac1");
      });

      if (student.report == true &&
          (student.groupPolicy[student.role - 1]
                  [student.groupCurrentTurn - 1] ==
              'T')) {
        student.dbGroupRef.collection("gamevents").add({
          "event": 'gameover',
          "cellulo": 'blue',
          'Ac': student.currentActivity,
          'turn': student.groupCurrentTurn,
          "studentName": student.name,
          'timepassed': student.elapseTimer.elapsedMilliseconds
        });
      }
    }
  }
*/
  void reachendfunction(int id) {
    dynamic mapShape = student.mapShape[0][student.groupCurrentTurn - 1];
    if (activespaceman == mapShape['numCircles']) {
      student.reachendX = true;
      student.reachendY = true;
      student.acgame1.startGameX = false;
      student.acgame1.startGameY = false;
      if (student.groupCurrentTurn == 3) {
        playHandler('images/win2.mp3');

        student.acgame1.showinstruction = true;
        instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("victoryEnd");
        student.acgame1.notifyListeners();
        tasktext =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_nextmission");
        chnagecolor();
        student.dbSessionRef.collection("turnFinished").add({
          "d_group": student.groupname,
          "numAc": 0,
          'numTurn': student.groupCurrentTurn,
          'rolevalue': 6,
        });
      } else {
        playHandler('images/score.mp3');
        instructionText =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("victory");
        student.acgame1.notifyListeners();

        student.dbSessionRef.collection("turnFinished").add({
          "d_group": student.groupname,
          "numAc": 0,
          'numTurn': student.groupCurrentTurn,
          'rolevalue': 6,
        });

        tasktext =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_nextturn_t");
        chnagecolor();
        student.acgame1.showinstruction = true;
        student.listen();
      }
      if (student.report == true) {
        student.dbGroupRef.collection("gamevents").add({
          "event": 'reachendX',
          'finishedactivity': student.currentActivity,
          'turnto': student.groupCurrentTurn,
          'timepassed': student.elapseTimer.elapsedMilliseconds
        });
      }
      if (student.report == true) {
        student.dbGroupRef.collection("gamevents").add({
          "event": 'reachendY',
          'finishedactivity': student.currentActivity,
          'turnto': student.groupCurrentTurn,
          'timepassed': student.elapseTimer.elapsedMilliseconds
        });
      }
      student.activityTime[0] =
          ((student.elapseTimer.elapsedMilliseconds - student.starttimer[0]) /
                  1000)
              .round();

      student.dbSessionRef.collection("scores").doc(student.groupname).update({
        'time': student.activityTime,
      });
    }
  }

  void checkCelluloGame(var mapShape, Offset celluloTargetPosition, int id) {
    if (student.acgame1.startGameX &&
        student.acgame1.startGameY &&
        !student.reachendX &&
        !student.reachendY) {
      reachendfunction(id);
      for (int i = 0; i < mapShape['numCircles']; i++) {
        var distancePointCenter = math.sqrt(math.pow(
                (celluloTargetPosition.dx -
                    mapShape['originCircles'][i].dx *
                        student.playgroundheight /
                        mapSizeWidth),
                2) +
            math.pow(
                (celluloTargetPosition.dy -
                    mapShape['originCircles'][i].dy *
                        student.playgroundheight /
                        mapSizeHeight),
                2));
        if (distancePointCenter <=
                mapShape['radiuosCircles'][i] *
                        student.playgroundheight /
                        mapSizeHeight +
                    student.cellulosize / 2 -
                    10 / 500 * student.playgroundheight &&
            i == student.acgame1.activespaceman) {
          if (id == 0 &&
              student.scoreX < student.scoreMax &&
              student.reachendX == false &&
              i % 2 == 0) {
            if (enterBorderX == false) {
              student.scoreX = student.scoreX + 1;
              activespaceman = activespaceman + 1;
              colorRobots();
              if (student.report == true) {
                student.dbGroupRef.collection("gamevents").add({
                  "type": 'hit',
                  'object': 'circle',
                  'number': i,
                  "cellulo": 'red',
                  'Ac': student.currentActivity,
                  'turn': student.groupCurrentTurn,
                  "studentName": student.name,
                  'timepassed': student.elapseTimer.elapsedMilliseconds
                });
              }

              playHandler('images/smb_coin.mp3');
              if (student.groupCurrentTurn == 1) {
                student.gscore[0] = student.scoreX + student.scoreY;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }

              if (student.groupCurrentTurn == 2) {
                student.gscore[0] = student.scoreX + student.scoreY + 12;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 3) {
                student.gscore[0] = student.scoreX + student.scoreY + 24;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (instructions2 == false && afterinstructions2 == false)
                instructions2 = true;

              student.acgame1.showcrashX = true;
              crashtimerX = new Timer.periodic(
                  new Duration(milliseconds: crashtime), (time) {
                student.acgame1.showcrashX = false;
                crashtimerX.cancel();
              });

              enterBorderX = true;
            }
            trappedCircleX = i;
          }
          if (id == 1 &&
              student.scoreY < student.scoreMax &&
              student.reachendY == false &&
              i % 2 != 0) {
            if (enterBorderY == false) {
              student.scoreY = student.scoreY + 1;
              activespaceman = activespaceman + 1;
              colorRobots();

              student.listen();
              student.dbGroupRef.update({
                'scoreY': student.scoreY,
              });

              // mapHitY[student.groupCurrentTurn - 1]['Circles'][i] =
              //    mapHitY[student.groupCurrentTurn - 1]['Circles'][i] + 1;
              //
              playHandler('images/smb_coin.mp3');

              if (student.groupCurrentTurn == 1) {
                student.gscore[0] = student.scoreX + student.scoreY;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 2) {
                student.gscore[0] = student.scoreX + student.scoreY + 12;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 3) {
                student.gscore[0] = student.scoreX + student.scoreY + 24;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (instructions2 == false && afterinstructions2 == false)
                instructions2 = true;
              if (student.report == true) {
                student.dbGroupRef.collection("gamevents").add({
                  "type": 'hit',
                  'object': 'circle',
                  'number': i,
                  "cellulo": 'blue',
                  'Ac': student.currentActivity,
                  'turn': student.groupCurrentTurn,
                  "studentName": student.name,
                  'timepassed': student.elapseTimer.elapsedMilliseconds
                });
              }

              student.acgame1.showcrashY = true;

              crashtimerY = new Timer.periodic(
                  new Duration(milliseconds: crashtime), (time) {
                student.acgame1.showcrashY = false;
                crashtimerY.cancel();
              });
              enterBorderY = true;
            }
            trappedCircleY = i;
          }
          break;
        } else if (id == 0 && i == trappedCircleX) {
          enterBorderX = false;
        } else if (id == 1 && i == trappedCircleY) {
          enterBorderY = false;
        }
      }
    }
  }
}
