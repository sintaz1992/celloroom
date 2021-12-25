import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:dashboard/config/palette.dart';
import 'package:dashboard/config/styles.dart';
import 'dart:async';
import './screens.dart';
import 'package:dashboard/model/Class.dart';
import 'package:dashboard/model/Group.dart';

import 'package:dashboard/model/activities/activity.Dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:dashboard/widgets/hexagonPainter.Dart';
import 'package:dashboard/widgets/celluloMap.Dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:provider/provider.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:dashboard/widgets/showAlertDialog.Dart';
//import 'package:syncfusion_flutter_gauges/gauges.dart'
//import 'package:dashboard/model/core/models/productModel.dart';
//import 'package:dashboard/model/core/viewmodels/CRUDModel.dart';
//import 'package:provider/provider.dart';

class Monitoring extends StatefulWidget {
  @override
  MonitoringState createState() => MonitoringState();
}

class MonitoringState extends State<Monitoring> {
  bool mistakesSwitch = false;
  bool rankingSwitch = false;
  bool robotPatternSwitch = false;
  int numofgroups = thisClass.groups.length;
  int _currentSelection = 0;
  int currentstepActivation = 0;
  String pauseButtonText = 'Pause All';

  List<String> mistakesList = [
    ' Guessing Slope',
    ' Guessing Intercept',
    'Robot Speed and Slope',
    ' Moving the Joint Robot',
  ];
  Map<int, Widget> _children = {
    0: Text(acListD[0]),
    1: Text(acListD[1]),
    2: Text(acListD[2]),
    3: Text(acListD[3]),
    4: Text(acListD[4]),
    5: Text(acListD[5]),
    6: Text(acListD[6]),
    7: Text(acListD[7]),
  };

