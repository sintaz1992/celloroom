import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'package:student/model/student.dart';

import 'package:student/widgets/membersBar.Dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/widgets/mapTablet copy.dart' as mapTablet;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:student/services/app_translations.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:student/widgets/buttons/nextmission.dart';
import 'package:student/commonFunctions/groupnames.dart';
import 'package:student/widgets/buttons/nextturn.dart';
import 'package:student/widgets/screenArrow.dart';

class Ac0 extends StatefulWidget {
  Ac0({Key key}) : super(key: key);

  @override
  _Ac0State createState() => _Ac0State();
}

class _Ac0State extends State<Ac0> with TickerProviderStateMixin {
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

    //student.elapseTimer.start();

    //elapseTimer.start();

    timerCheckCelluloGame =
        new Timer.periodic(new Duration(milliseconds: 200), (time) {
      if (student.currentActivity == 'Ac0') {
        print(';ff');
        print(student.celluloy.robot);
        print(student.cellulox.x);
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

    //elapseTimer.stop();
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
              title: Text(
                  AppTranslations.of(
                          student.navigatorKeygame.currentState.context)
                      .text("Try moving the spaceships"),
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
                                            ])),
                                        SizedBox(width: 20),
                                      ])),
                            )))))));
  }
}
