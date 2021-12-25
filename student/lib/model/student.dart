//import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:student/model/Cellulo.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:student/screens/loginpage_character.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:student/services/app_translations.dart';
import 'package:student/widgets/showAlertDialog.Dart';
//import 'package:student/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student/gameDynamic/Ac8.dart';
import 'package:student/gameDynamic/Ac7.dart';
import 'package:student/gameDynamic/Ac9.dart';
import 'package:student/gameDynamic/Ac6.dart';
import 'package:student/gameDynamic/Ac5.dart';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:student/gameDynamic/Ac3.dart';
import 'package:student/gameDynamic/Ac2.dart';
import 'package:student/gameDynamic/Ac1.dart';
import 'package:student/widgets/message.dart';
import 'package:student/commonFunctions/playaudio.dart';
import 'package:student/commonFunctions/groupnames.dart';

Student student = new Student("");

class Student extends ChangeNotifier {
  List<String> acList = [
    'Ac1',
    'Ac2',
    'Ac3',
    'Ac4',
    'Ac5',
    'Ac6',
    'Ac7',
    'Ac8',
    'Ac9',
    'Ac10',
  ];
  double playgroundwidth = 500.0;
  double playgroundheight = 500.0;
  double cellulosize = 60;
  double radfinish = 40;
  String sessionID = '22';
  bool automode = true;
  String id = "1";
  String tabletStatus = 'YES';
  String groupname;
  int timebefore = 0;
  List<double> velocityx = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  List<double> error = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  List<double> velocityy = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
//  String _title;
  // String _description;
  int inactivity = 0;
  String name;
  DocumentReference dbRef;
  DocumentReference dbRef2;
  DocumentReference dbRef3;
  DocumentReference dbGroupRef;
  DocumentReference dbSessionRef;
  bool permisMoveX = true;
  bool permisMoveY = true;
  bool permisMoveV = true;
  int scoreX = 3;
  int scoreY = 3;
  int scoreV = 3;
  List<int> gscore = [0, 0, 0, 0, 0, 0, 0, 0];
  bool report = true;
  double mapcellulotreshold = 100;
  String groupmember1name = '';
  String groupmember2name = '';
  String groupmember3name = '';
  String groupmember4name = '';
  int numStudents = 1;
  bool clickR = true;
  bool clickB = true;
  bool clickM = true;
  bool clickN = true;
  bool reachendX = false;
  bool reachendY = false;
  bool reachendV = false;
  int groupCurrentTurn = 1;
  int role = 1;
  bool ispaused = false;
  bool showinstruction = true;
  bool showfinish = false;

  String rolemanM = '';
  String rolemanB = '';
  String rolemanR = '';
  Cellulo cellulox = new Cellulo(0);
  Cellulo celluloy = new Cellulo(1);
  Cellulo cellulov = new Cellulo(2);
  Cellulo cellulow = new Cellulo(3);
  //Game8 acgame8 = new Game8();
  Game9 acgame9 = new Game9();
  //Game6 acgame6 = new Game6();

  Game7 acgame7 = new Game7();
  Game6 acgame6 = new Game6();

