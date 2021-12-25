import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/activities/Ac_10.dart';
import 'dart:convert';
import 'dart:core';
import 'package:student/widgets/linePainter.Dart';
import 'dart:async';
//import 'package:student/Database.dart';
import 'package:student/model/student.dart';
import 'package:student/widgets/showAlertDialog.Dart';
//import 'package:student/widgets/membersBar.Dart';
//import 'package:student/model/Cellulo.dart';
import 'package:student/services/app_translations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ac8 extends StatefulWidget {
  Ac8({Key key}) : super(key: key);

  @override
  _Ac8State createState() => _Ac8State();
}

class _Ac8State extends State<Ac8>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  //Learning Parameters

  // UI parameters

  // Cellulo Simulation Parameters

  Timer timer;
  final acID = 8;
  final acIDstring = 'Ac8';
  var onStop = false;
  int wrongcounts = 0;
  double _progress = 0.0;
  final celluloSize = 60;
  final ScrollController _scrollController = ScrollController();
  final functionFormulas = [
    'When the RED cellulo is at 1, the BLUE cellulo will be at 1, the line crosses the y-axis at 0 ',
    'When the RED cellulo is at 1, the BLUE cellulo will be at 2, the line crosses the y-axis at 1',
    'When the RED cellulo is at 1, the BLUE cellulo will be at 3, the line crosses the y-axis at 2',
    'When the RED cellulo is at 1, the BLUE cellulo will be at 2, the line crosses the y-axis at 0',
    'When the RED cellulo is at 1, the BLUE cellulo will be at -1, the line crosses the y-axis at 0'
  ];
  Offset beginpath = Offset(0, 0);
  Offset endpath = Offset(10, 100);
  DocumentReference dbRef =
      FirebaseFirestore.instance.collection('sessions').doc(student.sessionID);
  AnimationController controller;
  Animation<double> animation;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  List<int> mistakesSlope = [0, 0, 0];
  List<int> mistakesIntercept = [0, 0, 0];
  List<int> mistakesInitialPosition = [0, 0, 0];
  List<int> progressElpasedTime = [0, 0, 0];

  var counterfunctionImage = 0;
  var imagespath = [
    'assets/images/Ac8/Ac8_function1.png',
    'assets/images/Ac8/Ac8_function2.png',
    'assets/images/Ac8/Ac8_function3.png',
    'assets/images/Grid_Ac8_Screen.png',
  ];
  var correctAnswer = [
    1,
    3,
    4,
    4,
    4,
  ];
  var onTap = [false, false, false, false, false];
