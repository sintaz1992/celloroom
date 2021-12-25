//import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dashboard/model/Cellulo.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
//import 'package:student/screens/loginpage_character.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:student/widgets/showAlertDialog.Dart';
//import 'package:student/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

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
    'Ac8'
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
//  String _title;
  // String _description;
  int inactivity = 0;
  String name;
  DocumentReference dbRef;
  DocumentReference dbGroupRef;
  DocumentReference dbSessionRef;
  bool permisMoveX = true;
  bool permisMoveY = true;
  bool permisMoveV = true;
  int scoreX = 3;
  int scoreY = 3;
  int scoreV = 3;
  bool report = true;
  String groupmember1name = '';
  String groupmember2name = '';
  String groupmember3name = '';
  String groupmember4name = '';
  int numStudents = 3;
  bool clickR = true;
  bool clickB = true;
  bool clickM = true;
  bool clickN = true;
  bool reachendX = false;
  bool reachendY = false;
  bool reachendV = false;
  List<int> groupCurrentTurn = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  int role = 1;
  bool ispaused = false;
  bool showinstruction = true;
  bool showfinish = false;
  bool textrepeat = false;
  String rolemanM = '';
  String rolemanB = '';
  String rolemanR = '';
  Cellulo cellulox = new Cellulo(0);
  Cellulo celluloy = new Cellulo(1);
  Cellulo cellulov = new Cellulo(2);
  Cellulo cellulow = new Cellulo(3);

  bool isAlertShown = true;
  bool startGame = false;
  int countTimerEngagement = 0;
  static int simulationSpeed = 500;
  static int serverSpeed = 1000;
  bool isTablet = true;
  double initialcellulosize = 70;
  static double mapSizeWidth = 760;
  static double mapSizeHeight = 760;
  int numTurn = 3;
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
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 18);
  TextStyle hinttext2 = GoogleFonts.lato(
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w600));
  bool startGameX = false;
  int scoreMax = 3;
  bool turnchnaged = false;
  bool showpause = false;
  var groupPolicy = [
    ['R', 'R', 'T'],
    ['B', 'T', 'B'],
    ['T', 'B', 'R'],
    ['T', 'T', 'T'],
  ];
  var groupPolicy2 = [
    ['R', 'R', 'T'],
    ['B', 'T', 'B'],
    ['T', 'B', 'R'],
    ['T', 'T', 'T'],
  ];
  bool joinSession = false;
  bool iamready = false;
  String curLang = 'en';
  bool is4person = false;

  static List<Offset> pointPosition = [
    Offset(180, 100),
    Offset(760, 60),
    Offset(100, 746),
    Offset(760, 760)
  ];
  List<Offset> pointhitX = [Offset(0.0, 0.0)];
  List<Offset> pointhitY = [Offset(0.0, 0.0)];
  List<Offset> pointhitV = [Offset(0.0, 0.0)];
  var mapShape = [
    [
      {
        'numCircles': 11,
        'originCircles': [
          Offset(300, 746),
          Offset(400, 646),
          Offset(400, 546),
          Offset(400, 446),
          Offset(500, 446),
          Offset(600, 446),
          Offset(700, 346),
          Offset(100, 346),
          Offset(200, 246),
          Offset(100, 446),
          Offset(500, 246),
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
        'numCircles': 9,
        'originCircles': [
          Offset(500, 746),
          Offset(200, 446),
          Offset(300, 546),
          Offset(400, 546),
          Offset(500, 446),
          Offset(500, 346),
          Offset(500, 246),
          Offset(500, 146),
          Offset(740, 646),
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
        'numCircles': 8,
        'originCircles': [
          Offset(300, 746),
          Offset(300, 646),
          Offset(400, 546),
          Offset(400, 446),
          Offset(500, 346),
          Offset(600, 246),
          Offset(100, 146),
          Offset(100, 446),
          Offset(300, 746),
          Offset(300, 746),
          Offset(300, 746),
          Offset(300, 746),
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
        'numPolygons': 11,
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
          Offset(700, 546),
          Offset(700, 446),
          Offset(700, 346),
          Offset(100, 446),
          Offset(200, 446),
          Offset(300, 446),
          Offset(400, 346),
          Offset(400, 246),
          Offset(400, 146),
        ],
        'startCenter': Offset(200, 646),
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
        'numPolygons': 10,
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
          Offset(200, 446),
          Offset(300, 446),
          Offset(400, 246),
          Offset(500, 446),
          Offset(500, 586),
          Offset(640, 346),
          Offset(500, 346),
          Offset(500, 246),
          Offset(750, 706),
        ],
        'startCenter': Offset(200, 646),
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
        'numPolygons': 10,
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
          Offset(400, 346),
          Offset(500, 346),
          Offset(600, 346),
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
        'startCenter': Offset(200, 646),
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
        'numPolygons': 6,
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
          Offset(440, 210),
          Offset(440, 80),
          Offset(530, 326),
          Offset(530, 426),
          Offset(430, 426),
          Offset(660, 310),
        ],
        'startCenter': Offset(200, 246),
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
        'numPolygons': 8,
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
          Offset(640, 640),
          Offset(760, 530),
          Offset(760, 420),
          Offset(640, 340),
          Offset(440, 60),
          Offset(170, 310),
          Offset(270, 310),
          Offset(220, 66),
        ],
        'startCenter': Offset(200, 646),
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
        'numPolygons': 8,
        'sidesofPolygon': [4, 4, 4, 4, 4, 4, 4, 4],
        'radiusPolygon': [45.0, 45.0, 45.0, 45.0, 45.0, 45.0, 45.0, 45.0, 45.0],
        'centerPolygon': [
          Offset(640, 440),
          Offset(540, 550),
          Offset(760, 320),
          Offset(110, 326),
          Offset(440, 66),
          Offset(110, 646),
          Offset(650, 216),
          Offset(210, 66),
        ],
        'startCenter': Offset(600, 646),
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
          Offset(440, 210),
          Offset(230, 550),
          Offset(230, 116),
          Offset(740, 432),
          Offset(430, 126),
          Offset(260, 116),
        ],
        'startCenter': Offset(200, 646),
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
          Offset(340, 310),
          Offset(540, 650),
          Offset(750, 226),
          Offset(540, 112),
          Offset(230, 650),
          Offset(460, 410),
        ],
        'startCenter': Offset(200, 646),
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
          Offset(430, 550),
          Offset(440, 110),
          Offset(630, 326),
          Offset(220, 622),
          Offset(750, 226),
          Offset(270, 400),
        ],
        'startCenter': Offset(200, 646),
        'endCenter': Student.pointPosition[1]
      },
    ]
  ];
  int numberTurns = 3;
  List<String> currentActivity = [
    'Ac2',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1',
    'Ac1'
  ];
  String prevActivity = 'Ac0';
  String aclimit = 'Ac4t';
  var elapseTimer = new Stopwatch();
  final GlobalKey<NavigatorState> navigatorKeygame =
      new GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> keylogin = new GlobalKey<NavigatorState>();

