import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/gameDynamic/Ac3.dart';
import 'dart:async';
import 'package:student/model/student.dart';
import 'package:student/widgets/membersBar.Dart';
import 'package:student/services/app_translations.dart';

import 'package:student/widgets/mapTablet.dart' as mapTablet;

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student/widgets/buttons/nextturn.dart';
import 'package:student/widgets/buttons/nextmission.dart';
import 'package:student/widgets/chat.dart';
import 'package:student/widgets/buttons/startbutton.dart';
import 'package:student/widgets/screenArrow.dart';

class Ac3 extends StatefulWidget {
  Ac3({Key key}) : super(key: key);

  @override
  _Ac3State createState() => _Ac3State();
}

class _Ac3State extends State<Ac3> with TickerProviderStateMixin {
  var elapseTimer = new Stopwatch();
  var timeOutofBorder;
  AnimationController controllerRobotPath;
  Animation<double> animationRobotPath;
  Timer timerCelluloPosition;
  Timer timerCelluloPositionPainttoserver;

  TextEditingController controllerx = TextEditingController();
  TextEditingController controllery = TextEditingController();

  double screenSizeWidth;
  double screenSizeHeight;
  double h2wscreen = 1.0;
  // Celulo
  bool readytosubmitCellulowtarget = true;
  var xHaptic;
  var yHaptic;
  var xyHapticG = [0.0, 0.0];
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

// Learning
  double radiuosStart = 45;
  List<int> mistakesSlope = [0, 0, 0];
  List<int> mistakesIntrepet = [0, 0, 0];
  List<int> mistakesInitialPosition = [0, 0, 0];
  int tapCounter = 0;
  List<int> progress = [0, -2, -2];
  List<int> progressElpasedTime = [0, 0, 0];
//Activity Dependent

  double screenWidth = 500;
  double screenHeight = 500;

