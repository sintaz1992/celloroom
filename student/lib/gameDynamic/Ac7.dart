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

class Game7 extends ChangeNotifier {
  String instructionText =
      'Guide your teammates to find the spacemans while avoiding the rocks';
  List<double> targetx = [0.0];
  List<double> targety = [0.0];
  double currentTaregt = 0;
  List<List<double>> celluloxPositiontopaint =
      new List.generate(3, (int index) => [0.0, 0.0], growable: true);
  List<List<double>> celluloyPositiontopaint =
      new List.generate(3, (int index) => [0.0, 0.0], growable: true);
  List<double> celluloxPositiontopaintvirtual = [0.0, 0.0];
  List<double> celluloyPositiontopaintvirtual = [0.0, 0.0];
  bool allowPaint = false;
  List<int> saved = [0, 0];
  AnimationController controller;
  Timer curvesetpositiontimer;
  Timer animationlifespaceman;
  Timer timerColorButton;
  double step = 0.0;
  bool startGameV = false;
  int numtrials = 3;
  int currenttrial = 0;
  double progress = 0.5;
  Offset beginpath = new Offset(70.0, 200.0);
  Offset endpath = new Offset(270.0, 300.0);
  double totaltimeanimation = 20;
  int reward = 0;
  bool istargetvisible = false;

  bool trybuttonshow = false;
  bool showreport = false;
  int activespaceman = 0;
  Cellulo cellulov = Cellulo(4);
  bool showline = false;
  bool okbuttonshow = true;
  bool hidebuttonshow = false;
  bool submitbuttonshow = false;
  Timer changecolortasktext;
  Timer changecolortasktext2;
  Timer crashtimer;
  Timer reachendtimer;
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
  Game7();
  bool gameover = false;
  bool showinstructionT = true;
  String tasktext = '';
  bool showinstruction = true;
  int maxreward = 5;
  double prevx = 0.0;
  double prevy = 0.0;
  int counter = 0;
  Color startButtonColor = Colors.grey;
  Color chatcolor = Colors.green[200];
  List<int> linesstatus = [0, 0, 0];
  List<double> velocity = [0.0, 0.0];
  List<double> a = [-1.0, -3.0, -0.5];
  List<bool> showsecretlines = [false, false, false];
  List<double> b = [1.0, 1.0, 1.0];

  List<double> c = [0.0, 0.0, 0.0];
  bool emptygridshow = false;
  double score = 0.0;
  Timer timergamerules;
  Timer checkinitialposition;

  Timer timerfinishgame;
  int timealive = 4;
  List<Offset> celluloxpath = [Offset(0, 0)];
  List<Offset> celluloypath = [Offset(0, 0)];

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