  @override
  void initState() {
    // print(thisClass.finishedGroupsNum);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  final productProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Palette.primaryColor,
          elevation: 0.0,
          title: Text('Monitor your class'),
          leading: IconButton(
            icon: const Icon(Icons.search),
            iconSize: 28.0,
            onPressed: () {},
          ),
          //  actions: <Widget>[
          //    IconButton(
          //     icon: const Icon(Icons.notifications_none),
          //     iconSize: 28.0,
          //     onPressed: () {},
          //   ),
          //  ],
        ),
        body: SingleChildScrollView(
            //   padding: const EdgeInsets.all(10.0),
            child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                  color: Colors.lightBlue,
                  child: ListTile(
                      title: Text(
                    "Control the current class activities",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )))),
          MaterialSegmentedControl(
            children: _children,
            selectionIndex: _currentSelection,
            borderColor: Colors.grey,
            selectedColor: Colors.blue,
            unselectedColor: Colors.white,
            borderRadius: 32.0,
            disabledChildren: [
              //  3,
            ],
            onSegmentChosen: (index) {
              // showAlertDialog(context, '', 'Pay Attention',
              //     'Are you sure you want to change the activity for all teams?');
              setState(() {
                _currentSelection = index;
                thisClass.finishedGroupsNum[index] = 0;

                for (int i = 0; i < thisClass.groups.length; i++) {
                  thisClass.dbSessionRef
                      .collection('groups')
                      .doc(thisClass.groupIDs[i])
                      .update({
                    'currentActivity': acList[index],
                  });
                }
              });
            },
          ),
          Row(
            //  mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                  color: Colors.lightBlue,
                  child: ListTile(
                      title: Text(
                    "Monitor the class progress:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )))),
          Consumer<Classroom>(
              builder: (context, model, child) => Row(children: <Widget>[
                    Column(children: <Widget>[
                      Container(
                        width: 200,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: Card(
                            child: Column(children: <Widget>[
                          CircularStepProgressIndicator(
                            totalSteps: 4,
                            width: 50,
                            height: 50,
                            padding: 10,
                            // currentStep: 1,
                            customColor: (index) =>
                                (thisClass.groups.length > 0)
                                    ? (thisClass.finishedGroupsNum[
                                                    _currentSelection] /
                                                thisClass.groups.length >=
                                            (index + 1) * 0.25
                                        ? Colors.green
                                        : Colors.grey)
                                    : Colors.grey,
                          ),
                          Text(
                            mistakesList[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ])),
                        //  color: Colors.teal[100],
                      ),
                      Container(
                        width: 200,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: Card(
                            child: Column(children: <Widget>[
                          CircularStepProgressIndicator(
                            totalSteps: 4,
                            width: 50,
                            height: 50,
                            padding: 10,
                            // currentStep: 1,
                            customColor: (index) =>
                                (thisClass.groups.length > 0)
                                    ? (thisClass.finishedGroupsNum[
                                                    _currentSelection] /
                                                thisClass.groups.length >=
                                            (index + 1) * 0.25
                                        ? Colors.green
                                        : Colors.grey)
                                    : Colors.grey,
                          ),
                          Text(
                            mistakesList[2],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ])),
                        //  color: Colors.teal[100],
                      ),
                    ]),
                    SizedBox(
                      width: 20,
                    ),
                    Column(children: <Widget>[
                      Container(
                        width: 200,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: Card(
                            child: Column(children: <Widget>[
                          CircularStepProgressIndicator(
                            totalSteps: 4,
                            width: 50,
                            height: 50,
                            padding: 10,
                            // currentStep: 1,
                            customColor: (index) =>
                                (thisClass.groups.length > 0)
                                    ? (thisClass.finishedGroupsNum[
                                                    _currentSelection] /
                                                thisClass.groups.length >=
                                            (index + 1) * 0.25
                                        ? Colors.green
                                        : Colors.grey)
                                    : Colors.grey,
                          ),
                          Text(
                            mistakesList[1],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ])),
                        //  color: Colors.teal[100],
                      ),
                      Container(
                        width: 220,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: Card(
                            child: Column(children: <Widget>[
                          CircularStepProgressIndicator(
                            totalSteps: 4,
                            width: 50,
                            height: 50,
                            padding: 10,
                            // currentStep: 1,
                            customColor: (index) =>
                                (thisClass.groups.length > 0)
                                    ? (thisClass.finishedGroupsNum[
                                                    _currentSelection] /
                                                thisClass.groups.length >=
                                            (index + 1) * 0.25
                                        ? Colors.green
                                        : Colors.grey)
                                    : Colors.grey,
                          ),
                          Text(
                            mistakesList[3],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ])),
                        //  color: Colors.teal[100],
                      ),
                    ]),
                    SizedBox(
                      width: 50,
                    ),
                    Card(
                        child: Column(
                      children: <Widget>[
                        CircularStepProgressIndicator(
                          totalSteps: 4,
                          width: 100,
                          height: 100,
                          padding: 10,
                          // currentStep: 1,
                          customColor: (index) => (thisClass.groups.length > 0)
                              ? (thisClass.finishedGroupsNum[
                                              _currentSelection] /
                                          thisClass.groups.length >=
                                      (index + 1) * 0.25
                                  ? Colors.green
                                  : Colors.grey)
                              : Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          thisClass.finishedGroupsNum[_currentSelection]
                                  .toString() +
                              ' groups have finihsed the activity',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    )),
                  ])),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Card(
                  color: Colors.lightBlue,
                  child: ListTile(
                      title: Text(
                    "Monitor All groups progress:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )))),
          SizedBox(
              height: 430,
              child: Consumer<Classroom>(
                builder: (context, model, child) => Container(
                    child: ListView.builder(
                  itemCount: thisClass.groups.length,
                  itemBuilder: (context, int position) {
                    return Card(
                        child: ListTile(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupDashboard(currentgroupID: position)));
                      },
                      title: Row(children: <Widget>[
                        Stack(children: <Widget>[
                          CustomPaint(
                            size: Size(100, 100),
                            painter: HexagonPainter(
                                Offset(50, 50),
                                40.0,
                                (thisClass.groups[position].cellulox.status ==
                                            2 &&
                                        thisClass.groups[position].celluloy
                                                .status ==
                                            2 &&
                                        thisClass.groups[position]
                                                .tabletStatus ==
                                            'YES')
                                    ? Colors.green
                                    : Colors.green),
                          ),
                          CustomPaint(
                            size: Size(100, 100),
                            painter: HexagonPainter(
                                Offset(50, 50), 30.0, Colors.white),
                          ),
                          Container(
                              width: 100,
                              height: 100,
                              child: Center(
                                  child: Text(
                                thisClass.groups[position].id,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ))),
                        ]),
                        SizedBox(width: 17),
                        Container(
                            width: 100,
                            height: 100,
                            child: Stack(children: <Widget>[
                              CircularStepProgressIndicator(
                                totalSteps: 3,
                                //  currentStep:
                                //    thisClass.groups[position].activities[0].progress,
                                width: 100,
                                customColor: (index) => thisClass
                                            .groups[position]
                                            .activities[acList.indexOf(thisClass
                                                .groups[position]
                                                .currentActivity)]
                                            .progress[index] >
                                        -2
                                    ? (thisClass
                                                .groups[position]
                                                .activities[acList.indexOf(
                                                    thisClass.groups[position]
                                                        .currentActivity)]
                                                .progress[index] >
                                            -1
                                        ? (thisClass
                                                    .groups[position]
                                                    .activities[acList.indexOf(thisClass.groups[position].currentActivity)]
                                                    .progress[index] >
                                                0
                                            ? Colors.green
                                            : Colors.blue)
                                        : Colors.red)
                                    : Colors.grey,
                              ),
                              Center(child: Text('Progress')),
                            ])),
                        SizedBox(width: 25),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                                width: 100,
                                height: 100,
                                child: SfRadialGauge(axes: <RadialAxis>[
                                  RadialAxis(
                                      showLabels: false,
                                      minimum: 0,
                                      maximum: 150,
                                      ranges: <GaugeRange>[
                                        GaugeRange(
                                            startValue: 0,
                                            endValue: 50,
                                            color: Colors.orange,
                                            startWidth: 10,
                                            endWidth: 10),
                                        GaugeRange(
                                            startValue: 50,
                                            endValue: 100,
                                            color: Colors.green,
                                            startWidth: 10,
                                            endWidth: 10),
                                        GaugeRange(
                                            startValue: 100,
                                            endValue: 150,
                                            color: Colors.red,
                                            startWidth: 10,
                                            endWidth: 10)
                                      ],
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                            value: thisClass
                                                .groups[position].engagement)
                                      ],
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                            angle: 90, positionFactor: 0.5)
                                      ])
                                ])),
                            Text('Total Engagement')
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: <Widget>[
                            Stack(children: <Widget>[
                              Positioned(
                                top: 50,
                                left: 22,
                                child: Image.asset(
                                    "assets/images/celluloRed.png",
                                    height: 20,
                                    width: 20),
                              ),
                              Container(
                                  width: 100,
                                  height: 100,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        showLabels: false,
                                        minimum: 0,
                                        maximum: 100,
                                        ranges: <GaugeRange>[
                                          GaugeRange(
                                              startValue: 0,
                                              endValue: (thisClass
                                                              .groups[position]
                                                              .engagementX >
                                                          10 &&
                                                      thisClass.groups[position]
                                                              .engagementY >
                                                          10)
                                                  ? (thisClass.groups[position]
                                                          .engagementX *
                                                      100 /
                                                      thisClass.groups[position]
                                                          .engagement)
                                                  : 50,
                                              color: Colors.red,
                                              startWidth: 10,
                                              endWidth: 10),
                                          GaugeRange(
                                              startValue: (thisClass
                                                              .groups[position]
                                                              .engagementX >
                                                          10 &&
                                                      thisClass.groups[position]
                                                              .engagementY >
                                                          10)
                                                  ? (thisClass.groups[position]
                                                          .engagementX *
                                                      100 /
                                                      thisClass.groups[position]
                                                          .engagement)
                                                  : 50,
                                              endValue: 100,
                                              color: Colors.blue,
                                              startWidth: 10,
                                              endWidth: 10)
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              angle: 90, positionFactor: 0.5)
                                        ])
                                  ])),
                              Positioned(
                                top: 50,
                                left: 60,
                                child: Image.asset(
                                    "assets/images/celluloBlue.png",
                                    height: 20,
                                    width: 20),
                              ),
                            ]),
                            Text('Realtive Engagement'),
                          ],
                        ),
                        SizedBox(
                          width: 125,
                        ),
                        MaterialButton(
                          color: Colors.red,
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              if (pauseButtonText == 'Pause All')
                                pauseButtonText = 'Resume All';
                              else
                                pauseButtonText = 'Pause All';
                            });
                            for (int groupID = 0;
                                groupID < thisClass.groups.length;
                                groupID++) {
                              if (pauseButtonText == 'Pause All')
                                thisClass.dbSessionRef
                                    .collection('groups')
                                    .doc(thisClass.groupIDs[groupID])
                                    .update({'isPaused': false});

                              if (pauseButtonText == 'Resume All')
                                thisClass.dbSessionRef
                                    .collection('groups')
                                    .doc(thisClass.groupIDs[groupID])
                                    .update({'isPaused': true});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Pause',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ]),
                      trailing: Icon(Icons.more_vert),
                    ));
                  },
                )),
              )),
        ])));
  }
}
