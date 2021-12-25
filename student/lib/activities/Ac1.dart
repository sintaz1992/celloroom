import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:student/model/student.dart';
import 'package:student/gameDynamic/Ac1.dart';
import 'package:student/widgets/membersBar.Dart';
import 'package:student/model/Cellulo.dart';
import 'package:student/widgets/mapTablet.dart' as mapTablet;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/services/app_translations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:student/widgets/buttons/nextmission.dart';
import 'package:student/commonFunctions/groupnames.dart';
import 'package:student/widgets/buttons/nextturn.dart';
import 'package:student/widgets/screenArrow.dart';

class Ac1 extends StatefulWidget {
  Ac1({Key key}) : super(key: key);

  @override
  _Ac1State createState() => _Ac1State();
}

class _Ac1State extends State<Ac1> with TickerProviderStateMixin {
  // Activity_Independent
  AppLifecycleState _notification;
  bool isPlaying = false;
  bool isPaused = false;

  var elapseTimer = new Stopwatch();
  double screenSizeWidth;
  double screenSizeHeight;
  Timer timerCheckCelluloGame;
  Timer animationInstruction;
  Timer changeturn;

  //int student.groupCurrentTurn = 1;

  double celluloytop = 0.0;
  double celluloyleft = 0.0;
  double celluloxtop = 0.0;
  double celluloxleft = 0.0;
  bool showanimationInstruction = true;
  Animation<int> _characterCount;
  // Celulo
  var celluloxPosition = [0.0, 0.0];
  var celluloyPosition = [0.0, 0.0];
  var prevcelluloxPosition = [0.0, 0.0];
  var prevcelluloyPosition = [0.0, 0.0];
  var celluloxVelocity = [0.0, 0.0];
  var celluloyVelocity = [0.0, 0.0];
  List<double> celluloxPositiontopaint = [0.0, 0.0];
  List<double> celluloyPositiontopaint = [0.0, 0.0];
  bool addtoprint;
  AnimationController controllershipPath;
  Animation<double> animationshipPath;
  double h2wscreen = 1;

// Learning
  List<int> mistakesSlope = [0, 0, 0];
  List<int> mistakesIntrepet = [0, 0, 0];
  List<int> mistakesInitialPosition = [0, 0, 0];
  List<int> trapped = [0];
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  int trappedCircleX;
  int trappedCircleY;
  int trappedRectangleX;
  int trappedRectangleY;
  int trappedPolygonX;
  int trappedPolygonY;
  bool collision = false;

  String nextturntext = 'Next Turn';
  String instructions2Text = 'You just hit a space rock!!';
//Activity Dependent
  double radiuosStart = 45;
  String activityTitle = 'Activity 1';
  var linesPath = [
    'assets/images/Ac7_function1.png',
    'assets/images/Ac7_function2.png',
    'assets/images/Ac7_function3.png',
    'assets/images/GridOnlyPositive.png',
  ];
  List<int> progress = [0, -2, -2];
  List<int> progressElpasedTime = [0, 0, 0];
  int inactivity = 0;
  int tapCounter = 0;

  var startPointorder = [2, 0, 2];
  var endPointorder = [1, 3, 1];

  var pointOrder = ['A', 'B', 'C', 'D'];
  bool instructions2 = false;
  bool instructions3 = false;
  bool afterinstructions2 = false;

// map-related

  AnimationController controller;
  final double screenWidth = student.playgroundheight;
  final double screenHiehgt = student.playgroundheight;
  double radiuosBorder = 40;
  double coeffScreenMapWidth;
  double coeffScreenMapHeight;
  int _stringIndex;

