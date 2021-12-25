import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/widgets/celluloMap.Dart';
import 'dart:async';
import 'dart:convert';

import 'package:student/model/Cellulo.dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/widgets/membersBar.Dart';
//import 'package:student/widgets/inactivityDetector.Dart';
//import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:audioplayers/audio_cache.dart';
import 'dart:math' as math;

class Ac10 extends StatefulWidget {
  Ac10({Key key}) : super(key: key);

  @override
  _Ac10State createState() => _Ac10State();
}

class _Ac10State extends State<Ac10>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
// Timers

  Timer timerCelluloPosition;
  Timer timerslopedetection;
  Timer timerCelluloPositionPaint;
  Timer timercleartracking;
  Timer timerprevCelluloPosition;
  Timer timerInactivityDetector;
  Timer timerprevCelluloPositiontoserver;
  final acID = 7;
  final maxLiitCellulo = 800;
  // UI parameters
  bool celluloxSwitch1 = true;
  bool celluloySwitch1 = false;
  bool celluloxSwitch2 = true;
  bool celluloySwitch2 = false;
  var onStop = false;
  bool mode = false;
  int wrongcounts = 0;
  double _progress = 0.0;
  final celluloSize = 60;
  final ScrollController _scrollController = ScrollController();
  Offset beginpath = Offset(0, 0);
  Offset endpath = Offset(10, 100);
  AnimationController controllerTrial;
  AnimationController controllerTurn;
  Animation<double> animation;
  Animation<double> animationNextTurn;
  TextEditingController controllerinitialX = TextEditingController();
  TextEditingController controllerinitialY = TextEditingController();
  TextEditingController controllerXslope = TextEditingController();
  TextEditingController controllerYslope = TextEditingController();
  AudioPlayer audioPlugin = AudioPlayer();
  AudioPlayer advancedPlayer = AudioPlayer();
  static AudioCache cache = AudioCache();
  AudioPlayer player;
  var counterfunctionImage = 0;

  //Activity Dependent
  var linesPath = [
    'assets/images/Ac7_function1.svg',
    'assets/images/Ac7_function2.svg',
    'assets/images/Ac7_function3.svg',
    'assets/images/Grid_Ac7_Screen.svg',
  ];

// map-related
  final double mapSizeWidth = 860;
  final double mapSizeHeight = 860;
  final double screenSizeWidth = 500;
  final double screenSizeHeight = 500;
  final String mapPath = 'assets/images/Grid_Ac7_Screen.svg';
  final String celluloxpath = 'assets/images/celluloRed.svg';
  final String celluloypath = 'assets/images/celluloBlue.svg';
  final List<String> initialpointList = ['0', '1', '2', '3', '4', '5'];
  final List<String> slopeList = ['0', '0.5', '1', '1.5', '2'];
  String initialPointXvalue;
  String initialPointYvalue;
  String slopeYvalue;
  var onTap = [false, false, false, false, false];
//  var onTap=[false,false,false,false,false];
  bool checkorigin = false;
  var currentTurn = 1;
  var currentTap = 0;
  var tapCounter = 0;
  int simulationVelCoeff = 1;