//  var onTap=[false,false,false,false,false];
  bool celluloxSwitch1 = true;
  bool celluloySwitch1 = false;
  bool celluloxSwitch2 = true;
  bool celluloySwitch2 = false;
  static var originCoordinates = [436.3, 429.3];
  List<Offset> beginpathlist = [
    Offset(originCoordinates[0] - 300, originCoordinates[1] + 300),
    Offset(originCoordinates[0] - 300, originCoordinates[1] + 200),
    Offset(originCoordinates[0] - 300, originCoordinates[1] + 100),
    Offset(originCoordinates[0] - 200, originCoordinates[1] + 400),
    Offset(originCoordinates[0] - 300, originCoordinates[1] - 300),
  ];
  List<Offset> endpathlist = [
    Offset(originCoordinates[0] + 300, originCoordinates[1] - 300),
    Offset(originCoordinates[0] + 300, originCoordinates[1] - 400),
    Offset(originCoordinates[0] + 200, originCoordinates[1] - 400),
    Offset(originCoordinates[0] + 200, originCoordinates[1] - 400),
    Offset(originCoordinates[0] + 300, originCoordinates[1] + 300),
  ];
  var currentTurn = 1;
  var currentTap = 0;
  var tapCounter = 0;
  String initialPointXvalue;
  String initialPointYvalue;
  String slopeYvalue;
  List<int> progress = [0, -2, -2];
  bool waitforanimation = false;
  var mistakesSlopematrix = [
    [0, 0, 0, 1, 1],
    [0, 0, 0, 1, 1],
    [1, 1, 1, 0, 1]
  ];
  var mistakesInterceptmatrix = [
    [0, 1, 1, 0, 0],
    [1, 1, 0, 1, 1],
    [0, 1, 1, 0, 0]
  ];

  final List<String> initialpointList = ['0', '1', '2', '3', '4', '5'];
  final List<String> slopeList = ['0', '0.5', '1', '1.5', '2'];

  var inactivity = 0;
  var elapseTimer = new Stopwatch();

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //  dbRef.collection('students').doc(student.id).collection('tabletStatus').set("YES");
    } else {
      // dbRef.child('students').child(student.id).child('tabletStatus').set("NO");
    }
    setState(() {
      _notification = state;
    });
  }

  @override
  void initState() {
    //cellulox.setColor(0, 255, 0, 0, 0);
    //celluloy.setColor(0, 0, 255, 0, 0);
    //cellulox.clearrobot();
    //celluloy.clearrobot();
    WidgetsBinding.instance.addObserver(this);
    elapseTimer.start();
    // dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    //dbRef.child('students').child(student.id).child('currentActivity').set("Ac8");

    super.initState();
    // student.numCurrentActivity = 8;
    controller = AnimationController(
        duration: Duration(milliseconds: 7000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          waitforanimation = false;
          if (currentTap == correctAnswer[currentTurn - 1]) {
            if (currentTurn < 3) {
              progress[currentTurn - 1] = 1;
              progress[currentTurn] = 0;
            }
            tapCounter = 0;

            //  controller.reset();
            // controller.reverse();
            endpath = beginpath;
          } else if (tapCounter > 1) {
            showAlertDialog(context, 'Pay Attention',
                'your answer was wrong but you have more one chance');
          }

          //print('completed');
        } else {
          waitforanimation = true;
        }
      });

    ///
    /// Ask to be notified when messages related to the game
    /// are sent by the server
    ///
  }

  @override
  void dispose() {
    elapseTimer.stop();
    timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(
              (student.currentActivity == 'Ac8')
                  ? AppTranslations.of(context).text("ac8_appbar")
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
        body: Builder(
            builder: (context) => SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Column(children: <Widget>[
                    Container(
                        // margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(),
                        height: 420.0,
                        child: Column(children: <Widget>[
                          Card(
                            color: Colors.blueGrey,
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
                                      hint: Text(
                                          'RED robot starts at this position: '),
                                      value: initialPointXvalue,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          initialPointXvalue = newValue;
                                        });
                                      },
                                      items: initialpointList
                                          .map<DropdownMenuItem<String>>(
                                              (String ixvalue) {
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
                                      hint: Text(
                                          'BLUE robot starts at this position: '),
                                      value: initialPointYvalue,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          initialPointYvalue = newValue;
                                        });
                                      },
                                      items: initialpointList
                                          .map<DropdownMenuItem<String>>(
                                              (String iyvalue) {
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
                            color: Colors.blueGrey,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: 250,
                                    child: DropdownButton<String>(
                                      hint: Text(
                                          'then Blue robot should move by: '),
                                      value: slopeYvalue,
                                      icon: Icon(Icons.arrow_downward),
                                      iconSize: 24,
                                      elevation: 16,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          slopeYvalue = newValue;
                                        });
                                      },
                                      items: slopeList
                                          .map<DropdownMenuItem<String>>(
                                              (String syvalue) {
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
                                        activeTrackColor:
                                            Colors.lightGreenAccent,
                                        activeColor: Colors.green,
                                        inactiveTrackColor:
                                            Colors.lightGreenAccent,
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
                                      color: Colors.blueGrey,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors.green),
                                    child: FlatButton(
                                      child: Text(
                                        "Run The Robots on screen",
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
                                            //celluloxPositiontopaint[0] = [0, 0],
                                            //celluloyPositiontopaint[0] = [0, 0],
                                            setState(() {
                                              beginpath = beginpathlist[
                                                  initialpointList.indexOf(
                                                      initialPointXvalue)];
                                              endpath = endpathlist[
                                                  initialpointList.indexOf(
                                                      initialPointXvalue)];
                                            }),
                                            controller.reset(),
                                            tapCounter = tapCounter + 1,
                                            controller.forward(),
                                          }
                                        else
                                          {
                                            showAlertDialog(
                                                context,
                                                'Robots cant move',
                                                'Dont forget to fill all fileds!'),
                                          },
                                        //  avgActivation=

                                        //    controllerTrial.reset(),
                                        //  controllerTrial.forward(),
                                      },
                                    )),
                              ]),
                        ])),
                  ]),
                  /*
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(border: Border.all()),
                    height: 250.0,
                    child: Scrollbar(
                        controller: _scrollController,
                        isAlwaysShown: true,
                        child: Container(
                            child: ListView.builder(
                          controller: _scrollController,
                          itemCount: 5,
                          itemBuilder: (context, int position) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  if (!waitforanimation) {
                                    // Find the Scaffold in the widget tree and use
                                    // it to show a SnackBar.
                                    // timer.cancel();
                                    // inactivityDtectionTimer();
                                    currentTap = position + 1;
                                    //inactivity = inactivity - 1;
                                    onTap[currentTap - 1] = true;
                                    setState(() {
                                      beginpath = beginpathlist[position];
                                      endpath = endpathlist[position];
                                    });
                                    controller.reset();
                                    tapCounter = tapCounter + 1;
                                    controller.forward();
                                    mistakesSlope[currentTurn - 1] =
                                        mistakesSlope[currentTurn - 1] +
                                            mistakesSlopematrix[currentTurn - 1]
                                                [currentTap - 1];
                                    mistakesIntercept[currentTurn - 1] =
                                        mistakesIntercept[currentTurn - 1] +
                                            mistakesInterceptmatrix[
                                                    currentTurn - 1]
                                                [currentTap - 1];
                                    setState(() {});
                                    if (currentTap ==
                                        correctAnswer[currentTurn - 1]) {
                                      if (currentTurn < 3) {
                                        progress[currentTurn - 1] = 1;
                                        progress[currentTurn] = 0;
                                      }
                                      if (currentTurn == 3) {
                                        progress[currentTurn - 1] = 1;
                                        //  progress[currentTurn] = 0;

                                      }
                                    }

                                    if (currentTap ==
                                        correctAnswer[currentTurn - 1]) {
                                      if (currentTurn < 3) {
                                        tapCounter = 0;
                                      }
                                      if (currentTurn == 3) {
                                        //  progress[currentTurn] = 0;
                                        tapCounter = 0;
                                      }
                                    }
                                  }
                                },
                                leading: (currentTap == position + 1)
                                    ? ((_progress > 0 && _progress < 1)
                                        ? Icon(Icons.pause_circle_filled)
                                        : Icon(Icons.play_circle_filled))
                                    : Icon(Icons.play_circle_filled),
                                title: Text(functionFormulas[position],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    )),
                                trailing: onTap[position]
                                    ? (position ==
                                            correctAnswer[currentTurn - 1] - 1)
                                        ? Icon(Icons.check_circle)
                                        : Icon(Icons.cancel)
                                    : Icon(Icons.more_vert),
                              ),
                            );
                          },
                        ))),
                  ),
                  */
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 500,
                      width: 500,
                      //  decoration: BoxDecoration(border: Border.all()),
                      child: Stack(children: <Widget>[
                        Container(
                            height: 500,
                            width: 500,
                            child: Image.asset("assets/images/emptygrid.png")),
                        Align(
                          alignment: Alignment(
                              2 *
                                      (beginpath.dx +
                                          _progress *
                                              (endpath.dx - beginpath.dx)) /
                                      860 -
                                  1,
                              0),
                          child: Card(
                            child: Image.asset("assets/images/cellulox.png",
                                height: 48, width: 48),
                          ),
                        ),
                        Align(
                          alignment: Alignment(
                              -0.07,
                              2 *
                                      (beginpath.dy +
                                          _progress *
                                              (endpath.dy - beginpath.dy)) /
                                      860 -
                                  1),
                          child: Card(
                            child: Image.asset("assets/images/celluloy.png",
                                height: 48, width: 48),
                          ),
                        ),
                        Align(
                          alignment: Alignment(
                              2 *
                                      (beginpath.dx +
                                          _progress *
                                              (endpath.dx - beginpath.dx)) /
                                      860 -
                                  1,
                              2 *
                                      (beginpath.dy +
                                          _progress *
                                              (endpath.dy - beginpath.dy)) /
                                      860 -
                                  1),
                          child: Card(
                            child: Image.asset(
                                "assets/images/celluloPurple.png",
                                height: 48,
                                width: 48),
                          ),
                        ),
                        CustomPaint(
                          size: Size(500, 500),
                          painter: LinePainter(_progress, beginpath, endpath),
                        ),
                      ])),
                  SizedBox(
                    height: 20,
                  ),
                  // MembersBar(
                  //    curTurn: currentTurn,
                  //  ),
                ]))));
  }
}