  Game5 acgame5 = new Game5();
  Game4 acgame4 = new Game4();
  Game3 acgame3 = new Game3();
  Game2 acgame2 = new Game2();
  Game1 acgame1 = new Game1();
  bool isAlertShown = true;
  bool startGame = false;
  int countTimerEngagement = 0;
  static int simulationSpeed = 500;
  static int serverSpeed = 1000;
  bool isTablet = true;
  double initialcellulosize = 70;
  double mapSizeWidth = 760;
  double mapSizeHeight = 760;
  double mapSizeWidthfull = 860;
  double mapSizeHeightfull = 860;
  int numTurn = 3;
  List<int> gtime = [
    0,
    0,
    0,
    0,
  ];
  List<int> starttimer = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  bool reachendflag = false;
  Color nextturnbuttoncolor = Colors.grey;
  Color nextmissionbuttoncolor = Colors.grey;
  Timer timerturnColorButton =
      new Timer.periodic(new Duration(milliseconds: 2000), (time) {
    if (student.nextturnbuttoncolor == Colors.grey) {
      student.nextturnbuttoncolor = Colors.orange;
    } else {
      student.nextturnbuttoncolor = Colors.grey;
    }
    student.notifyListeners();
  });
  Timer timermissionturnColorButton =
      new Timer.periodic(new Duration(milliseconds: 2000), (time) {
    if (student.nextmissionbuttoncolor == Colors.grey) {
      student.nextmissionbuttoncolor = Colors.orange;
    } else {
      student.nextmissionbuttoncolor = Colors.grey;
    }
  });
  TextStyle appbar =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22);

  TextStyle titletext =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);

  TextStyle titleapptext =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16);

  TextStyle buttontext =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w600);

  TextStyle fieldtext =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18);

  TextStyle hinttext =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14);
  TextStyle hinttexts =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 10);
  TextStyle hinttext2 = GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600));
  bool startGameX = false;
  int scoreMax = 6;
  bool turnchnaged = false;
  bool showpause = false;
  var groupPolicy = [
    ['T', 'T', 'T'],
    ['T', 'T', 'T'],
    ['T', 'T', 'T'],
    ['T', 'T', 'T'],
  ];
  var groupPolicy2 = [
    ['T', 'T', 'T'],
    ['T', 'T', 'T'],
    ['T', 'T', 'T'],
    ['T', 'T', 'T'],
  ];

  TextEditingController controlleridx = TextEditingController();

  TextEditingController controlleridy = TextEditingController();

  bool joinSession = false;
  bool iamready = false;
  String curLang = 'en';
  bool is4person = false;

  List<int> activityTime = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  static List<Offset> pointPosition = [
    Offset(180, 100),
    Offset(600, 40),
    Offset(1, 683),
    Offset(760, 760)
  ];
  List<Offset> pointhitX = [Offset(0.0, 0.0)];
  List<Offset> pointhitY = [Offset(0.0, 0.0)];
  List<Offset> pointhitV = [Offset(0.0, 0.0)];
  var mapShape = [
    [
      {
        'numCircles': 12,
        'originCircles': [
          Offset(300, 646),
          Offset(400, 546),
          Offset(400, 246),
          Offset(400, 446),
          Offset(300, 446),
          Offset(200, 446),
          Offset(600, 346),
          Offset(100, 346),
          Offset(200, 246),
          Offset(100, 446),
          Offset(500, 246),
          Offset(300, 346),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'numRectangles': 0,
        'originRectangles': [Offset(350, 494), Offset(250, 294)],
        'widthRectangles': [100.0, 100.0],
        'heightRectangles': [100.0, 100.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 3, 5, 4, 4],
        'radiusPolygon': [50.0, 50.0, 70.0, 60.0, 80.0],
        'centerPolygon': [
          Offset(100, 346),
          Offset(400, 246),
          Offset(600, 250),
          Offset(600, 500),
          Offset(780, 400)
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 146)
      },
      {
        'numCircles': 12,
        'originCircles': [
          Offset(500, 646),
          Offset(200, 146),
          Offset(400, 246),
          Offset(400, 546),
          Offset(300, 446),
          Offset(200, 346),
          Offset(500, 246),
          Offset(500, 146),
          Offset(640, 646),
          Offset(240, 146),
          Offset(640, 546),
          Offset(340, 246),
          Offset(40, 446),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'numRectangles': 0,
        'originRectangles': [
          Offset(600, 200),
          Offset(750, 500),
          Offset(600, 360)
        ],
        'widthRectangles': [100.0, 100.0, 100.0],
        'heightRectangles': [100.0, 100.0, 100.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 5, 4, 4],
        'radiusPolygon': [50.0, 50.0, 70.0, 70.0],
        'centerPolygon': [Offset(300, 200), Offset(500, 650), Offset(780, 300)],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 250)
      },
      {
        'numCircles': 12,
        'originCircles': [
          Offset(300, 646),
          Offset(100, 246),
          Offset(400, 546),
          Offset(500, 446),
          Offset(400, 346),
          Offset(600, 246),
          Offset(100, 146),
          Offset(100, 446),
          Offset(300, 646),
          Offset(30, 346),
          Offset(200, 546),
          Offset(400, 146),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'numRectangles': 0,
        'originRectangles': [Offset(700, 130), Offset(350, 560)],
        'widthRectangles': [100.0, 150.0],
        'heightRectangles': [100.0, 150.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 4, 4],
        'radiusPolygon': [50.0, 50.0, 50.0],
        'centerPolygon': [
          Offset(280, 100),
          Offset(170, 390),
          Offset(520, 220),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 130)
      },
    ],
    [
      {
        'numCircles': 0,
        'originCircles': [
          Offset(390, 300),
          Offset(160, 70),
          Offset(60, 360),
          Offset(560, 690)
        ],
        'radiuosCircles': [60.0, 50.0, 50.0, 40.0],
        'numRectangles': 0,
        'originRectangles': [
          Offset(300, 100),
          Offset(400, 460),
          Offset(600, 560),
          Offset(780, 460),
        ],
        'widthRectangles': [100.0, 100.0, 100.0, 100.0, 150.0],
        'heightRectangles': [100.0, 100.0, 100.0, 100.0, 150.0],
        'numPolygons': 6,
        'sidesofPolygon': [
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4
        ],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'centerPolygon': [
          Offset(500, 646),
          Offset(700, 646),
          Offset(400, 546),
          Offset(700, 346),
          Offset(200, 346),
          Offset(100, 146),
          Offset(300, 446),
          Offset(200, 246),
          Offset(400, 346),
          Offset(400, 246),
          Offset(400, 146),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 140)
      },
      {
        'numCircles': 0,
        'originCircles': [
          Offset(390, 300),
          Offset(160, 70),
          Offset(60, 360),
          Offset(560, 690)
        ],
        'radiuosCircles': [60.0, 50.0, 50.0, 40.0],
        'numRectangles': 0,
        'originRectangles': [
          Offset(300, 130),
          Offset(650, 360),
          Offset(750, 360)
        ],
        'widthRectangles': [
          150.0,
          150.0,
          200.0,
          150.0,
        ],
        'heightRectangles': [150.0, 150.0, 200.0, 150.0],
        'numPolygons': 6,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'centerPolygon': [
          Offset(100, 346),
          Offset(200, 546),
          Offset(300, 146),
          Offset(400, 346),
          Offset(550, 446),
          Offset(290, 586),
          Offset(640, 346),
          Offset(500, 346),
          Offset(500, 246),
          Offset(750, 706),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 100)
      },
      {
        'numCircles': 0,
        'originCircles': [
          Offset(390, 300),
          Offset(160, 70),
          Offset(60, 360),
          Offset(560, 690)
        ],
        'radiuosCircles': [60.0, 50.0, 50.0, 40.0],
        'numRectangles': 0,
        'originRectangles': [
          Offset(350, 280),
          Offset(300, 540),
          Offset(700, 520)
        ],
        'widthRectangles': [150.0, 200.0, 100.0],
        'heightRectangles': [150.0, 200.0, 100.0],
        'numPolygons': 6,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'centerPolygon': [
          Offset(400, 646),
          Offset(400, 546),
          Offset(300, 446),
          Offset(200, 346),
          Offset(500, 146),
          Offset(600, 646),
          Offset(400, 746),
          Offset(650, 190),
          Offset(400, 250),
          Offset(180, 60),
          Offset(650, 190),
          Offset(400, 250),
          Offset(580, 630),
          Offset(650, 190),
          Offset(400, 250),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 300)
      },
    ],
    [
      {
        'numCircles': 0,
        'originCircles': [Offset(0, 0)],
        'radiuosCircles': [0.0],
        'numRectangles': 0,
        'originRectangles': [
          Offset(500, 360),
          Offset(300, 300),
          Offset(500, 460)
        ],
        'widthRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'heightRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'numPolygons': 5,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4, 4, 4],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'centerPolygon': [
          Offset(470, 190),
          Offset(410, 580),
          Offset(530, 326),
          Offset(230, 426),
          Offset(530, 126),
          Offset(660, 310),
          Offset(530, 126),
          Offset(660, 310),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Student.pointPosition[1]
      },
      {
        'numCircles': 0,
        'originCircles': [Offset(0, 0)],
        'radiuosCircles': [0.0],
        'numRectangles': 0,
        'originRectangles': [
          Offset(600, 646),
          Offset(600, 546),
          Offset(600, 446),
          Offset(600, 346),
          Offset(600, 246),
          Offset(200, 346),
          Offset(300, 346),
          Offset(200, 46),
          Offset(600, 346),
          Offset(600, 246),
          Offset(700, 660)
        ],
        'widthRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'heightRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'numPolygons': 5,
        'sidesofPolygon': [
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
          4,
        ],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'centerPolygon': [
          Offset(670, 660),
          Offset(700, 500),
          Offset(300, 380),
          Offset(580, 170),
          Offset(180, 60),
          Offset(590, 470),
          Offset(270, 310),
          Offset(220, 66),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(740, 60),
      },
      {
        'numCircles': 0,
        'originCircles': [Offset(0, 0)],
        'radiuosCircles': [0.0],
        'numRectangles': 0,
        'originRectangles': [
          Offset(600, 446),
          Offset(500, 446),
          Offset(700, 446),
          Offset(300, 346),
          Offset(400, 246),
          Offset(200, 646),
          Offset(700, 246),
          Offset(200, 46),
        ],
        'widthRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'heightRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'numPolygons': 5,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4, 4, 4],
        'radiusPolygon': [45.0, 45.0, 45.0, 45.0, 45.0, 45.0, 45.0, 45.0, 45.0],
        'centerPolygon': [
          Offset(680, 470),
          Offset(560, 260),
          Offset(100, 360),
          Offset(590, 356),
          Offset(170, 66),
          Offset(500, 654),
          Offset(650, 216),
          Offset(210, 66),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Student.pointPosition[1]
      },
    ],
    [
      {
        'numCircles': 5,
        'originCircles': [
          Offset(740, 530),
          Offset(537, 638),
          Offset(535, 100),
          Offset(740, 96),
          Offset(225, 323),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'numRectangles': 0,
        'originRectangles': [
          Offset(500, 360),
          Offset(300, 300),
          Offset(500, 460)
        ],
        'widthRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'heightRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'numPolygons': 5,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'centerPolygon': [
          Offset(470, 180),
          Offset(200, 570),
          Offset(300, 186),
          Offset(700, 392),
          Offset(410, 76),
          Offset(310, 76),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Student.pointPosition[1]
      },
      {
        'numCircles': 4,
        'originCircles': [
          Offset(537, 216),
          Offset(435, 532),
          Offset(760, 110),
          Offset(210, 530),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'numRectangles': 0,
        'originRectangles': [
          Offset(500, 360),
          Offset(300, 300),
          Offset(500, 460)
        ],
        'widthRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'heightRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'numPolygons': 5,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'centerPolygon': [
          Offset(370, 280),
          Offset(560, 670),
          Offset(710, 186),
          Offset(570, 172),
          Offset(230, 530),
          Offset(460, 410),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Student.pointPosition[1]
      },
      {
        'numCircles': 4,
        'originCircles': [
          Offset(760, 426),
          Offset(210, 432),
          Offset(530, 320),
          Offset(430, 326),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'numRectangles': 0,
        'originRectangles': [
          Offset(500, 360),
          Offset(300, 300),
          Offset(500, 460)
        ],
        'widthRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'heightRectangles': [
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0,
          100.0
        ],
        'numPolygons': 5,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4],
        'radiusPolygon': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
        ],
        'centerPolygon': [
          Offset(380, 560),
          Offset(470, 70),
          Offset(670, 376),
          Offset(200, 582),
          Offset(720, 186),
          Offset(270, 400),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Student.pointPosition[1]
      },
    ],
    [
      {
        'startCenter': [
          Offset(76, 795),
          Offset(72, 721),
          Offset(8, 633),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(751, 109),
          Offset(753, 28),
          Offset(824, 239),
          Offset(658, 117)
        ]
      },
      {
        'startCenter': [
          Offset(15, 419),
          Offset(16, 766),
          Offset(244, 28),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(748, 230),
          Offset(830, 370),
          Offset(631, 842),
          Offset(658, 117)
        ]
      },
      {
        'startCenter': [
          Offset(145, 639),
          Offset(18, 350),
          Offset(320, 849),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(721, 61),
          Offset(839, 350),
          Offset(550, 55),
          Offset(658, 117)
        ]
      },
    ],
    [
      {
        'startCenter': [
          Offset(17, 351),
          Offset(106, 760),
          Offset(347, 772),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(844, 358),
          Offset(451, 21),
          Offset(691, 29),
          Offset(658, 117)
        ]
      },
      {
        'startCenter': [
          Offset(200, 761),
          Offset(208, 791),
          Offset(50, 550),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(555, 35),
          Offset(635, 102),
          Offset(782, 180),
          Offset(658, 117)
        ]
      },
      {
        'startCenter': [
          Offset(355, 832),
          Offset(260, 761),
          Offset(79, 705),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(521, 40),
          Offset(848, 117),
          Offset(515, 28),
          Offset(658, 117)
        ]
      },
    ],
    [
      {
        'startCenter': [
          Student.pointPosition[2],
          Offset(276, 785),
          Offset(276, 75),
        ],
        'endCenter': [Offset(768, 82), Offset(276, 75), Offset(276, 785)]
      },
      {
        'startCenter': [
          Student.pointPosition[2],
          Offset(276, 785),
          Offset(276, 75),
        ],
        'endCenter': [Offset(768, 82), Offset(276, 75), Offset(276, 785)]
      },
      {
        'startCenter': [
          Student.pointPosition[2],
          Offset(276, 785),
          Offset(276, 75),
        ],
        'endCenter': [Offset(768, 82), Offset(276, 75), Offset(276, 785)]
      },
    ],
    [
      {'startCenter': Student.pointPosition[2], 'endCenter': Offset(700, 146)},
      {'startCenter': Student.pointPosition[2], 'endCenter': Offset(700, 250)},
      {'startCenter': Student.pointPosition[2], 'endCenter': Offset(700, 130)},
    ],
    [
      {
        'startCenter': [
          Offset(39, 723),
          Offset(25, 667),
          Offset(32, 700),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(632, 126),
          Offset(307, 84),
          Offset(403, 168),
          Offset(658, 117)
        ]
      },
      {
        'startCenter': [
          Offset(24, 580),
          Offset(34, 582),
          Offset(26, 653),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(553, 26),
          Offset(720, 583),
          Offset(604, 360),
          Offset(658, 117)
        ]
      },
      {
        'startCenter': [
          Offset(24, 74),
          Offset(23, 178),
          Offset(28, 430),
          Offset(169, 740),
        ],
        'endCenter': [
          Offset(575, 613),
          Offset(577, 717),
          Offset(655, 20),
          Offset(658, 117)
        ]
      },
    ],
    [
      {
        'numCircles': 12,
        'originCircles': [
          Offset(300, 646),
          Offset(400, 546),
          Offset(400, 246),
          Offset(400, 446),
          Offset(300, 446),
          Offset(200, 446),
          Offset(600, 346),
          Offset(100, 346),
          Offset(200, 246),
          Offset(100, 446),
          Offset(500, 246),
          Offset(300, 346),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'numRectangles': 0,
        'originRectangles': [Offset(350, 494), Offset(250, 294)],
        'widthRectangles': [100.0, 100.0],
        'heightRectangles': [100.0, 100.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 3, 5, 4, 4],
        'radiusPolygon': [50.0, 50.0, 70.0, 60.0, 80.0],
        'centerPolygon': [
          Offset(100, 346),
          Offset(400, 246),
          Offset(600, 250),
          Offset(600, 500),
          Offset(780, 400)
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 146)
      },
      {
        'numCircles': 12,
        'originCircles': [
          Offset(500, 646),
          Offset(200, 146),
          Offset(400, 246),
          Offset(400, 546),
          Offset(300, 446),
          Offset(200, 346),
          Offset(500, 246),
          Offset(500, 146),
          Offset(640, 646),
          Offset(240, 146),
          Offset(640, 546),
          Offset(340, 246),
          Offset(40, 446),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'numRectangles': 0,
        'originRectangles': [
          Offset(600, 200),
          Offset(750, 500),
          Offset(600, 360)
        ],
        'widthRectangles': [100.0, 100.0, 100.0],
        'heightRectangles': [100.0, 100.0, 100.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 5, 4, 4],
        'radiusPolygon': [50.0, 50.0, 70.0, 70.0],
        'centerPolygon': [Offset(300, 200), Offset(500, 650), Offset(780, 300)],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 250)
      },
      {
        'numCircles': 12,
        'originCircles': [
          Offset(300, 646),
          Offset(100, 246),
          Offset(400, 546),
          Offset(500, 446),
          Offset(400, 346),
          Offset(600, 246),
          Offset(100, 146),
          Offset(100, 446),
          Offset(300, 646),
          Offset(30, 346),
          Offset(200, 546),
          Offset(400, 146),
        ],
        'radiuosCircles': [
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0,
          45.0
        ],
        'numRectangles': 0,
        'originRectangles': [Offset(700, 130), Offset(350, 560)],
        'widthRectangles': [100.0, 150.0],
        'heightRectangles': [100.0, 150.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 4, 4],
        'radiusPolygon': [50.0, 50.0, 50.0],
        'centerPolygon': [
          Offset(280, 100),
          Offset(170, 390),
          Offset(520, 220),
        ],
        'startCenter': Student.pointPosition[2],
        'endCenter': Offset(700, 130)
      },
    ],
  ];

  String currentActivity = 'Ac0';
  String prevActivity = 'Ac0';
  String aclimit = 'Ac4t';
  var elapseTimer = new Stopwatch();
  final GlobalKey<NavigatorState> navigatorKeygame =
      new GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> keylogin = new GlobalKey<NavigatorState>();

  StreamSubscription<DocumentSnapshot> _onStudentChangedSubscription;
  StreamSubscription<QuerySnapshot> _onrobotBluepositionAddedSubscription;
  StreamSubscription<QuerySnapshot> _onactivitypermittedSubscription;
  StreamSubscription<QuerySnapshot> _onteacherpausedSubscription;
  StreamSubscription<QuerySnapshot> _onteacherlimitedSubscription;
  StreamSubscription<QuerySnapshot> _onnumberstudentchangedSubscription;
  StreamSubscription<QuerySnapshot> _onrobotRedpositionAddedSubscription;
  StreamSubscription<DocumentSnapshot> _onturnchangedSubscription;
  StreamSubscription<QuerySnapshot> _oncellulowtargetaddedSubscription;
  StreamSubscription<QuerySnapshot> _onrewardtargetaddedSubscription;
  StreamSubscription<QuerySnapshot> _onmessagextargetaddedSubscription;
  StreamSubscription<QuerySnapshot> _onmessageytargetaddedSubscription;
  StreamSubscription<QuerySnapshot> _onstartgameaddedSubscription;
  StreamSubscription<QuerySnapshot> _onspacemanaddedSubscription;
  StreamSubscription<QuerySnapshot> _onreachendVSubscription;
  Timer timerEnagagement =
      new Timer.periodic(new Duration(seconds: 60), (time) {
    //print('timeengagem');
    student.countTimerEngagement = student.countTimerEngagement + 1;
    var limitmaxpersecond = 1;
    /*
    if (student.groupPolicy[student.role - 1][student.groupCurrentTurn - 1] ==
        'T')
        
      student.dbSessionRef.collection('engagement').add({
        "groupID": student.groupname,
        "acID": student.currentActivity,
        "engagementX": student.cellulox.traveledDistance /
            student.countTimerEngagement /
            60 /
            limitmaxpersecond,
        "engagementY": student.celluloy.traveledDistance /
            student.countTimerEngagement /
            60 /
            limitmaxpersecond,
      });
   */
    // student.cellulox.traveledDistance = 0.0;
    //student.celluloy.traveledDistance = 0.0;
  });

  // Time timeJoined;
  Student(this.name);

  void switchactivity() {
    navigatorKeygame.currentState.pushReplacementNamed(student.currentActivity);
    print('acchnagedreal');
    print(student.currentActivity);
  }

  void activityChanged() {
    student.startGame = true;
    // student.startGameX = true;
    student.scoreX = 0;
    student.scoreY = 0;
    student.scoreV = 0;
    for (int i = 6; i > 0; i--) {
      cellulox.setColor(0, 0, 0, 1, i - 1, 0);
    }
    for (int i = 6; i > 0; i--) {
      celluloy.setColor(0, 0, 0, 1, i - 1, 1);
    }
    student.reachendX = false;
    student.reachendY = false;
    student.reachendV = false;
  }

  void setupDatabse() {
    _onturnchangedSubscription =
        student.dbGroupRef.snapshots().listen(oncurrentturnchanged);

    _onactivitypermittedSubscription = student.dbGroupRef
        .collection('teacherpermis')
        .snapshots()
        .listen(onactivitypermitted);
    _onnumberstudentchangedSubscription = student.dbGroupRef
        .collection('numberstudents')
        .snapshots()
        .listen(onnumberstudentchanged);
  }

  void setupDatabse2() {
    /*
    _onrobotBluepositionAddedSubscription = student.dbGroupRef
        .collection('celluloPosition')
        .doc('celluloBlue')
        .collection('position')
        .snapshots()
        .listen(onBluecelluloPositionAdded);
    _onrobotRedpositionAddedSubscription = student.dbGroupRef
        .collection('celluloPosition')
        .doc('celluloRed')
        .collection('position')
        .snapshots()
        .listen(onRedcelluloPositionAdded);
*/
/*
    _oncellulowtargetaddedSubscription = student.dbGroupRef
        .collection('cellulowtarget')
        .snapshots()
        .listen(oncellulowtargetadded);
*/
    _onrewardtargetaddedSubscription = student.dbGroupRef
        .collection('rewards')
        .snapshots()
        .listen(onrewardadded);

    _onteacherpausedSubscription = student.dbGroupRef
        .collection('teacherpause')
        .snapshots()
        .listen(onteacherPaused);

    _onteacherlimitedSubscription = student.dbGroupRef
        .collection('teacheraclimit')
        .snapshots()
        .listen(onteacherLimited);

    _onspacemanaddedSubscription = student.dbGroupRef
        .collection('spacemans')
        .snapshots()
        .listen(onspacemanadded);
    _onreachendVSubscription = student.dbGroupRef
        .collection('reachendV')
        .snapshots()
        .listen(onreachendVadded);
  }

  onactivitypermitted(QuerySnapshot event) {
    if ((event.docChanges.first.doc.get('permis') == true)) {
      print('teacher');

      student.joinSession = true;

      Navigator.pushReplacement(student.keylogin.currentState.context,
          MaterialPageRoute(builder: (context) => LoginPage2()));
    }
  }

  onreachendVadded(QuerySnapshot event) {
    // student.reachendV = ((event.docChanges.first.doc.get('reachendV')));
    //student.acgame4.notifyListeners();
  }

  onteacherPaused(QuerySnapshot event) {
    student.ispaused = ((event.docChanges.first.doc.get('pause')));
    if (student.ispaused == true) {
      // showPauseDialog(navigatorKeygame.currentState.context);
      student.permisMoveV = false;
      student.permisMoveX = false;
      student.permisMoveY = false;

      student.showpause = true;
    }
    if (student.ispaused == false) {
      student.permisMoveV = true;
      student.permisMoveX = true;
      student.permisMoveY = true;
      student.showpause = false;
    }

    if (student.currentActivity == 'Ac3' && student.ispaused == true) {
      student.acgame3.timerlifespaceman.cancel();
    }

    if (student.currentActivity == 'Ac3' && student.ispaused == false) {
      student.acgame3.definetimer();
    }

    if (student.currentActivity == 'Ac4' && student.ispaused == true) {
      student.acgame4.timerlifespaceman.cancel();
    }

    if (student.currentActivity == 'Ac4' && student.ispaused == false) {
      student.acgame4.definetimer();
    }
  }

  onteacherLimited(QuerySnapshot event) {
    student.aclimit = ((event.docChanges.first.doc.get('limit')));
  }

  onnumberstudentchanged(QuerySnapshot event) {
    student.is4person = ((event.docChanges.first.doc.get('is4person')));
    student.notifyListeners();
  }

  onspacemanadded(QuerySnapshot event) {
    if (student.currentActivity == 'Ac4') {
      if (student.acgame4.startgame == true) {
        for (int i = 0; i < 6; i++) {
          student.acgame4.spacemanVisible[i] =
              (event.docChanges.first.doc.get('value')[i]);
          if ((event.docChanges.first.doc.get('value')[i]) == 0 && i != 0) {
            if (student.acgame4.spacemanVisible[i - 1] == 1) {
              playHandler('images/smb_vine.mp3');
              if (student.groupCurrentTurn == 1) {
                var reward = 0;
                //print(student.acgame4.spacemanVisible);
                for (int i = 0;
                    i < student.acgame4.spacemanVisible.length;
                    i++) {
                  if (student.acgame4.spacemanVisible[i] == 1)
                    reward = reward + 1;
                }
                student.gscore[3] = reward;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 2) {
                var reward = 0;
                //print(student.acgame4.spacemanVisible);
                for (int i = 0;
                    i < student.acgame4.spacemanVisible.length;
                    i++) {
                  if (student.acgame4.spacemanVisible[i] == 1)
                    reward = reward + 1;
                }
                student.gscore[3] = reward + student.acgame4.saved[0];
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 3) {
                var reward = 0;
                //print(student.acgame4.spacemanVisible);
                for (int i = 0;
                    i < student.acgame4.spacemanVisible.length;
                    i++) {
                  if (student.acgame4.spacemanVisible[i] == 1)
                    reward = reward + 1;
                }
                student.gscore[3] = reward +
                    student.acgame4.saved[0] +
                    student.acgame4.saved[1];
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              {
                student.acgame4.tasktext = AppTranslations.of(
                        student.navigatorKeygame.currentState.context)
                    .text("instruction_savespaceman");

                if (i == 5) {
                  var numsavedast = 0;
                  for (int numi = 0; numi < 5; numi++) {
                    if (student.acgame4.spacemanVisible[numi] == 1)
                      numsavedast =
                          numsavedast + student.acgame4.spacemanVisible[numi];
                  }

                  student.acgame4.showinstructionT = true;
                  print('Ac4game');
                  if (student.groupCurrentTurn == 1)
                    student.acgame4.saved[0] = numsavedast;
                  if (student.groupCurrentTurn == 2)
                    student.acgame4.saved[1] = numsavedast;
                  student.acgame4.instructionText = AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("victoryEnd4") +
                      numsavedast.toString() +
                      AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("victoryEnd4continue");
                  student.acgame4.notifyListeners();
                  student.acgame4.tasktext = student.curLang == 'fa'
                      ? AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitfor") +
                          AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitnextturn")
                      : AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitfor") +
                          capitanm() +
                          AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitnextturn");

                  student.dbSessionRef.collection("turnFinished").add({
                    "d_group": student.groupname,
                    "numAc": 3,
                    'numTurn': student.groupCurrentTurn,
                    'rolevalue': 6,
                  });
                }

                student.acgame4.chnagecolor();
                student.acgame4.valuelifespaceman[i] = 1.0;
                // student.acgame4.animationlifespaceman.cancel();
                /*
                student.acgame4.animationlifespaceman =
                    new Timer.periodic(new Duration(seconds: 1), (time) {
                  if (!student.showpause) {
                    student.acgame4.valuelifespaceman[i] =
                        student.acgame4.valuelifespaceman[i] -
                            1 / student.acgame4.timealive;
                    //   print(valuelifespaceman);
                    if (student.acgame4.valuelifespaceman[i] <
                        2 / student.acgame4.timealive) {
                      student.acgame4.valuelifespaceman[i] = 0;
                      print('canceled1');
                      student.acgame4.animationlifespaceman.cancel();
                    }
                  } else {
                    student.acgame4.animationlifespaceman.cancel();

                    Future(() {
                      if (!student.showpause) return true;
                    }).then((value) {
                      print('The value is $value.');
                    });
                  }
                });
                */
                /*
            runAnimation(
                'We saved a spacemen at coordinate position (' +
                    student
                        .acgame4
                        .spacemantruex[
                            (student.groupCurrentTurn - 1) * 5 + i - 1]
                        .toString() +
                    ',' +
                    student
                        .acgame4
                        .spacemantruey[
                            (student.groupCurrentTurn - 1) * 5 + i - 1]
                        .toString() +
                    '). Where is the next one?',
                false,
                '');
          */
              }
            }

            if (student.acgame4.spacemanVisible[i - 1] == -1) {
              playHandler('images/smb_mariodie.mp3');
              student.acgame4.valuelifespaceman[i] = 1.0;
              //student.acgame4.animationlifespaceman.cancel();
              /*
              student.acgame4.animationlifespaceman =
                  new Timer.periodic(new Duration(seconds: 1), (time) {
                if (!student.showpause) {
                  student.acgame4.valuelifespaceman[i] =
                      student.acgame4.valuelifespaceman[i] -
                          1 / student.acgame4.timealive;
                  //   print(valuelifespaceman);
                  if (student.acgame4.valuelifespaceman[i] <
                      2 / student.acgame4.timealive) {
                    student.acgame4.valuelifespaceman[i] = 0;
                    // print('canceled2');
                    student.acgame4.animationlifespaceman.cancel();
                  }
                } else {
                  student.acgame4.animationlifespaceman.cancel();

                  Future(() {
                    if (!student.showpause) return true;
                  }).then((value) {
                    print('The value is $value.');
                  });
                }
              });
*/

              student.acgame4.tasktext = AppTranslations.of(
                      student.navigatorKeygame.currentState.context)
                  .text("instruction_lostspaceman");
              student.acgame4.chnagecolor();

              if (i == 5) {
                var numsavedast = 0;
                for (int numi = 0; numi < 5; numi++) {
                  if (student.acgame4.spacemanVisible[numi] == 1)
                    numsavedast =
                        numsavedast + student.acgame4.spacemanVisible[numi];
                }

                student.acgame4.showinstructionT = true;
                print('Ac4game');
                if (student.groupCurrentTurn == 1)
                  student.acgame4.saved[0] = numsavedast;
                if (student.groupCurrentTurn == 2)
                  student.acgame4.saved[1] = numsavedast;
                student.acgame4.instructionText = AppTranslations.of(
                            student.navigatorKeygame.currentState.context)
                        .text("victoryEnd4") +
                    numsavedast.toString() +
                    AppTranslations.of(
                            student.navigatorKeygame.currentState.context)
                        .text("victoryEnd4continue");

                if ((student.role == 4 && student.is4person == true) ||
                    (student.role == 3 && student.is4person == false)) {
                  student.acgame4.tasktext = AppTranslations.of(
                          student.navigatorKeygame.currentState.context)
                      .text("instruction_nextturn_t");
                }

                student.dbSessionRef.collection("turnFinished").add({
                  "d_group": student.groupname,
                  "numAc": 3,
                  'numTurn': student.groupCurrentTurn,
                  'rolevalue': 6,
                });
              }
            }
          }
        }
        // student.acgame4.spacemanVisible = (event.docChanges.first.doc.get('value'));
        //print(student.acgame4.spacemanVisible);
        student.acgame4.notifyListeners();
      }
    }
    if (student.currentActivity == 'Ac3') {
      if (student.acgame3.startgame == true) {
        for (int i = 0; i < 6; i++) {
          student.acgame3.spacemanVisible[i] =
              (event.docChanges.first.doc.get('value')[i]);
          if ((event.docChanges.first.doc.get('value')[i]) == 0 && i != 0) {
            if (student.acgame3.spacemanVisible[i - 1] == 1) {
              playHandler('images/smb_vine.mp3');
              if (student.groupCurrentTurn == 1) {
                var reward = 0;
                //print(student.acgame4.spacemanVisible);
                for (int i = 0;
                    i < student.acgame3.spacemanVisible.length;
                    i++) {
                  if (student.acgame3.spacemanVisible[i] == 1)
                    reward = reward + 1;
                }
                student.gscore[2] = reward;
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 2) {
                var reward = 0;
                //print(student.acgame4.spacemanVisible);
                for (int i = 0;
                    i < student.acgame3.spacemanVisible.length;
                    i++) {
                  if (student.acgame3.spacemanVisible[i] == 1)
                    reward = reward + 1;
                }
                student.gscore[2] = reward + student.acgame3.saved[0];
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              if (student.groupCurrentTurn == 3) {
                var reward = 0;
                //print(student.acgame4.spacemanVisible);
                for (int i = 0;
                    i < student.acgame3.spacemanVisible.length;
                    i++) {
                  if (student.acgame3.spacemanVisible[i] == 1)
                    reward = reward + 1;
                }
                student.gscore[2] = reward +
                    student.acgame3.saved[0] +
                    student.acgame3.saved[1];
                student.dbSessionRef
                    .collection("scores")
                    .doc(student.groupname)
                    .update({
                  'score': student.gscore,
                });
              }
              {
                student.acgame3.tasktext = AppTranslations.of(
                        student.navigatorKeygame.currentState.context)
                    .text("instruction_savespaceman");

                if (i == 5) {
                  var numsavedast = 0;
                  for (int numi = 0; numi < 5; numi++) {
                    if (student.acgame3.spacemanVisible[numi] == 1)
                      numsavedast =
                          numsavedast + student.acgame3.spacemanVisible[numi];
                  }
                  student.acgame3.showinstructionT = true;
                  print('Ac3game');
                  if (student.groupCurrentTurn == 1)
                    student.acgame3.saved[0] = numsavedast;
                  if (student.groupCurrentTurn == 2)
                    student.acgame3.saved[1] = numsavedast;
                  student.acgame3.instructionText = AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("victoryEnd4") +
                      numsavedast.toString() +
                      AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("victoryEnd4continue");
                  student.acgame3.notifyListeners();
                  /*
                  student.acgame3.tasktext = student.curLang == 'fa'
                      ? AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitfor") +
                          AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitnextturn")
                      : AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitfor") +
                          capitanm() +
                          AppTranslations.of(
                                  student.navigatorKeygame.currentState.context)
                              .text("waitnextturn");
*/
                  student.dbSessionRef.collection("turnFinished").add({
                    "d_group": student.groupname,
                    "numAc": 2,
                    'numTurn': student.groupCurrentTurn,
                    'rolevalue': 6,
                  });
                }

                student.acgame3.chnagecolor();
                student.acgame3.valuelifespaceman[i] = 1.0;
                // student.acgame3.animationlifespaceman.cancel();
                /*
                student.acgame3.animationlifespaceman =
                    new Timer.periodic(new Duration(seconds: 1), (time) {
                  if (!student.showpause) {
                    student.acgame3.valuelifespaceman[i] =
                        student.acgame3.valuelifespaceman[i] -
                            1 / student.acgame3.timealive;

                    if (student.acgame3.valuelifespaceman[i] <
                        2 / student.acgame3.timealive) {
                      student.acgame3.valuelifespaceman[i] = 0;
                      // print('canceled1');
                      student.acgame3.animationlifespaceman.cancel();
                    }
                  } else {
                    student.acgame3.animationlifespaceman.cancel();

                    Future(() {
                      if (!student.showpause) return true;
                    }).then((value) {
                      print('The value is $value.');
                    });
                  }
                });
                */
                /*
            runAnimation(
                'We saved a spacemen at coordinate position (' +
                    student
                        .acgame4
                        .spacemantruex[
                            (student.groupCurrentTurn - 1) * 5 + i - 1]
                        .toString() +
                    ',' +
                    student
                        .acgame4
                        .spacemantruey[
                            (student.groupCurrentTurn - 1) * 5 + i - 1]
                        .toString() +
                    '). Where is the next one?',
                false,
                '');
          */
              }
            }

            if (student.acgame3.spacemanVisible[i - 1] == -1) {
              playHandler('images/smb_mariodie.mp3');
              student.acgame3.valuelifespaceman[i] = 1.0;
              //  student.acgame3.animationlifespaceman.cancel();
              /*
              student.acgame3.animationlifespaceman =
                  new Timer.periodic(new Duration(seconds: 1), (time) {
                if (!student.showpause) {
                  student.acgame3.valuelifespaceman[i] =
                      student.acgame3.valuelifespaceman[i] -
                          1 / student.acgame3.timealive;
                  //   print(valuelifespaceman);
                  if (student.acgame3.valuelifespaceman[i] <
                      2 / student.acgame3.timealive) {
                    student.acgame3.valuelifespaceman[i] = 0;
                    // print('canceled2');
                    student.acgame3.animationlifespaceman.cancel();
                  }
                } else {
                  student.acgame3.animationlifespaceman.cancel();

                  Future(() {
                    if (!student.showpause) return true;
                  }).then((value) {
                    print('The value is $value.');
                  });
                }
              });
*/

              student.acgame3.tasktext = AppTranslations.of(
                      student.navigatorKeygame.currentState.context)
                  .text("instruction_lostspaceman");
              student.acgame3.chnagecolor();

              if (i == 5) {
                student.acgame3.showinstructionT = true;
                student.acgame3.showinstruction = true;
                print('Ac3game');
                print(student.acgame3.spacemanVisible);
                var numsavedast = 0;
                for (int numi = 0; numi < 5; numi++) {
                  if (student.acgame3.spacemanVisible[numi] == 1)
                    numsavedast =
                        numsavedast + student.acgame3.spacemanVisible[numi];
                  print(numsavedast);
                }
                student.acgame3.showinstructionT = true;
                print('Ac4game');
                if (student.groupCurrentTurn == 1)
                  student.acgame3.saved[0] = numsavedast;
                if (student.groupCurrentTurn == 2)
                  student.acgame3.saved[1] = numsavedast;
                student.acgame3.instructionText = AppTranslations.of(
                            student.navigatorKeygame.currentState.context)
                        .text("victoryEnd4") +
                    numsavedast.toString() +
                    AppTranslations.of(
                            student.navigatorKeygame.currentState.context)
                        .text("victoryEnd4continue");

                student.dbSessionRef.collection("turnFinished").add({
                  "d_group": student.groupname,
                  "numAc": 2,
                  'numTurn': student.groupCurrentTurn,
                  'rolevalue': 6,
                });
              }
            }
          }
        }
        // student.acgame4.spacemanVisible = (event.docChanges.first.doc.get('value'));
        //print(student.acgame4.spacemanVisible);
        student.acgame3.notifyListeners();
      }
    }
  }

  onstartgameadded(QuerySnapshot event) {
    if ((event.docChanges.first.doc.get('start')) == true) {
      student.acgame4.startgame = true;
      student.permisMoveV = true;
      student.acgame4.timerset();

      student.acgame4.instructionText = '';
      student.acgame4.showinstruction = true;
      student.acgame4.showinstructionT = false;
      student.acgame4.notifyListeners();
      // notifyListeners();
      if ((student.role != 3 && student.is4person == true) ||
          (student.is4person == false)) {
        student.acgame4.tasktext =
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("instruction_40seconds");
      }
    }
  }

  oncellulowtargetadded(QuerySnapshot event) {
    acgame4.targetSet((event.docChanges.first.doc.get('x')),
        (event.docChanges.first.doc.get('y')));

    // notifyListeners();
  }

  onrewardadded(QuerySnapshot event) {
    if (student.currentActivity == 'Ac4') {
      student.acgame4.reward = ((event.docChanges.first.doc.get('value')));
      student.acgame4.notifyListeners();
    }
    if (student.currentActivity == 'Ac3') {
      student.acgame3.reward = ((event.docChanges.first.doc.get('value')));
      student.acgame3.notifyListeners();
    }
  }

  onmessagexadded(QuerySnapshot event) {
    student.acgame4.messagesx.add(ChatMessage(
        messageContent: ((event.docChanges.first.doc.get('message'))),
        messageType: "receiver"));
    if ((student.groupPolicy2[student.role - 1][student.groupCurrentTurn - 1] ==
        'R')) {
      student.acgame4.chnagecolor2();
    }
    student.acgame4.notifyListeners();
  }

  onmessageyadded(QuerySnapshot event) {
    student.acgame4.messagesy.add(ChatMessage(
        messageContent: ((event.docChanges.first.doc.get('message'))),
        messageType: "receiver"));
    if ((student.groupPolicy2[student.role - 1][student.groupCurrentTurn - 1] ==
        'B')) {
      student.acgame4.chnagecolor2();
    }
    student.acgame4.notifyListeners();
  }

  oncurrentturnchanged(DocumentSnapshot event) {
    var updatedActivity = ((event.get('currentActivity')));
    if (updatedActivity != student.currentActivity) {
      if (student.acgame4.timerlifespaceman != null)
        student.acgame4.timerlifespaceman.cancel();
      if (student.acgame4.animationlifespaceman != null)
        student.acgame4.animationlifespaceman.cancel();
      if (student.acgame3.timerlifespaceman != null)
        student.acgame3.timerlifespaceman.cancel();
      if (student.acgame3.animationlifespaceman != null)
        student.acgame3.animationlifespaceman.cancel();

      if (updatedActivity == 'Ac1' ||
          updatedActivity == 'Ac2' ||
          updatedActivity == 'Ac3' ||
          updatedActivity == 'Ac4' ||
          updatedActivity == 'Ac5' ||
          updatedActivity == 'Ac6' ||
          updatedActivity == 'Ac7' ||
          updatedActivity == 'Ac8' ||
          updatedActivity == 'Ac9' ||
          updatedActivity == 'Ac10') {
        student.currentActivity = updatedActivity;
        student.showinstruction = true;
        print('acchnaged');

        student.dbGroupRef.collection("gamevents").add({
          "event": 'activitychanged',
          'activityto': student.currentActivity,
          'timepassed': student.elapseTimer.elapsedMilliseconds,
        });

        print('student.activityTime');

        print(student.activityTime);

        student.switchactivity();

        // student.turnchnaged = true;

      }
      if ((updatedActivity == 'Ac0')) {
        student.currentActivity = updatedActivity;
        student.switchactivity();
      }
      if ((updatedActivity == 'Acf')) {
        student.activityTime[3] =
            ((student.elapseTimer.elapsedMilliseconds - student.starttimer[3]) /
                    1000)
                .round();
        student.dbSessionRef
            .collection("scores")
            .doc(student.groupname)
            .update({
          'time': student.activityTime,
        });
        print('student.activityTime');

        print(student.activityTime);
        student.currentActivity = updatedActivity;
        student.switchactivity();
      }
    }
    if (event.get('CurrentTurn') != student.groupCurrentTurn) {
      if (student.currentActivity == 'Ac1' ||
          student.currentActivity == 'Ac2' ||
          student.currentActivity == 'Ac3' ||
          student.currentActivity == 'Ac4' ||
          student.currentActivity == 'Ac5' ||
          student.currentActivity == 'Ac6' ||
          student.currentActivity == 'Ac7' ||
          student.currentActivity == 'Ac8' ||
          student.currentActivity == 'Ac9') {
        student.groupCurrentTurn = event.get('CurrentTurn');

        student.dbGroupRef.collection("gamevents").add({
          "event": 'turnchanged',
          'activity': student.currentActivity,
          'turnto': student.groupCurrentTurn,
          'timepassed': student.elapseTimer.elapsedMilliseconds,
        });

        if (event.get('CurrentTurn') - 1 > 0)
          student.dbSessionRef.collection("turnTransition").add({
            "d_group": student.groupname,
            "numAc": student.acList.indexOf(student.currentActivity),
            "numTurn": event.get('CurrentTurn') - 1,
            'rolevalue': 6,
          });
        student.startGameX = false;
        if (student.currentActivity == 'Ac1') {
          student.acgame1.begingame();
        }

        if (student.currentActivity == 'Ac2') {
          student.acgame2.begingame();
        }
        if (student.currentActivity == 'Ac3') {
          student.acgame3.begingame();
        }
        if (student.currentActivity == 'Ac4') {
          if (student.acgame4.timerlifespaceman != null)
            student.acgame4.timerlifespaceman.cancel();
          student.acgame4.begingame();
        }
        if (student.currentActivity == 'Ac5') {
          //if (student.acgame4.timerlifespaceman != null)
          //  student.acgame4.timerlifespaceman.cancel();
          student.acgame5.begingame();
        }
        if (student.currentActivity == 'Ac6') {
          //if (student.acgame4.timerlifespaceman != null)
          //  student.acgame4.timerlifespaceman.cancel();
          student.acgame6.begingame();
        }

        if (student.currentActivity == 'Ac7') {
          //if (student.acgame4.timerlifespaceman != null)
          //  student.acgame4.timerlifespaceman.cancel();
          student.acgame7.begingame();
        }

        if (student.currentActivity == 'Ac9') {
          //if (student.acgame4.timerlifespaceman != null)
          //  student.acgame4.timerlifespaceman.cancel();
          student.acgame9.begingame();
        }

        student.turnchnaged = true;
        student.startGame = true;
        student.reachendX = false;
        student.reachendY = false;
        student.reachendV = false;
        student.showinstruction = true;
      }
    }

    notifyListeners();
  }

  void listen() {
    notifyListeners();
  }

  onBluecelluloPositionAdded(QuerySnapshot event) {
    if ((student.currentActivity == 'Ac1') ||
        (student.currentActivity == 'Ac3')) {
      if ((student.groupPolicy[student.role - 1]
              [student.groupCurrentTurn - 1] !=
          'B')) {
        student.celluloy.x = (event.docChanges.first.doc.get('x'));
        student.celluloy.y = (event.docChanges.first.doc.get('y'));
      }
    }

    if ((student.currentActivity == 'Ac2') ||
        (student.currentActivity == 'Ac4')) {
      if ((student.groupPolicy2[student.role - 1]
              [student.groupCurrentTurn - 1] !=
          'B')) {
        student.celluloy.x = (event.docChanges.first.doc.get('x'));
        student.celluloy.y = (event.docChanges.first.doc.get('y'));
      }
    }

    notifyListeners();
  }

  onRedcelluloPositionAdded(QuerySnapshot event) {
    if ((student.currentActivity == 'Ac1') ||
        (student.currentActivity == 'Ac3')) {
      if ((student.groupPolicy[student.role - 1]
              [student.groupCurrentTurn - 1] !=
          'R')) {
        student.cellulox.x = (event.docChanges.first.doc.get('x'));
        student.cellulox.y = (event.docChanges.first.doc.get('y'));
      }
    }
    if ((student.currentActivity == 'Ac2') ||
        (student.currentActivity == 'Ac4')) {
      if ((student.groupPolicy2[student.role - 1]
              [student.groupCurrentTurn - 1] !=
          'R')) {
        student.cellulox.x = (event.docChanges.first.doc.get('x'));
        student.cellulox.y = (event.docChanges.first.doc.get('y'));
      }
    }

    notifyListeners();
  }
}