  bool formcellulowtargetsubmitVisible = true;
  void onDataSend() {
    student.dbSessionRef.collection('attempts').add({
      "numAttempts": tapCounter,
      "groupID": student.groupname,
      "acID": student.currentActivity,
      "elpasedTime": elapseTimer.elapsedMilliseconds -
          progressElpasedTime[student.groupCurrentTurn - 1],
      "progress": {
        "turn1": progress[0],
        "turn2": progress[1],
        "turn3": progress[2]
      },
      "progressElpasedTime": {
        "turn1": progressElpasedTime[0],
        "turn2": progressElpasedTime[1],
        "turn3": progressElpasedTime[2],
      },
      "currentTurn": student.groupCurrentTurn,
      "mistakes": {
        "turn1": {
          "slope": mistakesSlope[0],
          "initialPoint": mistakesInitialPosition[0]
        },
        "turn2": {
          "slope": mistakesSlope[1],
          "initialPoint": mistakesInitialPosition[1]
        },
        "turn3": {
          "slope": mistakesSlope[2],
          "initialPoint": mistakesInitialPosition[2]
        },
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // initialposition();
    if (student.groupCurrentTurn != 1) {
      student.dbGroupRef.update({
        'CurrentTurn': 1,
      });
    } else {
      student.acgame3.begingame();
    }

    student.dbSessionRef.collection("turnTransition").add({
      "d_group": student.groupname,
      "numAc": 2,
      "numTurn": 0,
      'rolevalue': 6
    });
    student.dbGroupRef.collection("cellulowtarget").add({
      "x": 0,
      "y": 0,
      "studentName": student.name,
    });

    if (student.elapseTimer.elapsedMicroseconds < 2) {
      student.elapseTimer.start();
    }

    student.starttimer[2] = student.elapseTimer.elapsedMilliseconds;

    timerCelluloPosition =
        new Timer.periodic(new Duration(milliseconds: 200), (time) {
      if (student.currentActivity == 'Ac3') {
        student.acgame3.checkCelluloGame();
      }
    });

    student.acgame3.timerColorButton =
        new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      if (student.acgame3.startButtonColor == Colors.grey) {
        student.acgame3.startButtonColor = Colors.orange;
        //  student.acgame3.notifyListeners();
      } else {
        student.acgame3.startButtonColor = Colors.grey;
        //student.acgame3.notifyListeners();
      }
    });

    elapseTimer.start();
    onDataSend();
    student.dbSessionRef.collection("activityTransition").add({
      "d_group": student.groupname,
      "numAc": 2,
      "rolevalue": 6,
    });
  }

  @override
  void dispose() {
    elapseTimer.stop();
    timerCelluloPosition.cancel(); //

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeWidth = MediaQuery.of(context).size.width;
    screenSizeHeight = MediaQuery.of(context).size.height;
    student.playgroundheight =
        (MediaQuery.of(context).size.width - 50) / (h2wscreen + 1);
    student.playgroundheight =
        (MediaQuery.of(context).size.width - 50) / (h2wscreen + 1);

    // if (student.playgroundheight < 300) student.playgroundheight = 300;
    if (student.playgroundheight > 600) student.playgroundheight = 600;
    if (student.playgroundheight > screenSizeHeight - 90)
      student.playgroundheight = screenSizeHeight - 100;

    student.cellulosize =
        student.playgroundheight * student.initialcellulosize * 0.8 / 500;
    student.acgame3.targetSet(student.acgame3.setx, student.acgame3.sety);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(
              (student.currentActivity == 'Ac3')
                  ? AppTranslations.of(context).text("ac3_appbar")
                  : 'Bring the spaceships back to Earth',
              style: student.appbar),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blueGrey,
                        border: Border.all()),
                    child: IconButton(
                      icon: const Icon(Icons.sync_problem_rounded),
                      tooltip: 'Report Robot Problem',
                      onPressed: () {
                        showAlertDialogmain(
                            context, 'Change the Cellulos IDs', 'grfg');

                        //
                      },
                    )))
          ],
        ),
        backgroundColor: Colors.white,
        body: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Container(
                    width: screenSizeWidth,
//height: screenSizeWidth * 0.8,
                    child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController2,
                        child: SingleChildScrollView(
                          controller: _scrollController2,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 30 / 500 * student.playgroundheight),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Stack(children: [
                                          mapTablet.Map(),
                                          Positioned(
                                              top: student.playgroundheight / 2,
                                              child: Padding(
                                                  padding: EdgeInsets.all(0.0),
                                                  child: (student.acgame3
                                                          .showinstructionT)
                                                      ? Consumer<Game3>(
                                                          builder: (context,
                                                                  model,
                                                                  child) =>
                                                              Container(
                                                                  width: student
                                                                          .playgroundheight *
                                                                      h2wscreen,
                                                                  // height: 70,
                                                                  child: Column(
                                                                      children: [
                                                                        Container(
                                                                            width: student.playgroundheight *
                                                                                h2wscreen,
                                                                            // height: 70,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: student.reachendV ? Colors.green[500] : Colors.blueGrey),
                                                                            child: Center(
                                                                                child: Padding(
                                                                              padding: EdgeInsets.all(6.0),
                                                                              child: Text(student.acgame3.instructionText, textAlign: TextAlign.center, style: student.titletext),
                                                                            ))),
                                                                        SizedBox(
                                                                            height: 10 /
                                                                                500 *
                                                                                student.playgroundheight),
                                                                      ])))
                                                      : Text(''))),
                                          student.showpause
                                              ? Center(
                                                  child: Icon(Icons.pause,
                                                      size: 100 *
                                                          student
                                                              .playgroundheight /
                                                          500,
                                                      color: Colors.red),
                                                )
                                              : Container()
                                        ])),
                                    SizedBox(width: 20),
                                    Container(
                                        height: student.playgroundheight,
                                        width: student.playgroundheight *
                                            h2wscreen,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width:
                                                      student.playgroundheight *
                                                          h2wscreen,
                                                  child: Row(children: [
                                                    Consumer<Game3>(
                                                        builder: (context,
                                                                model, child) =>
                                                            RewardBar2()),
                                                    Spacer(),
                                                    Stack(children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  0.0),
                                                          child: Image.asset(
                                                              'assets/images/mapicon.png',
                                                              height: student
                                                                      .playgroundheight *
                                                                  50 /
                                                                  500,
                                                              width: student
                                                                      .playgroundheight *
                                                                  50 /
                                                                  500)),
                                                      Positioned(
                                                          top: student
                                                                  .playgroundheight *
                                                              14 /
                                                              500,
                                                          left: student
                                                                  .playgroundheight *
                                                              25 /
                                                              500,
                                                          child: Text('2',
                                                              style: TextStyle(
                                                                  fontSize: 18 *
                                                                      student
                                                                          .playgroundheight /
                                                                      500)))
                                                    ]),
                                                  ])),
                                              SizedBox(
                                                  height: 15 /
                                                      500 *
                                                      student.playgroundheight),
                                              Container(
                                                width:
                                                    student.playgroundheight *
                                                        h2wscreen,
                                                //  height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: student
                                                        .acgame3.tasktextcolor),
                                                child: Row(children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(6.0),
                                                      child: Image.asset(
                                                          'assets/images/manC.png',
                                                          height: student
                                                                  .playgroundheight *
                                                              40 /
                                                              500,
                                                          width: student
                                                                  .playgroundwidth *
                                                              40 /
                                                              500)),
                                                  Container(
                                                    width: student
                                                                .playgroundheight *
                                                            h2wscreen -
                                                        60 /
                                                            500 *
                                                            student
                                                                .playgroundheight *
                                                            h2wscreen,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6.0),
                                                      child: Consumer<Game3>(
                                                          builder: (context,
                                                                  model,
                                                                  child) =>
                                                              Text(
                                                                  student
                                                                      .acgame3
                                                                      .tasktext,
                                                                  style: student
                                                                      .titletext)),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              SizedBox(
                                                  height: 15 /
                                                      500 *
                                                      student.playgroundheight),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: student
                                                              .playgroundheight *
                                                          h2wscreen /
                                                          2,
                                                      child: Center(
                                                        child: RoleBar(
                                                            curTurn: student
                                                                .groupCurrentTurn),
                                                      )),
                                                ],
                                              ),
                                              Spacer(),
                                              Container(
                                                  width:
                                                      student.playgroundheight *
                                                          h2wscreen,
                                                  child: Row(children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: Text('')),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(0.0),
                                                      child: ((student
                                                                  .reachendV) &&
                                                              ((student.is4person ==
                                                                      false) ||
                                                                  (student.is4person ==
                                                                          true &&
                                                                      student.role !=
                                                                          3)))
                                                          ? ((student.groupCurrentTurn <
                                                                  3)
                                                              ? nextturnbutton()
                                                              : (student
                                                                      .automode)
                                                                  ? nextmissionbutton()
                                                                  : Text(''))
                                                          : Text(''),
                                                    )
                                                  ])),
                                            ])),
                                  ])),
                        ))))));
  }
}