import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/widgets/buttons/nextturn.dart';

import 'dart:async';
import 'package:student/model/student.dart';

import 'package:student/widgets/membersBar.Dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student/services/app_translations.dart';
//import 'package:student/widgets/ShapePainter.dart';
//import 'package:student/widgets/mapRedCellulo.dart' as mapRedCellulo;
//import 'package:student/widgets/mapBlueCellulo.dart' as mapBlueCellulo;
import 'package:student/widgets/mapTablet.dart' as mapTablet;
import 'package:provider/provider.dart';

import 'package:student/widgets/buttons/nextmission.dart';
import 'package:student/commonFunctions/groupnames.dart';
import 'package:student/gameDynamic/Ac2.dart';
import 'package:student/widgets/screenArrow.dart';

class Ac2 extends StatefulWidget {
  Ac2({Key key}) : super(key: key);

  @override
  _Ac2State createState() => _Ac2State();
}

class _Ac2State extends State<Ac2> with TickerProviderStateMixin {
  // Activity_Independent
  var elapseTimer = new Stopwatch();
  Timer timerCelluloPosition;
  Timer timerCelluloPositiontoserver;
  Timer timerCheckCelluloGame;
  Timer timergamerules;
  Timer animationInstruction;
  Timer changeturn;
  int inactivity = 0;
  int tapCounter = 0;
  List<int> progress = [0, -2, -2];
  List<int> progressElpasedTime = [0, 0, 0];
  bool isPlaying = false;
  bool isPaused = false;

  DocumentReference dbRef =
      FirebaseFirestore.instance.collection('sessions').doc(student.sessionID);
  bool collision = false;
  // Celulo
  var celluloxPosition = [0.0, 0.0];
  var celluloyPosition = [0.0, 0.0];
  List<double> celluloxPositiontopaint = [0.0, 0.0];
  List<double> celluloyPositiontopaint = [0.0, 0.0];
  bool addtoprint;
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

  final String mapPath = 'assets/images/Grid_Ac2_Screen.png';
// Learning
  List<int> gameScore = [0, 0, 0];
  List<int> celluloEnergy = [6, 6, 6];
  List<int> mistakesSlope = [0, 0, 0];
  List<int> mistakesIntrepet = [0, 0, 0];
  List<int> mistakesInitialPosition = [0, 0, 0];
  int score = 6;
//Activity Dependent
  bool enterBorder = false;
  bool enterBorderpolygon = false;
  bool enterBorderRect = false;
  bool instructions2 = false;

  int trappedCircle;
  int trappedRectangle;
  int trappedPolygon;

  AnimationController controller;
  bool startGameX = false;
  bool startGameY = false;
  String activityTitle = 'Activity 2';
  var linesPath = [
    'assets/images/Ac7_function1.png',
    'assets/images/Ac7_function2.png',
    'assets/images/Ac7_function3.png',
    'assets/images/GridOnlyPositive.svg',
  ];

  var startPointorder = [2, 0, 2];
  var endPointorder = [1, 3, 1];

  var pointOrder = ['A', 'B', 'C', 'D'];

  var mapHit = [
    {
      'Circles': [0, 0, 0, 0, 0, 0],
      'Rectangles': [0, 0, 0, 0, 0],
      'Polygons': [0, 0, 0, 0, 0, 0],
    },
    {
      'Circles': [0, 0, 0, 0, 0, 0],
      'Rectangles': [0, 0, 0, 0, 0],
      'Polygons': [0, 0, 0, 0, 0, 0],
    },
    {
      'Circles': [0, 0, 0, 0, 0, 0],
      'Rectangles': [0, 0, 0, 0, 0],
      'Polygons': [0, 0, 0, 0, 0, 0],
    },
  ];

// map-related

  //final Offset startPoint = new Offset(0.0, 0.0);
  //inal Offset endPoint = new Offset(0.0, 0.0);
  double screenWidth = student.playgroundheight;
  double screenHeight = student.playgroundheight;
  double h2wscreen = 1;
  double screenSizeWidth;
  double screenSizeHeight;
  bool starttouch = false;

  double coeffScreenMapWidth;
  double coeffScreenMapHeight;
  double radiuosBorder = 40;
  String tasktext;
  Timer timerstartGame;
  Timer timerstartGame2;
  int countertostart = 5;