  void newtrial() {
    for (int i = 0;
        i < student.acgame7.celluloxPositiontopaintvirtual.length;
        i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('7')
          .collection('turns')
          .doc(student.groupCurrentTurn.toString())
          .collection('trials')
          .doc(currenttrial.toString())
          .collection("celluloPositionV")
          .doc(i.toString())
          .set({
        "x": student.acgame7.celluloxPositiontopaintvirtual[i],
        "y": student.acgame7.celluloyPositiontopaintvirtual[i],
        'time': i
      });
    }

    showinstructionT = true;
    String guider = (student.groupCurrentTurn == 1)
        ? student.groupmember3name
        : ((student.groupCurrentTurn == 2)
            ? student.groupmember3name
            : student.groupmember1name);
    student.acgame7.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("hideinstruction1");
    startGameV = false;
    student.acgame7.showline = false;
    student.acgame7.emptygridshow = true;
    student.acgame7.submitbuttonshow = false;
    student.acgame7.okbuttonshow = true;

    student.acgame7.reward = 0;
    currenttrial = currenttrial + 1;
    celluloxPositiontopaint[0] = [0.0, 0.0];
    celluloyPositiontopaint[0] = [0.0, 0.0];
    celluloxPositiontopaintvirtual = [0.0, 0.0];
    celluloyPositiontopaintvirtual = [0.0, 0.0];
    //  clearPosition(currenttrial, 7);
    trybuttonshow = false;
    List<Offset> liststartpoint =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['startCenter'];
    cellulov.x = liststartpoint[currenttrial].dx / 860;
    cellulov.y = liststartpoint[currenttrial].dy / 860;
    startGameV = false;

    counter = 0;
    //allowPaint = true;

    // startgameposition();
    notifyListeners();
    student.velocityx[6 * numtrials +
        (student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = velocity[0] * student.mapSizeHeightfull / 200;
    student.velocityy[6 * numtrials +
        (student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = -velocity[1] * student.mapSizeHeightfull / 200;

    student.error[6 * numtrials +
        (student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = score;
    student.dbSessionRef.collection("velocity").doc(student.groupname).update({
      'velocityx': student.velocityx,
      'velocityy': student.velocityy,
      'error': student.error,
    });
    score = 0;
    velocity = [0.0, 0.0];
  }

  void reachend() {
    student.reachendV = true;

    student.acgame7.showinstruction = true;
    student.acgame7.showinstructionT = true;

    student.dbGroupRef.collection("gamevents").add({
      "event": 'reachend',
      'Ac': student.currentActivity,
      'turn': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });

    student.acgame7.notifyListeners();

    student.activityTime[6] =
        ((student.elapseTimer.elapsedMilliseconds - student.starttimer[6]) /
                1000)
            .round();
    student.dbSessionRef.collection("scores").doc(student.groupname).update({
      'time': student.activityTime,
    });

    print(velocity);
    print(velocity[0] / 20);
    print(velocity[1] / 20);
    student.velocityx[6 * numtrials +
        (student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = velocity[0] * student.mapSizeHeightfull / 200;
    student.velocityy[6 * numtrials +
        (student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = -velocity[1] * student.mapSizeHeightfull / 200;

    student.error[6 * numtrials +
        (student.groupCurrentTurn - 1) * numtrials +
        currenttrial] = score;
    student.dbSessionRef.collection("velocity").doc(student.groupname).update({
      'velocityx': student.velocityx,
      'velocityy': student.velocityy,
      'error': student.error,
    });
    score = 0;
    velocity = [0.0, 0.0];

    for (int i = 0;
        i < student.acgame7.celluloxPositiontopaintvirtual.length;
        i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('7')
          .collection('turns')
          .doc(student.groupCurrentTurn.toString())
          .collection('trials')
          .doc(currenttrial.toString())
          .collection("celluloPositionV")
          .doc(i.toString())
          .set({
        "x": student.acgame7.celluloxPositiontopaintvirtual[i],
        "y": student.acgame7.celluloyPositiontopaintvirtual[i],
        'time': i
      });
    }
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
    student.acgame7.startgame = true;
    student.permisMoveV = true;

    student.acgame7.instructionText = '';
    student.acgame7.showinstruction = true;
    student.acgame7.showinstructionT = false;
    student.acgame7.notifyListeners();
    //allowPaint = true;
    velocity = [0.0, 0.0];
    List<Offset> liststartpoint =
        student.mapShape[student.acList.indexOf(student.currentActivity)]
            [student.groupCurrentTurn - 1]['startCenter'];
    cellulov.x = liststartpoint[currenttrial].dx / 860;
    cellulov.y = liststartpoint[currenttrial].dy / 860;
    counter = 0;

    prevx = student.cellulox.x;
    prevy = student.celluloy.y;

    // notifyListeners();

    student.acgame7.tasktext =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("instruction_followline");

    student.dbGroupRef.collection("gamevents").add({
      "event": 'startgame',
      'finishedactivity': student.currentActivity,
      'turnto': student.groupCurrentTurn,
      'timepassed': student.elapseTimer.elapsedMilliseconds
    });
  }

  void begingame() {
    showinstructionT = true;
    String guider = (student.groupCurrentTurn == 1)
        ? student.groupmember3name
        : ((student.groupCurrentTurn == 2)
            ? student.groupmember3name
            : student.groupmember1name);
    student.acgame7.instructionText =
        AppTranslations.of(student.navigatorKeygame.currentState.context)
            .text("hideinstruction1");

    tasktext = '';
    student.scoreV = 0;

    for (int i = 6; i > 0; i--) {
      cellulox.setColor(0, 0, 0, 1, i - 1, 0);
    }

    for (int i = 6; i > 0; i--) {
      celluloy.setColor(0, 0, 0, 1, i - 1, 1);
    }

    student.acgame7.startgame = false;
    student.reachendV = false;
    startGameV = false;
    student.acgame7.showline = false;
    student.acgame7.emptygridshow = true;
    student.acgame7.submitbuttonshow = false;
    student.acgame7.okbuttonshow = true;

    student.acgame7.reward = 0;
    student.acgame7.showreport = false;
    currenttrial = 0;

    celluloxPositiontopaint[0] = [0.0, 0.0];
    celluloyPositiontopaint[0] = [0.0, 0.0];
    celluloxPositiontopaintvirtual = [0.0, 0.0];
    celluloyPositiontopaintvirtual = [0.0, 0.0];

    /*
    checkinitialposition =
        new Timer.periodic(new Duration(milliseconds: 400), (time) {
      if ((checkstartgame(student.cellulox.x, student.celluloy.y))) {
        startGameV = true;
        funcstartgame();
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
    */
    timerCelluloPositionPaint =
        new Timer.periodic(new Duration(milliseconds: 100), (time) {
      if (allowPaint == true) {
        counter = counter + 1;
        celluloxPositiontopaint[0].add(student.cellulox.x);
        celluloyPositiontopaint[0].add(student.celluloy.y);

        score = score +
            (a[currenttrial] *
                            (student.cellulox.x - 0.5) *
                            student.mapSizeHeightfull +
                        b[currenttrial] *
                            (student.celluloy.y - 0.5) *
                            student.mapSizeHeightfull)
                    .abs() /
                math.sqrt(math.pow(a[currenttrial], 2) +
                    math.pow(b[currenttrial], 2));

        student.gscore[6] = score.toInt();

        velocity[0] = velocity[0] + student.cellulox.x - prevx;
        velocity[1] = velocity[1] + student.celluloy.y - prevy;

        prevx = student.cellulox.x;
        prevy = student.celluloy.y;
        //  print('counter');
        student.dbSessionRef
            .collection("celluloPosition")
            .doc(student.groupname)
            .collection('Activities')
            .doc('7')
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
    clearPosition(0, 7);
    clearPosition(1, 7);
    clearPosition(2, 7);
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

}