  var mapHitX = [
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

  var mapHitY = [
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

  @override
  void initState() {
    super.initState();

    if (student.groupCurrentTurn != 1) {
      student.dbGroupRef.update({
        'CurrentTurn': 1,
      });
    } else {
      student.acgame1.begingame();
    }
    student.starttimer[0] = student.elapseTimer.elapsedMilliseconds;
    student.dbSessionRef.collection("turnTransition").add({
      "d_group": student.groupname,
      "numAc": 0,
      "numTurn": 0,
      'rolevalue': 6,
    });
    // dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    //dbRef.child('students').child(student.id).child('currentActivity').set("Ac1");
    // elapseTimer.start();

    timerCheckCelluloGame =
        new Timer.periodic(new Duration(milliseconds: 200), (time) {
      if (student.currentActivity == 'Ac1') {
        student.acgame1.checkCelluloGame(
            student.mapShape[0][student.groupCurrentTurn - 1],
            Offset(
                (student.cellulox.x) * student.playgroundheight +
                    student.cellulosize / 2,
                (student.cellulox.y) * student.playgroundheight +
                    student.cellulosize / 2),
            0);

        student.acgame1.checkCelluloGame(
            student.mapShape[0][student.groupCurrentTurn - 1],
            Offset(
                (student.celluloy.x) * student.playgroundheight +
                    student.cellulosize / 2,
                (student.celluloy.y) * student.playgroundheight +
                    student.cellulosize / 2),
            1);
      }
    });
    student.dbSessionRef.collection("activityTransition").add({
      "d_group": student.groupname,
      "numAc": 0,
      "rolevalue": 6,
    });
  }

  @override
  void dispose() {
    timerCheckCelluloGame.cancel();

    ///.stop();
    // controller.dispose();
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
    if (student.playgroundheight > 600) student.playgroundheight = 600;
    if (student.playgroundheight > screenSizeHeight - 90)
      student.playgroundheight = screenSizeHeight - 100;

    //if (student.playgroundheight < 30) student.playgroundheight = 30;
    student.cellulosize =
        student.playgroundheight * student.initialcellulosize / 500;
    return Consumer<Student>(
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              //toolbarHeight: ,
              centerTitle: false,
              backgroundColor: Colors.blueGrey,
              title: Text(AppTranslations.of(context).text("ac1_appbar"),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Stack(children: [
                                              mapTablet.Map(),
                                              Positioned(
                                                  top:
                                                      student.playgroundheight /
                                                          2,
                                                  child: (student.acgame1
                                                          .showinstruction)
                                                      ? Container(
                                                          width: student
                                                                  .playgroundheight *
                                                              h2wscreen,
                                                          // height: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color: (student
                                                                        .reachendX &&
                                                                    student
                                                                        .reachendY)
                                                                ? Colors
                                                                    .green[500]
                                                                : Colors
                                                                    .blueGrey,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6.0),
                                                            child: Text(
                                                                student.acgame1
                                                                    .instructionText,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    // height: 1.2,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                )),
                                                          ))
                                                      : Text('')),
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
                                                            MembersBar(
                                                              curTurn:
                                                                  student.role,
                                                            ),
                                                            Stack(children: [
                                                              Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0.0),
                                                                  child: Image.asset(
                                                                      'assets/images/mapicon.png',
                                                                      height: student
                                                                              .playgroundheight *
                                                                          100 /
                                                                          500,
                                                                      width: student
                                                                              .playgroundheight *
                                                                          100 /
                                                                          500)),
                                                              Positioned(
                                                                  top: student
                                                                          .playgroundheight *
                                                                      30 /
                                                                      500,
                                                                  left: student
                                                                          .playgroundheight *
                                                                      50 /
                                                                      500,
                                                                  child: Text(
                                                                      '1',
                                                                      style: TextStyle(
                                                                          fontSize: 36 *
                                                                              student.playgroundheight /
                                                                              500)))
                                                            ]),
                                                          ])),
                                                  SizedBox(
                                                      height: 40 /
                                                          500 *
                                                          student
                                                              .playgroundheight),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
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
                                                                    .acgame1
                                                                    .tasktextcolor),
                                                            child: Row(
                                                                children: [
                                                                  Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              6.0),
                                                                      child: Image.asset(
                                                                          'assets/images/manC.png',
                                                                          height: student.playgroundheight *
                                                                              40 /
                                                                              500,
                                                                          width: student.playgroundheight *
                                                                              40 /
                                                                              500)),
                                                                  Container(
                                                                      width: student.playgroundheight *
                                                                              h2wscreen -
                                                                          60 /
                                                                              500 *
                                                                              student
                                                                                  .playgroundheight *
                                                                              h2wscreen,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(6.0),
                                                                        child: Consumer<Game1>(
                                                                            builder: (context, model, child) =>
                                                                                Text(student.acgame1.tasktext, style: student.titletext)),
                                                                      )),
                                                                ]),
                                                          ),
                                                          SizedBox(height: 10),
                                                        ]),
                                                  ),
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
                                                              2 *
                                                              1.5,
                                                          child: Center(
                                                            child: (student
                                                                        .is4person ==
                                                                    false)
                                                                ? RoleBar(
                                                                    curTurn: student
                                                                        .groupCurrentTurn)
                                                                : RoleBar2(
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
                                                            (student.role !=
                                                                        4 &&
                                                                    (student.reachendX &&
                                                                        student
                                                                            .reachendY))
                                                                ? ((student.groupCurrentTurn <
                                                                        3)
                                                                    ? Padding(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                0.0),
                                                                        child:
                                                                            nextturnbutton())
                                                                    : (student
                                                                            .automode)
                                                                        ? nextmissionbutton()
                                                                        : Text(
                                                                            ''))
                                                                : Text(''),
                                                          ])),
                                                ])),
                                      ])),
                            )))))));
  }
}
