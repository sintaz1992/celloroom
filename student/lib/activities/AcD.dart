import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:loading_animations/loading_animations.dart';
import 'dart:async';
import 'package:student/model/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:student/widgets/ShapePainter.dart';

class AcD extends StatefulWidget {
  AcD({Key key}) : super(key: key);

  @override
  _AcDState createState() => _AcDState();
}

class _AcDState extends State<AcD> {
  // Activity_Independent
  var elapseTimer = new Stopwatch();
  Timer timerCelluloPosition;
  Timer timerCelluloPositiontoserver;
  Timer timerCheckCelluloGame;
  int currentTurn = 1;
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
  Animation<double> animationRobotPath;

// Learning
  List<int> gameScore = [0, 0, 0];
  List<int> celluloEnergy = [6, 6, 6];
  List<int> mistakesSlope = [0, 0, 0];
  List<int> mistakesIntrepet = [0, 0, 0];
  List<int> mistakesInitialPosition = [0, 0, 0];
  int score = 6;
//Activity Dependent
  bool enterBorderX = false;
  bool enterBorderY = false;
  bool enterBorderpolygonX = false;
  bool enterBorderpolygonY = false;
  bool enterBorderRectX = false;
  bool enterBorderRectY = false;
  int scoreX = 6;
  int scoreY = 6;
  int trappedCircleX;
  int trappedCircleY;
  int trappedRectangleX;
  int trappedRectangleY;
  int trappedPolygonX;
  int trappedPolygonY;

  bool reachend = false;
  bool gameoverY = false;
  bool startGame = false;
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
  static List<Offset> pointPosition = [
    Offset(80, 80),
    Offset(760, 80),
    Offset(80, 760),
    Offset(760, 760)
  ];
// map-related
  double radiuosStart = 45;
  //final Offset startPoint = new Offset(0.0, 0.0);
  //inal Offset endPoint = new Offset(0.0, 0.0);
  final double mapSizeWidth = 860;
  final double mapSizeHeight = 860;
  double coeffScreenMapWidth;
  double coeffScreenMapHeight;

  var mapShape = [];

  @override
  void initState() {
    super.initState();
    //   dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    // dbRef.child('students').child(student.id).child('currentActivity').set("AcD");
    elapseTimer.start();
    //  coeffScreenMapHeight =
    //    MediaQuery.of(context).size.width * 0.9 / mapSizeWidth;
    // coeffScreenMapHeight =
    //   MediaQuery.of(context).size.height * 0.9 / mapSizeHeight;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //  title: const Text('Avoid the hidden obstacles'),

            ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              SizedBox(height: 200),
              Image.asset(
                'images/student.png',
                //  height: 500.0,
                height: 400.0,
                // alignment: Alignment.center,
              ),
              Container(
                height: 70,
                width: 600,
                child: ListTile(
                  title: Text(
                    'A good student always listens to the teacher.',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              LoadingFlipping.circle(
                  //color: Colors.blue,
                  ),
            ])));
  }
}