  @override
  void initState() {
    super.initState();
    //   dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    // dbRef.child('students').child(student.id).child('currentActivity').set("Ac2");
    // elapseTimer.start();
    if (student.elapseTimer.elapsedMicroseconds < 2) {
      print('dd');
      student.elapseTimer.start();
    }
    if (student.groupCurrentTurn != 1) {
      if (student.groupPolicy[student.role - 1][student.groupCurrentTurn - 1] ==
          'T') {
        student.dbGroupRef.update({
          'CurrentTurn': 1,
        });
      }
    } else {
      student.acgame2.begingame();
    }

    student.dbSessionRef.collection("turnTransition").add({
      "d_group": student.groupname,
      "numAc": 1,
      "numTurn": 0,
      'rolevalue': 6,
    });

    student.starttimer[1] = student.elapseTimer.elapsedMilliseconds;

    timerCheckCelluloGame =
        new Timer.periodic(new Duration(milliseconds: 200), (time) {
      if (student.currentActivity == 'Ac2') {
        print(student.reachendV);
        student.acgame2.checkCelluloGame(
            student.mapShape[1][student.groupCurrentTurn - 1],
            Offset(
                (student.cellulox.x) * student.playgroundheight +
                    student.cellulosize / 2,
                (student.celluloy.y) * student.playgroundheight +
                    student.cellulosize / 2));
      }
    });
    student.dbSessionRef.collection("activityTransition").add({
      "d_group": student.groupname,
      "numAc": 1,
      "rolevalue": 6,
    });
  }

  @override
  void dispose() {
    timerCheckCelluloGame.cancel();
    elapseTimer.stop();

    // controller.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    screenSizeWidth = MediaQuery.of(context).size.width;
    screenSizeHeight = MediaQuery.of(context).size.height;
    student.playgroundheight =
        (MediaQuery.of(context).size.width - 50) / (h2wscreen + 1);
    student.playgroundheight =
        (MediaQuery.of(context).size.width - 50) / (h2wscreen + 1);
    if (student.playgroundheight > 600) student.playgroundheight = 600;
    //   if (student.playgroundheight < 300) student.playgroundheight = 300;
    if (student.playgroundheight > screenSizeHeight - 90)
      student.playgroundheight = screenSizeHeight - 100;

    student.cellulosize =
        student.playgroundheight * student.initialcellulosize / 500;
    return Consumer<Student>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.blueGrey,
              title: Text(AppTranslations.of(context).text("ac2_appbar"),
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
                                        top: 30 /
                                            500 *
                                            student.playgroundheight),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.0),
                                              child: Stack(children: [
                                                mapTablet.Map(),
                                                Positioned(
                                                    top: student
                                                            .playgroundheight /
                                                        2,
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: (student.acgame2
                                                                .showinstruction)
                                                            ? Consumer<Game2>(
                                                                builder: (context,
                                                                        model,
                                                                        child) =>
                                                                    Container(
                                                                        width: student.playgroundheight *
                                                                            h2wscreen,
                                                                        // height: 70,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10)),
                                                                            color: student.reachendV ? Colors.green[500] : Colors.blueGrey),
                                                                        child: Center(
                                                                            child: Padding(
                                                                          padding:
                                                                              EdgeInsets.all(6.0),
                                                                          child: Text(
                                                                              student.acgame2.instructionText,
                                                                              textAlign: TextAlign.center,
                                                                              style: student.titletext),
                                                                        ))))
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
                                                      width: student
                                                              .playgroundheight *
                                                          h2wscreen,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            MembersBar2(
                                                              curTurn:
                                                                  student.role,
                                                            ),
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
                                                                      20 /
                                                                      500,
                                                                  child: Text(
                                                                      '2',
                                                                      style: TextStyle(
                                                                          fontSize: 18 *
                                                                              student.playgroundheight /
                                                                              500)))
                                                            ]),
                                                          ]),
                                                    ),
                                                    SizedBox(
                                                        height: 40 /
                                                            500 *
                                                            student
                                                                .playgroundheight),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: Container(
                                                          width: student
                                                                  .playgroundheight *
                                                              h2wscreen,
                                                          //  height: 60,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              color: student
                                                                  .acgame2
                                                                  .tasktextcolor),
                                                          child: Row(children: [
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        6.0),
                                                                child: Image.asset(
                                                                    'assets/images/manC.png',
                                                                    height:
                                                                        student.playgroundheight *
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
                                                                    EdgeInsets
                                                                        .all(
                                                                            6.0),
                                                                child: Consumer<
                                                                        Game2>(
                                                                    builder: (context, model, child) => Text(
                                                                        student
                                                                            .acgame2
                                                                            .tasktext,
                                                                        style: student
                                                                            .titletext)),
                                                              ),
                                                            ),
                                                          ]),
                                                        )),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
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
                                                      width: student
                                                              .playgroundheight *
                                                          h2wscreen,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(''),
                                                            Spacer(),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0.0),
                                                              child: ((student
                                                                          .reachendV) &&
                                                                      ((student.is4person ==
                                                                              false) ||
                                                                          (student.is4person == true &&
                                                                              student.role !=
                                                                                  3)))
                                                                  ? ((student.groupCurrentTurn <
                                                                          3)
                                                                      ? nextturnbutton()
                                                                      : (student
                                                                              .automode)
                                                                          ? nextmissionbutton()
                                                                          : Text(
                                                                              ''))
                                                                  : Text(''),
                                                            ),
                                                          ]),
                                                    ),
                                                  ])),
                                        ])))))))));
  }
}
