import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:dashboard/config/palette.dart';
import 'package:dashboard/config/styles.dart';
import 'dart:async';
//import './screens.dart';
import 'package:dashboard/model/Class.dart';
import 'package:dashboard/model/Group.dart';
import 'package:dashboard/model/activities/activity.Dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:dashboard/widgets/hexagonPainter.Dart';
import 'package:dashboard/widgets/celluloMap.Dart';
import 'package:dashboard/widgets/mapShapeMaker.dart';

import 'package:provider/provider.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

Widget minituare(int position, int turn, bool mistakesSwitch,
    bool rankingSwitch, bool robotpatternSwitch) {
  var colors = [Colors.grey, Colors.red, Colors.blue, Colors.green];
  List<int> gColor;
  double screenSizeWidth = 90;
  double screenSizeHeight = 90;
  double mapSizeWidth = 860;
  double mapSizeHeight = 860;
  int activityID = acList.indexOf(thisClass.groups[position].currentActivity);
  int turnID = turn - 1;
  int groupID = position;
  List<String> gridAcsPath = [
    "assets/images/GridOnlyPositive.png",
    "assets/images/Grid.png",
    "assets/images/Grid_Ac5_Screen.png",
    "assets/images/Grid_Ac6_Screen.png",
    "assets/images/Grid_Ac5_Screen.png",
    "assets/images/Grid_Ac6_Screen.png",
    "assets/images/Grid_Ac7_Screen.png",
    "assets/images/Grid_Ac8_Screen.png",
  ];
  List<Offset> pointPosition = [
    Offset(80, 80),
    Offset(760, 80),
    Offset(80, 760),
    Offset(760, 760)
  ];
  var mapShape = [
    [
      {
        'numCircles': 4,
        'originCircles': [
          Offset(390, 300),
          Offset(190, 170),
          Offset(60, 360),
          Offset(560, 690)
        ],
        'radiuosCircles': [60.0, 70.0, 60.0, 60.0],
        'numRectangles': 2,
        'originRectangles': [Offset(300, 30), Offset(300, 560)],
        'widthRectangles': [150.0, 100.0],
        'heightRectangles': [50.0, 250.0],
        'numPolygons': 5,
        'sidesofPolygon': [3, 3, 5, 4, 4],
        'radiusPolygon': [60.0, 70.0, 70.0, 60.0, 80.0],
        'centerPolygon': [
          Offset(60, 230),
          Offset(600, 90),
          Offset(600, 250),
          Offset(600, 500),
          Offset(780, 400)
        ],
        'startCenter': pointPosition[2],
        'endCenter': pointPosition[1]
      },
      {
        'numCircles': 2,
        'originCircles': [
          Offset(380, 320),
          Offset(160, 290),
        ],
        'radiuosCircles': [60.0, 70.0],
        'numRectangles': 3,
        'originRectangles': [
          Offset(100, 500),
          Offset(700, 560),
          Offset(500, 360)
        ],
        'widthRectangles': [150.0, 100.0, 80.0],
        'heightRectangles': [50.0, 250.0, 230.0],
        'numPolygons': 4,
        'sidesofPolygon': [3, 5, 4, 4],
        'radiusPolygon': [70.0, 80.0, 70.0, 70.0],
        'centerPolygon': [
          Offset(300, 90),
          Offset(600, 60),
          Offset(500, 650),
          Offset(780, 300)
        ],
        'startCenter': pointPosition[0],
        'endCenter': pointPosition[3]
      },
      {
        'numCircles': 3,
        'originCircles': [
          Offset(260, 170),
          Offset(490, 560),
          Offset(690, 590),
        ],
        'radiuosCircles': [80.0, 70.0, 70.0],
        'numRectangles': 2,
        'originRectangles': [Offset(500, 30), Offset(350, 560)],
        'widthRectangles': [150.0, 100.0],
        'heightRectangles': [80.0, 300.0],
        'numPolygons': 3,
        'sidesofPolygon': [3, 4, 4],
        'radiusPolygon': [70.0, 90.0, 80.0],
        'centerPolygon': [
          Offset(40, 630),
          Offset(70, 390),
          Offset(620, 220),
        ],
        'startCenter': pointPosition[2],
        'endCenter': pointPosition[1]
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
        'numRectangles': 5,
        'originRectangles': [
          Offset(300, 30),
          Offset(200, 560),
          Offset(400, 760),
          Offset(780, 460),
          Offset(650, 500)
        ],
        'widthRectangles': [150.0, 100.0, 50.0, 100.0, 100.0],
        'heightRectangles': [50.0, 250.0, 300.0, 50.0, 100.0],
        'numPolygons': 4,
        'sidesofPolygon': [4, 4, 4, 4],
        'radiusPolygon': [70.0, 70.0, 50.0, 60.0, 50.0],
        'centerPolygon': [
          Offset(60, 280),
          Offset(500, 140),
          Offset(600, 200),
          Offset(500, 500),
          Offset(680, 400)
        ],
        'startCenter': pointPosition[2],
        'endCenter': pointPosition[1]
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
        'numRectangles': 4,
        'originRectangles': [
          Offset(300, 30),
          Offset(300, 560),
          Offset(500, 560),
          Offset(750, 360)
        ],
        'widthRectangles': [
          150.0,
          100.0,
          50.0,
          150.0,
        ],
        'heightRectangles': [50.0, 250.0, 250.0, 300.0],
        'numPolygons': 4,
        'sidesofPolygon': [4, 4, 4, 4],
        'radiusPolygon': [80.0, 60.0, 50.0, 60.0],
        'centerPolygon': [
          Offset(100, 330),
          Offset(600, 90),
          Offset(500, 200),
          Offset(400, 350),
        ],
        'startCenter': pointPosition[0],
        'endCenter': pointPosition[3]
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
        'numRectangles': 3,
        'originRectangles': [
          Offset(350, 70),
          Offset(300, 560),
          Offset(700, 520)
        ],
        'widthRectangles': [350.0, 300.0, 100.0],
        'heightRectangles': [50.0, 250.0, 100.0],
        'numPolygons': 3,
        'sidesofPolygon': [4, 4, 4],
        'radiusPolygon': [100.0, 60.0, 70.0],
        'centerPolygon': [
          Offset(80, 230),
          Offset(650, 190),
          Offset(400, 250),
        ],
        'startCenter': pointPosition[2],
        'endCenter': pointPosition[1]
      },
    ],
    [
      {
        'numCircles': 0,
        'originCircles': [Offset(0, 0)],
        'radiuosCircles': [0.0],
        'numRectangles': 7,
        'originRectangles': [
          Offset(100, 200),
          Offset(100, 560),
          Offset(600, 630),
          Offset(780, 360),
          Offset(300, 300),
          Offset(500, 260),
          Offset(300, 560)
        ],
        'widthRectangles': [150.0, 100.0, 50.0, 80.0, 150.0, 100.0, 100.0],
        'heightRectangles': [70.0, 100.0, 200.0, 300.0, 40.0, 300.0, 200.0],
        'numPolygons': 0,
        'sidesofPolygon': [0],
        'radiusPolygon': [0.0],
        'centerPolygon': [Offset(0, 0)],
        'startCenter': pointPosition[2],
        'endCenter': pointPosition[1]
      },
      {
        'numCircles': 0,
        'originCircles': [Offset(0, 0)],
        'radiuosCircles': [0.0],
        'numRectangles': 7,
        'originRectangles': [
          Offset(690, 430),
          Offset(500, 560),
          Offset(430, 130),
          Offset(300, 760),
          Offset(100, 230),
          Offset(100, 460),
          Offset(700, 260)
        ],
        'widthRectangles': [150.0, 100.0, 200.0, 100.0, 210.0, 210.0, 110.0],
        'heightRectangles': [150.0, 250.0, 50.0, 250.0, 50.0, 200.0, 90.0],
        'numPolygons': 0,
        'sidesofPolygon': [3, 3, 5, 4, 4],
        'radiusPolygon': [30.0, 40.0, 40.0, 40.0, 50.0],
        'centerPolygon': [
          Offset(40, 130),
          Offset(700, 90),
          Offset(600, 200),
          Offset(600, 500),
          Offset(780, 400)
        ],
        'startCenter': pointPosition[0],
        'endCenter': pointPosition[3]
      },
      {
        'numCircles': 0,
        'originCircles': [Offset(0, 0)],
        'radiuosCircles': [0.0],
        'numRectangles': 7,
        'originRectangles': [
          Offset(300, 130),
          Offset(500, 460),
          Offset(750, 530),
          Offset(600, 130),
          Offset(600, 730),
          Offset(100, 530),
          Offset(350, 460)
        ],
        'widthRectangles': [160.0, 90.0, 150.0, 100.0, 150.0, 200.0, 50.0],
        'heightRectangles': [130.0, 270.0, 150.0, 250.0, 100.0, 70.0, 250.0],
        'numPolygons': 0,
        'sidesofPolygon': [0],
        'radiusPolygon': [0.0],
        'centerPolygon': [Offset(0, 0)],
        'startCenter': pointPosition[2],
        'endCenter': pointPosition[1]
      },
    ]
  ];

  return Container(
      width: 330,
      height: 380,
      decoration: BoxDecoration(
          border: Border.all(
              width: 0.5,
              color: colors[
                  thisClass.groups[position].activities[0].progress[turn - 1] +
                      2])),
      child: Stack(children: <Widget>[
        /*
        Positioned(
          bottom: 65,
          right: 30,
          width: 90,
          height: 90,
          child: (acList.indexOf(thisClass.groups[position].currentActivity) >
                  2)
              ? celluloMap(
                  gridAcsPath[acList
                      .indexOf(thisClass.groups[position].currentActivity)],
                  turn,
                  acList.indexOf(thisClass.groups[position].currentActivity),
                  robotpatternSwitch,
                  thisClass
                      .groups[position]
                      .activities[acList
                          .indexOf(thisClass.groups[position].currentActivity)]
                      .turns[turn - 1]
                      .cellulov
                      .x,
                  thisClass
                      .groups[position]
                      .activities[acList
                          .indexOf(thisClass.groups[position].currentActivity)]
                      .turns[turn - 1]
                      .cellulov
                      .y,
                  90,
                  90)
              : Container(
                  width: screenSizeWidth,
                  height: screenSizeHeight,
                  child: Stack(children: <Widget>[
                    CustomPaint(
                        //size: Size(200, 200),
                        painter: MapShapeMaker(
                            screenSizeWidth / mapSizeWidth,
                            screenSizeHeight / mapSizeHeight,
                            mapShape[activityID][turnID]['numRectangles'],
                            mapShape[activityID][turnID]['originRectangles'],
                            mapShape[activityID][turnID]['widthRectangles'],
                            mapShape[activityID][turnID]['heightRectangles'],
                            mapShape[activityID][turnID]['numCircles'],
                            mapShape[activityID][turnID]['originCircles'],
                            mapShape[activityID][turnID]['radiuosCircles'],
                            mapShape[activityID][turnID]['numPolygons'],
                            mapShape[activityID][turnID]['sidesofPolygon'],
                            mapShape[activityID][turnID]['radiusPolygon'],
                            mapShape[activityID][turnID]['centerPolygon'],
                            mapShape[activityID][turnID]['startCenter'],
                            mapShape[activityID][turnID]['endCenter'],
                            (thisClass.groups.length > 0)
                                ? thisClass.groups[groupID]
                                    .activities[activityID].turns[turnID].mapHit
                                : {
                                    'Circles': [0, 0, 0, 0, 0, 0, 0],
                                    'Rectangles': [0, 0, 0, 0, 0, 0],
                                    'Polygons': [0, 0, 0, 0, 0, 0, 0],
                                  })),
          
                    celluloMap2(
                        turnID + 1,
                        activityID,
                        true,
                        (thisClass.groups.length > 0)
                            ? thisClass.groups[groupID].activities[activityID]
                                .turns[turnID].cellulov.x
                            : [0, 0],
                        (thisClass.groups.length > 0)
                            ? thisClass.groups[groupID].activities[activityID]
                                .turns[turnID].cellulov.y
                            : [0, 0],
                        (thisClass.groups.length > 0)
                            ? thisClass.groups[groupID].activities[activityID]
                                .turns[turnID].cellulox.x
                            : [0, 0],
                        (thisClass.groups.length > 0)
                            ? thisClass.groups[groupID].activities[activityID]
                                .turns[turnID].cellulox.y
                            : [0, 0],
                        (thisClass.groups.length > 0)
                            ? thisClass.groups[groupID].activities[activityID]
                                .turns[turnID].celluloy.x
                            : [0, 0],
                        (thisClass.groups.length > 0)
                            ? thisClass.groups[groupID].activities[activityID]
                                .turns[turnID].celluloy.y
                            : [0, 0],
                        screenSizeWidth,
                        screenSizeHeight),
                  ])),
        ),
        */
        Positioned(
            bottom: 155,
            right: 27,
            child: Text(
              thisClass.groups[position].id,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
        /*
        Positioned(bottom: 4, right: 50, child: Text(rankingSwitch ? "" : "")),
        Positioned(
          bottom: 25,
          right: 6,
          child: Text(
            mistakesSwitch
                ? (thisClass.groups[position].activities[0].progress[turn - 1] > -2
                    ? (thisClass.groups[position].activities[0].mistakes['slope'][turn - 1] == 0 &&
                            thisClass.groups[position].activities[0].mistakes['initialPoint'][turn - 1] ==
                                0
                        ? 'No Mistakes'
                        : (thisClass.groups[position].activities[0].mistakes['slope'][turn - 1] > 0 &&
                                thisClass.groups[position].activities[0]
                                        .mistakes['initialPoint'][turn - 1] >
                                    0
                            ? 'Mistakes in finding\n Slope and\n Initial Points'
                            : (thisClass.groups[position].activities[0].mistakes['slope'][turn - 1] > 0 &&
                                    thisClass.groups[position].activities[0]
                                            .mistakes['initialPoint'][turn - 1] ==
                                        0
                                ? 'Mistakes in finding\n slope'
                                : 'Mistakes in finding\n initial points')))
                    : '')
                : '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        )
        */
      ]));
}