// all streams and firestore-related

  final FirebaseFirestore _database = FirebaseFirestore.instance;
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

  void activityChanged() {
    student.pointhitV = [Offset(0.0, 0.0)];
    student.pointhitX = [Offset(0.0, 0.0)];
    student.pointhitY = [Offset(0.0, 0.0)];
    student.startGame = true;
    // student.startGameX = true;
    student.scoreX = student.scoreMax;
    student.scoreY = student.scoreMax;
    student.scoreV = student.scoreMax;
    student.dbGroupRef.update({
      'scoreV': student.scoreV,
    });
    student.dbGroupRef.update({
      'scoreX': student.scoreX,
    });
    student.dbGroupRef.update({
      'scoreY': student.scoreY,
    });

    student.reachendX = false;
    student.reachendY = false;
    student.reachendV = false;
    student.dbGroupRef.update({
      'reachendV': student.reachendV,
    });
    student.dbGroupRef.update({
      'reachendX': student.reachendX,
    });
    student.dbGroupRef.update({
      'reachendY': student.reachendY,
    });
  }

  void setupDatabse2() {
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
  }

  void listen() {
    notifyListeners();
  }

  onBluecelluloPositionAdded(QuerySnapshot event) {
    student.celluloy.x = (event.docChanges.first.doc.get('x'));
    student.celluloy.y = (event.docChanges.first.doc.get('y'));

    notifyListeners();
  }

  onRedcelluloPositionAdded(QuerySnapshot event) {
    student.cellulox.x = (event.docChanges.first.doc.get('x'));
    student.cellulox.y = (event.docChanges.first.doc.get('y'));

    notifyListeners();
  }
}