// Learning

  List<int> progress = [0, -2, -2];
  List<int> progressElpasedTime = [0, 0, 0];

  // zero: undergoing, -1: not accomplished, 1: accomplished
  bool waitforanimation = false;
  List<int> mistakesSlope = [0, 0, 0];
  List<int> mistakesIntrepet = [0, 0, 0];
  List<int> mistakesInitialPosition = [0, 0, 0];
  var prevcelluloxPositionSlope = 0.0;
  var prevcelluloyPositionSlope = 0.0;
  // robot related
  var elapseTimer = new Stopwatch();
  bool allowPaint = false;
  var celluloxPosition = [0.0, 0.0];
  var celluloyPosition = [0.0, 0.0];
  List<List<double>> celluloxPositiontopaint =
      new List.generate(3, (int index) => [0.0, 0.0], growable: true);
  List<List<double>> celluloyPositiontopaint =
      new List.generate(3, (int index) => [0.0, 0.0], growable: true);
  var prevcelluloxPosition = [0.0, 0.0];
  var prevcelluloyPosition = [0.0, 0.0];
  var xlabelposition = [1.0, 0.7];
  var ylabelposition = [-1.0, -1.0];
  var lineallow = [true, false, false];
  bool sendtoend = false;
  bool checkend = true;
  // screen-related
  static var originCoordinates = [225.5, 633.5];

  List<Offset> beginpathlist = [
    Offset(originCoordinates[0] - 300, originCoordinates[1] + 300),
    Offset(originCoordinates[0] - 300, originCoordinates[1] + 200),
    Offset(originCoordinates[0] - 300, originCoordinates[1] + 100),
    Offset(originCoordinates[0] - 200, originCoordinates[1] + 400),
    Offset(originCoordinates[0] - 300, originCoordinates[1] - 300),
  ];
  List<Offset> endpathlist = [
    Offset(originCoordinates[0] + 600, originCoordinates[1] - 400),
    Offset(originCoordinates[0] + 400, originCoordinates[1] - 600),
    Offset(originCoordinates[0] + 200, originCoordinates[1] - 400),
    Offset(originCoordinates[0] + 200, originCoordinates[1] - 400),
    Offset(originCoordinates[0] + 300, originCoordinates[1] + 300),
  ];
  var xcelluloy = 760;
  var ycellulox = 45;
  var correctAnswer = [
    {"initialPointX": 2, "initialPointY": 0, "slope": 1},
    {"initialPointX": 0, "initialPointY": 2, "slope": 1},
    {"initialPointX": 0, "initialPointY": 5, "slope": 1}
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    //  dbRef.child('groups').child(group.id).child('tabletStatus').set("YES");
    // dbRef.child('groups').child(group.id).child('currentActivity').set("Ac7");
    elapseTimer.start();

    controllerTrial = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 30000),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controllerTrial)
      ..addListener(() {
        _progress = animation.value;

        if (_progress < 0.2) {}
        if (_progress > 0.22) {
          setState(() {
            allowPaint = true;
          });
          //  cellulox.setGoalPosition(770, 600);
          //  celluloy.setGoalPosition(100, 80);

          if (celluloxPosition[0] > 700 ||
              celluloyPosition[1] < 100 ||
              celluloyPosition[1] > 700) {}
          // }
          //if (celluloxPosition[0] > 700 ||
          //    celluloyPosition[1] < 100) {
          //    cellulox.resetrobot();
          //      celluloy.resetrobot();
        }
        if (_progress == 1.0) {
          //  cellulox.setGoalPosition(770, 600);
          //  celluloy.setGoalPosition(100, 80);

        }
      });

    super.initState();

    // cellulox.resetrobot();
    //celluloy.resetrobot();
    timerCelluloPosition =
        new Timer.periodic(new Duration(milliseconds: 100), (time) {
      var xxprev = celluloxPosition[0];
      var xyprev = celluloxPosition[1];
      var yxprev = celluloyPosition[0];
      var yyprev = celluloyPosition[1];

      if (totalRobots() > 1) {
        // print(cellulox.getrobotKidnapped().toString());
        // print(celluloy.getrobotKidnapped().toString());

      }

      if (checkend) {
        if (celluloxPosition[0] > 800 ||
            celluloyPosition[1] > 800 ||
            celluloyPosition[1] < 100) {
          //  showAlertDialog(context, '', 'Make sure robots are on the map');
          // checkend = false;
        }
      }

      if (checkorigin) {
        var distancePointStartX = math.sqrt(math.pow(
                (celluloxPosition[0] -
                    (originCoordinates[0] +
                        100 * int.parse(initialPointXvalue))),
                2) +
            math.pow((celluloxPosition[1] - xcelluloy), 2));
        var distancePointStartY = math.sqrt(
            math.pow((celluloyPosition[0] - ycellulox), 2) +
                math.pow(
                    (celluloyPosition[1] -
                        (originCoordinates[1] -
                            100 * int.parse(initialPointYvalue))),
                    2));

        if (distancePointStartX < 10 && distancePointStartY < 10) {
          setState(() {
            allowPaint = true;
            checkorigin = false;
            sendToEnd();
            //runHaptic = true;
          });
        }
      }
    });

    timerCelluloPositionPaint =
        new Timer.periodic(new Duration(seconds: 1), (time) {
      setState(() {
        if (allowPaint == true) {
          celluloxPositiontopaint[0]
              .add(celluloxPosition[0] * screenSizeWidth / mapSizeWidth);
          celluloyPositiontopaint[0]
              .add(celluloyPosition[1] * screenSizeHeight / mapSizeHeight);
        }
      });
    });

    timerprevCelluloPositiontoserver =
        new Timer.periodic(new Duration(milliseconds: 1700), (time) {
      if (allowPaint == true) {}
    });
    //  timerprevCelluloPositiontoserver.cancel();

    ///
    /// Ask to be notified when messages related to the game
    /// are sent by the server
    ///
  }

  void playHandler(String songpath) async {
    player = await cache.play(songpath);
  }

  void sendToEnd() {
    setState(() {
      checkend = true;
    });
  }

  void slopeDtectionTimer() {
    timerslopedetection = new Timer.periodic(new Duration(seconds: 1), (time) {
      print("prev" +
          (((celluloxPosition[0] - prevcelluloxPositionSlope).roundToDouble() >
                  0)
              .toString()));
      // print("currwnt" + celluloxPosition[0].toString());

      controllerXslope.text = 1.0.toString();
      if ((celluloxPosition[0] - prevcelluloxPositionSlope).abs() < 10) {
        slopeYvalue = "You sould move the RED robot faster";
      } else {
        slopeYvalue = (((prevcelluloyPositionSlope - celluloyPosition[1])) /
                (celluloxPosition[0] - prevcelluloxPositionSlope))
            .roundToDouble()
            .toString();
      }

      prevcelluloxPositionSlope = celluloxPosition[0];
      prevcelluloyPositionSlope = celluloyPosition[1];
      // print(int.parse(controllerXslope.text) > 0);
      print("cur" +
          (((celluloxPosition[0] - prevcelluloxPositionSlope).roundToDouble() >
                  0)
              .toString()));

      if ((celluloxPosition[0] - prevcelluloxPositionSlope).roundToDouble() >
          1) {
        setState(() {
          celluloxSwitch2 = true;
          //  print(celluloxSwitch2);
        });
      }
      if (((celluloxPosition[0] - prevcelluloxPositionSlope) / 100)
              .roundToDouble() <
          -1) {
        setState(() {
          celluloxSwitch2 = false;
          //   print(celluloxSwitch2);
        });
      }
      if (celluloyPosition[1] - prevcelluloyPositionSlope > 0) {
        setState(() {
          celluloySwitch2 = true;
          //   print(celluloySwitch2);
        });
      }
      if (celluloyPosition[1] - prevcelluloyPositionSlope < 1.0) {
        setState(() {
          celluloySwitch2 = false;
          // print(celluloySwitch2);
        });
      }
    });
  }

  @override
  void dispose() {
    print('dispo');

    timerCelluloPosition.cancel();
    timerprevCelluloPositiontoserver.cancel();
    controllerTrial.dispose();
    timerCelluloPositionPaint.cancel();

    super.dispose();
  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
  }

  void nextPLayer() {
    setState(() {
      currentTurn = currentTurn + 1;
      //   celluloyPositiontopaint = [0.0, 0.0];
      //  celluloxPositiontopaint = [0.0, 0.0];
    });
  }

  void animationRunner(progress) {}

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          // margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(),
          height: 420.0,
          child: Column(children: <Widget>[
            Card(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(
                  'Choose the two points that your robots start from: ',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 250,
                      child: DropdownButton<String>(
                        hint: Text('RED robot starts at this position: '),
                        value: initialPointXvalue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (String newValue) {
                          setState(() {
                            initialPointXvalue = newValue;
                          });
                        },
                        items: initialpointList
                            .map<DropdownMenuItem<String>>((String ixvalue) {
                          return DropdownMenuItem<String>(
                            value: ixvalue,
                            child: Text(ixvalue),
                          );
                        }).toList(),
                      )),
                  SizedBox(width: 38),
                  Container(
                      width: 250,
                      child: DropdownButton<String>(
                        hint: Text('BLUE robot starts at this position: '),
                        value: initialPointYvalue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (String newValue) {
                          setState(() {
                            initialPointYvalue = newValue;
                          });
                        },
                        items: initialpointList
                            .map<DropdownMenuItem<String>>((String iyvalue) {
                          return DropdownMenuItem<String>(
                            value: iyvalue,
                            child: Text(iyvalue),
                          );
                        }).toList(),
                      )),
                ]),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(
                  ' Choose how much the blue robot should move when the red robot has moved by one.',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  width: 250,
                  child: DropdownButton<String>(
                    hint: Text('then Blue robot should move by: '),
                    value: slopeYvalue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    onChanged: (String newValue) {
                      setState(() {
                        slopeYvalue = newValue;
                      });
                    },
                    items: slopeList
                        .map<DropdownMenuItem<String>>((String syvalue) {
                      return DropdownMenuItem<String>(
                        value: syvalue,
                        child: Text(syvalue),
                      );
                    }).toList(),
                  )),
              SizedBox(width: 25),
              Column(children: <Widget>[
                RotatedBox(
                    quarterTurns: 1,
                    child: Switch(
                      value: celluloySwitch1,
                      onChanged: (value) {
                        setState(() {
                          celluloySwitch1 = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                      inactiveTrackColor: Colors.lightGreenAccent,
                      inactiveThumbColor: Colors.green,
                    )),
                Text(celluloySwitch1 ? 'Down' : 'Up')
              ]),
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 470,
                      child: Card(
                        color: Colors.lightBlue,
                        child: ListTile(
                          title: Text(
                            'Run the robots to see if your answer matches the orange Line.',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(width: 25),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.green),
                      child: FlatButton(
                        child: Text(
                          "Run Robots",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        //  tooltip: 'Run the Robots',
                        onPressed: () => {
                          // print(initialPointXvalue),
                          if (initialPointXvalue != '' &&
                              initialPointYvalue != '' &&
                              slopeYvalue != '' &&
                              initialPointXvalue != null &&
                              initialPointYvalue != null &&
                              slopeYvalue != null)
                            {
                              celluloxPositiontopaint[0] = [0, 0],
                              celluloyPositiontopaint[0] = [0, 0],
                              setState(() {
                                tapCounter = tapCounter + 1;
                                checkorigin = true;
                                checkend = false;
                              }),
                            }
                          else
                            {
                              showAlertDialog(context, 'Robots cant move',
                                  'Dont forget to fill all fileds!'),
                            },
                          //  avgActivation=
                          if (initialPointXvalue !=
                                  correctAnswer[currentTurn - 1]
                                          ['initialPointX']
                                      .toString() ||
                              initialPointYvalue !=
                                  correctAnswer[currentTurn - 1]
                                          ['initialPointY']
                                      .toString())
                            {
                              mistakesInitialPosition[currentTurn - 1] =
                                  mistakesInitialPosition[currentTurn - 1] + 1,
                            },
                          if (slopeYvalue !=
                              correctAnswer[currentTurn - 1]['slope']
                                  .toString())
                            {
                              mistakesSlope[currentTurn - 1] =
                                  mistakesSlope[currentTurn - 1] + 1,
                            },
                          if (initialPointXvalue ==
                                  correctAnswer[currentTurn - 1]
                                          ['initialPointX']
                                      .toString() &&
                              initialPointYvalue ==
                                  correctAnswer[currentTurn - 1]
                                          ['initialPointY']
                                      .toString() &&
                              slopeYvalue ==
                                  correctAnswer[currentTurn - 1]['slope']
                                      .toString())
                            {
                              progress[currentTurn - 1] = 1,
                            },

                          //    controllerTrial.reset(),
                          //  controllerTrial.forward(),
                        },
                      )),
                  SizedBox(width: 15),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: (tapCounter < 2) ? Colors.grey : Colors.blue),
                      child: FlatButton(
                        child: Text(
                          "Next Turn",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        onPressed: () => (tapCounter >= 1)
                            ? {
                                {
                                  if (currentTurn < 3)
                                    {
                                      setState(() {
                                        tapCounter = 0;
                                        currentTurn = currentTurn + 1;
                                        if (currentTurn == 2) {
                                          progressElpasedTime[0] =
                                              elapseTimer.elapsedMilliseconds;
                                        } else {
                                          progressElpasedTime[currentTurn - 2] =
                                              elapseTimer.elapsedMilliseconds -
                                                  progressElpasedTime[
                                                      currentTurn - 3];
                                        }
                                        celluloxPositiontopaint[0] = [0, 0];
                                        celluloyPositiontopaint[0] = [0, 0];
                                      }),
                                      if (progress[currentTurn - 2] == 0)
                                        progress[currentTurn - 2] = -1,

                                      //  controller.reset(),

                                      allowPaint = false,
                                      progress[currentTurn - 1] = 0,
                                    }
                                  else
                                    {
                                      showAlertDialog(
                                          context,
                                          'Wait for teacher',
                                          'Game has finished! '),
                                    },
                                }
                              }
                            : null,
                      )),
                ]),
          ])),
    ]);
  }
}
