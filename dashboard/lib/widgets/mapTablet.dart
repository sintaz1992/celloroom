import 'package:dashboard/model/Class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:student/gameDynamic/Ac4.dart';
import 'package:dashboard/model/student.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math' as math;
//import 'package:student/widgets/arrow.dart';
import 'package:dashboard/widgets/guidegrid.dart';
//import 'package:student/widgets/guideTarget.dart';

class Map extends StatefulWidget {
  final int curTurn;
  Map({Key key, this.curTurn}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> with TickerProviderStateMixin {
  Timer timerCelluloPosition;
  List<int> ages = [1, 2, 4];
  AnimationController _controller;
  Animation<double> _animation;
  final double mapSizeWidth = 860;
  final double mapSizeHeight = 860;
  final double screenWidth = 500;
  final double screenHeight = 500;

  double celluloxleft = 0.0;
  double celluloxtop = 0.0;
  double celluloyleft = 0.0;
  double celluloytop = 0.0;
  double prevCelluloxx = 0.0;
  double prevCelluloxy = 0.0;
  double prevCelluloyx = 0.0;
  double prevCelluloyy = 0.0;
  final String mapPath = 'assets/images/Grid_Ac5_Screen.png';
  final List<String> radObstaclePath = [
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island6.png',
    'assets/images/island7.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island6.png',
    'assets/images/island7.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];
  final List<String> recObstaclePath = [
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];
  final List<String> polObstaclePath = [
    'assets/images/island5.png',
    'assets/images/island4.png',
    'assets/images/island3.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island5.png',
    'assets/images/island4.png',
    'assets/images/island3.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];

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

  final List<String> polspacemanPath = [
    'assets/images/spacer3.png',
    'assets/images/spacer2.png',
    'assets/images/spacer1.png',
    'assets/images/spacer1.png',
    'assets/images/spacer3.png',
    'assets/images/spacer2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island5.png',
    'assets/images/island4.png',
    'assets/images/island3.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island2.png',
    'assets/images/island3.png',
    'assets/images/island7.png',
    'assets/images/island4.png',
    'assets/images/island5.png',
    'assets/images/island1.png',
    'assets/images/island6.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png',
    'assets/images/island1.png'
  ];

  Offset origin = new Offset(106, 572.0); // should be calibrated for a new map
  var step = 75.0;

  double posecirclex(int i) {
    List<Offset> starposelist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['originCircles'];
    Offset starpose = starposelist[i];
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['radiuosCircles'];
    return starpose.dx * student.playgroundheight / mapSizeWidth -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  Offset endpoint() {
    return student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['endCenter'];
  }

  double posecircley(int i) {
    List<Offset> starposelist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['originCircles'];
    Offset starpose = starposelist[i];
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['radiuosCircles'];
    return starpose.dy * student.playgroundheight / mapSizeHeight -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radcircle(int i) {
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['radiuosCircles'];

    return 2 * radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radpol(int i) {
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['radiusPolygon'];

    return 2 * radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radrecw(int i) {
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['widthRectangles'];

    return radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double radrech(int i) {
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['heightRectangles'];

    return radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double poserecx(int i) {
    List<Offset> starposelist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['originRectangles'];
    Offset starpose = starposelist[i];
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['widthRectangles'];
    return starpose.dx * student.playgroundheight / mapSizeWidth -
        radlist[i] / 2 * student.playgroundheight / mapSizeWidth;
  }

  double poserecy(int i) {
    List<Offset> starposelist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['originRectangles'];
    Offset starpose = starposelist[i];
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['heightRectangles'];

    return starpose.dy * student.playgroundheight / mapSizeHeight -
        radlist[i] / 2 * student.playgroundheight / mapSizeWidth;
  }

  double posepolx(int i) {
    List<Offset> starposelist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['centerPolygon'];
    Offset starpose = starposelist[i];
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['radiusPolygon'];
    return starpose.dx * student.playgroundheight / mapSizeWidth -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  double posepoly(int i) {
    List<Offset> starposelist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['centerPolygon'];
    Offset starpose = starposelist[i];
    List<double> radlist = student.mapShape[
            student.acList.indexOf(student.currentActivity[widget.curTurn])]
        [student.groupCurrentTurn[widget.curTurn] - 1]['radiusPolygon'];
    return starpose.dy * student.playgroundheight / mapSizeHeight -
        radlist[i] * student.playgroundheight / mapSizeWidth;
  }

  @override
  void initState() {
    super.initState();

    // dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    //dbRef.child('students').child(student.id).child('currentActivity').set("Ac1");
    // elapseTimer.start();

    timerCelluloPosition =
        new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      thisClass.dbSessionRef
          .collection('groups')
          .doc((widget.curTurn + 1).toString())
          .collection('celluloPosition')
          .doc('celluloRed')
          .get()
          .then((value) => {
                print(value.get('x')),
                student.cellulox.x[widget.curTurn] = value.get('x'),
                student.cellulox.y[widget.curTurn] = value.get('y'),
              });

      thisClass.dbSessionRef
          .collection('groups')
          .doc((widget.curTurn + 1).toString())
          .collection('celluloPosition')
          .doc('celluloBlue')
          .get()
          .then((value) => {
                print(value.get('x')),
                student.celluloy.x[widget.curTurn] = value.get('x'),
                student.celluloy.y[widget.curTurn] = value.get('y'),
              });
      print(widget.curTurn);
    });

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  void dispose() {
    timerCelluloPosition.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: student.playgroundheight,
      height: student.playgroundheight,
      child: Stack(children: <Widget>[
        Container(
            width: student.playgroundheight,
            height: student.playgroundheight,
            child: Stack(
              children: <Widget>[
                (student.currentActivity[widget.curTurn] == 'Ac3' ||
                        student.currentActivity[widget.curTurn] == 'Ac2' ||
                        student.currentActivity[widget.curTurn] == 'Ac1' ||
                        student.currentActivity[widget.curTurn] == 'Ac4')
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: Image.asset('assets/images/sea.png',
                            height: student.playgroundheight,
                            width: student.playgroundheight))
                    : Text(''),
                (student.currentActivity[widget.curTurn] == 'Ac3' ||
                        student.currentActivity[widget.curTurn] == 'Ac4')
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: 10.0 / 500 * student.playgroundheight),
                        child: Image.asset('assets/images/Grid_Ac3_Screen.png',
                            height: student.playgroundheight,
                            width: student.playgroundheight))
                    : Text(''),
                (student.currentActivity[widget.curTurn] == 'Ac2')
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: 10.0 / 500 * student.playgroundheight),
                        child: Image.asset('assets/images/Grid_Ac2_Screen.png',
                            height: student.playgroundheight,
                            width: student.playgroundheight))
                    : Text(''),
                /*
                          (student.currentActivity == 'Ac4')
                              ? Positioned(
                                  left: startPoint.dx *
                                          screenWidth /
                                          mapSizeWidth -
                                      student.cellulosize / 2 / 500,
                                  top: startPoint.dy *
                                          screenHeight /
                                          mapSizeHeight -
                                      student.cellulosize / 2 / 500,
                                  child: Image.asset("assets/images/start.png",
                                      height: 80, width: 80),
                                )
                              : Text(''),
                              */
                (student.currentActivity[widget.curTurn] == 'Ac1' ||
                        student.currentActivity[widget.curTurn] == 'Ac2' ||
                        student.currentActivity[widget.curTurn] == 'Ac3')
                    ? Positioned(
                        left: endpoint().dx *
                                student.playgroundheight /
                                mapSizeWidth -
                            student.radfinish *
                                student.playgroundheight /
                                mapSizeHeight,
                        top: endpoint().dy *
                                student.playgroundheight /
                                mapSizeHeight -
                            student.radfinish *
                                student.playgroundheight /
                                mapSizeHeight,
                        child: Image.asset("assets/images/finish.png",
                            height: 80 / 500 * student.playgroundheight,
                            width: 80 / 500 * student.playgroundheight),
                      )
                    : Text(''),

                /*
                          (student.currentActivity == 'Ac4' ||
                                  student.currentActivity == 'Ac5')
                              ? CustomPaint(
                                  //size: Size(200, 200),
                                  painter: BezierCurvePainter(
                                      student.mapShape[2]
                                              [student.groupCurrentTurn - 1]
                                          ['startCenter'],
                                      student.mapShape[2]
                                              [student.groupCurrentTurn - 1]
                                          ['endCenter'],
                                      screenWidth / mapSizeWidth,
                                      screenHeight / mapSizeHeight,
                                      student.groupCurrentTurn,
                                      15)
                                  //LinePainter2(celluloxPositiontopaint, celluloyPositiontopaint),

                                  )
                              : Text(''),
                              */
              
                (student.currentActivity[widget.curTurn] == 'Ac1')
                    ? Positioned(
                        left: student.cellulox.x[widget.curTurn] *
                            student.playgroundheight,
                        top: student.cellulox.y[widget.curTurn] *
                            student.playgroundheight,
                        child: Image.asset("assets/images/celluloRed.png",
                            height: student.cellulosize,
                            width: student.cellulosize),
                      )
                    : Text(''),
                (student.currentActivity[widget.curTurn] == 'Ac2' ||
                        student.currentActivity[widget.curTurn] == 'Ac3' ||
                        student.currentActivity[widget.curTurn] == 'Ac4')
                    ? Positioned(
                        left: student.cellulox.x[widget.curTurn] *
                            student.playgroundheight,
                        top: student.playgroundheight -
                            student.cellulosize -
                            5 / 500 * student.playgroundheight,
                        child: Image.asset(
                            student.is4person
                                ? ((student.acList.indexOf(student.currentActivity[widget.curTurn]) *
                                                student.numberTurns +
                                            (student.groupCurrentTurn[widget.curTurn] - 1) %
                                                4 ==
                                        1)
                                    ? ("assets/images/manR.png")
                                    : ((student.acList.indexOf(student.currentActivity[widget.curTurn]) *
                                                    student.numberTurns +
                                                (student.groupCurrentTurn[widget.curTurn] -
                                                        1) %
                                                    4 ==
                                            2)
                                        ? ("assets/images/manB.png")
                                        : ((student.acList.indexOf(student.currentActivity[widget.curTurn]) * student.numberTurns + (student.groupCurrentTurn[widget.curTurn] - 1) % 4 == 3)
                                            ? ("assets/images/manM.png")
                                            : ("assets/images/manC.png"))))
                                : (student.groupCurrentTurn[widget.curTurn] == 1
                                    ? ("assets/images/manR.png")
                                    : (student.groupCurrentTurn[widget.curTurn] == 2
                                        ? ("assets/images/manB.png")
                                        : ("assets/images/manM.png"))),
                            height: student.cellulosize * 0.75,
                            width: student.cellulosize * 0.75),
                      )
                    : Text(''),
                (student.currentActivity[widget.curTurn] == 'Ac1')
                    ? Positioned(
                        left: student.celluloy.x[widget.curTurn] *
                            student.playgroundheight,
                        top: student.celluloy.y[widget.curTurn] *
                            student.playgroundheight,
                        child: Image.asset("assets/images/celluloBlue.png",
                            height: student.cellulosize,
                            width: student.cellulosize),
                      )
                    : Text(''),
                (student.currentActivity[widget.curTurn] == 'Ac2' ||
                        student.currentActivity[widget.curTurn] == 'Ac3' ||
                        student.currentActivity[widget.curTurn] == 'Ac4')
                    ? Positioned(
                        left: 5 / 500 * student.playgroundheight,
                        top: student.celluloy.y[widget.curTurn] *
                            student.playgroundheight,
                        child: Image.asset(
                            student.is4person
                                ? ((student.acList.indexOf(student.currentActivity[widget.curTurn]) *
                                                student.numberTurns +
                                            (student.groupCurrentTurn[widget.curTurn] - 1) %
                                                4 ==
                                        1)
                                    ? ("assets/images/manB.png")
                                    : ((student.acList.indexOf(student.currentActivity[widget.curTurn]) *
                                                    student.numberTurns +
                                                (student.groupCurrentTurn[widget.curTurn] -
                                                        1) %
                                                    4 ==
                                            2)
                                        ? ("assets/images/manM.png")
                                        : ((student.acList.indexOf(student.currentActivity[widget.curTurn]) * student.numberTurns + (student.groupCurrentTurn[widget.curTurn] - 1) % 4 == 3)
                                            ? ("assets/images/manC.png")
                                            : ("assets/images/manR.png"))))
                                : (student.groupCurrentTurn[widget.curTurn] == 1
                                    ? ("assets/images/manB.png")
                                    : (student.groupCurrentTurn[widget.curTurn] == 2
                                        ? ("assets/images/manM.png")
                                        : ("assets/images/manM.png"))),
                            height: student.cellulosize * 0.75,
                            width: student.cellulosize * 0.75),
                      )
                    : Text(''),
                (student.currentActivity[widget.curTurn] == 'Ac2' ||
                        student.currentActivity[widget.curTurn] == 'Ac3' ||
                        student.currentActivity[widget.curTurn] == 'Ac4')
                    ? Positioned(
                        left: student.cellulox.x[widget.curTurn] *
                            student.playgroundheight,
                        top: (student.celluloy.y[widget.curTurn]) *
                            student.playgroundheight,
                        child: Image.asset("assets/images/celluloPurple.png",
                            height: student.cellulosize,
                            width: student.cellulosize),
                      )
                    : Text(''),
              ],
            )),
        for (int i = 0;
            i <
                student.mapShape[student.acList
                            .indexOf(student.currentActivity[widget.curTurn])]
                        [student.groupCurrentTurn[widget.curTurn] - 1]
                    ['numCircles'];
            i++)
          (student.currentActivity[widget.curTurn] == 'Ac4' ||
                  student.currentActivity[widget.curTurn] == 'Ac2' ||
                  student.currentActivity[widget.curTurn] == 'Ac3' ||
                  student.currentActivity[widget.curTurn] == 'Ac1')
              ? Positioned(
                  left: posecirclex(i),
                  top: posecircley(i),
                  child: FittedBox(
                    child: Image.asset(radObstaclePath[i],
                        height: radcircle(i), width: radcircle(i)),
                    fit: BoxFit.fill,
                  ),
                )
              : Text(''),
        for (int i = 0;
            i <
                student.mapShape[student.acList
                            .indexOf(student.currentActivity[widget.curTurn])]
                        [student.groupCurrentTurn[widget.curTurn] - 1]
                    ['numRectangles'];
            i++)
          (student.currentActivity[widget.curTurn] == 'Ac2' ||
                  student.currentActivity[widget.curTurn] == 'Ac3' ||
                  student.currentActivity[widget.curTurn] == 'Ac1')
              ? Positioned(
                  left: poserecx(i),
                  top: poserecy(i),
                  child: FittedBox(
                    child: Image.asset(recObstaclePath[i],
                        height: radrech(i), width: radrecw(i)),
                    fit: BoxFit.fill,
                  ),
                )
              : Text(''),
        for (int i = 0;
            i <
                student.mapShape[student.acList
                            .indexOf(student.currentActivity[widget.curTurn])]
                        [student.groupCurrentTurn[widget.curTurn] - 1]
                    ['numPolygons'];
            i++)
          (student.currentActivity[widget.curTurn] == 'Ac2' ||
                  student.currentActivity[widget.curTurn] == 'Ac3' ||
                  student.currentActivity[widget.curTurn] == 'Ac1')
              ? Positioned(
                  left: posepolx(i),
                  top: posepoly(i),
                  child: Image.asset(polObstaclePath[i],
                      height: radpol(i), width: radpol(i)),
                )
              : Text(''),
      ]),
    );
  }
}
