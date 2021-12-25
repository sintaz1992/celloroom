import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/widgets/custom_app_bar.dart';
import 'package:dashboard/widgets/celluloMap.Dart';
import 'dart:convert';
import 'package:dashboard/config/palette.dart';
import 'dart:async';
import 'package:dashboard/model/Class.dart';
import 'package:dashboard/model/Group.dart';
import 'package:dashboard/model/activities/activity.Dart';
import 'package:dashboard/config/palette.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:dashboard/widgets/mapShapeMaker.dart';
//import 'package:flutter_png/flutter_png.dart';
import 'package:dashboard/widgets/linePainter.Dart';
//import 'package:dashboard/model/core/models/productModel.dart';
//import 'package:dashboard/model/core/viewmodels/CRUDModel.dart';
import 'package:provider/provider.dart';

class GroupDashboardSole extends StatefulWidget {
  final int currentgroupID;

  GroupDashboardSole({Key key, this.currentgroupID}) : super(key: key);

  @override
  GroupDashboardSoleState createState() => GroupDashboardSoleState();
}

class GroupDashboardSoleState extends State<GroupDashboardSole> {
  final TextStyle whiteText = TextStyle(color: Colors.white, fontSize: 20);
  Timer timer;
  var progress;
  int groupID = 0;
  int studentListIndex = 0;
  int activityID = 4;
  int activityListIndex = 0;
  int turnID = 0;
  int trialID = 0;
  List<int> gColor;
  bool celluloxSwitch = true;
  bool celluloySwitch = true;
  double mapSizeWidth = 760;
  double mapSizeHeight = 760;
  double screenSizeWidth = 500;
  double screenSizeHeight = 500;
  static List<Offset> pointPosition = [
    Offset(80, 80),
    Offset(760, 80),
    Offset(80, 760),
    Offset(760, 760)
  ];

  String valueAc = '';
  String valueTurn = '';

  List<double> normalizecellulopath(List<double> path) {
    List<double> pathnorm = new List();
    for (int i = 0; i < path.length; i++) {
      pathnorm.add(path[i] * screenSizeHeight);
    }
    return pathnorm;
  }

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
  var _currentSliderValue = RangeValues(0.0, 1);
  List<double> _currentCelluloSliderValue = [
    0.5,
    0.5,
    0.5,
    0.5,
    0.5,
    0.5,
    0.5,
    0.5,
    0.5,
    0.5,
  ];
  String pauseButtonText = 'Pause';
  @override
  void initState() {
    super.initState();
    if (widget.currentgroupID != null) groupID = widget.currentgroupID;
  }

//@override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Classroom>(
        builder: (context, model, child) =>
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Center(
                  child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                      child: Row(children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text('Activity',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: valueAc,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  if (newValue == 'Five') {
                                    activityID = 4;
                                  }

                                  if (newValue == 'Six') {
                                    activityID = 5;
                                  }

                                  if (newValue == 'Seven') {
                                    activityID = 6;
                                  }

                                  if (newValue == 'Eight') {
                                    activityID = 7;
                                  }
                                });

                                thisClass.getPosition(
                                    groupID, activityID, turnID, trialID);
                              },
                              items: <String>[
                                '',
                                'Five',
                                'Six',
                                'Seven',
                                'Eight'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('Turn',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black))),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: valueTurn,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  turnID = int.parse(newValue) - 1;
                                });

                                thisClass.getPosition(
                                    groupID, activityID, turnID, trialID);
                              },
                              items: <String>[
                                '',
                                '1',
                                '2',
                                '3'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('Group',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black))),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: valueTurn,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  groupID = int.parse(newValue) - 1;
                                });

                                thisClass.getPosition(
                                    groupID, activityID, turnID, trialID);
                              },
                              items: <String>[
                                '',
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('Trial',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black))),
                        Padding(
                            padding: EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: valueTurn,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  trialID = int.parse(newValue) - 1;
                                });

                                thisClass.getPosition(
                                    groupID, activityID, turnID, trialID);
                              },
                              items: <String>[
                                '',
                                '1',
                                '2',
                                '3'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                      ]))),
              Center(
                child: SingleChildScrollView(
                    child: Container(
                        height: 680,
                        width: 1600,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child:
                            Column(crossAxisAlignment: CrossAxisAlignment.start,

                                //    mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Container(
                                            width: 550,
                                            height: 550,
                                            child: Stack(children: <Widget>[
                                              celluloMap(
                                                gridAcsPath[activityID],
                                                trialID,
                                                turnID + 1,
                                                activityID,
                                                true,
                                                (thisClass.groups.length > 0)
                                                    ? thisClass
                                                        .groups[groupID]
                                                        .activities[activityID]
                                                        .turns[turnID]
                                                        .trials[trialID]
                                                        .cellulov
                                                        .x
                                                    : [0, 0],
                                                (thisClass.groups.length > 0)
                                                    ? thisClass
                                                        .groups[groupID]
                                                        .activities[activityID]
                                                        .turns[turnID]
                                                        .trials[trialID]
                                                        .cellulov
                                                        .y
                                                    : [0, 0],
                                                screenSizeWidth,
                                                screenSizeHeight,
                                              ),
                                              CustomPaint(
                                                size: Size(screenSizeWidth,
                                                    screenSizeWidth),
                                                painter: LinePainter2(
                                                    normalizecellulopath(
                                                        thisClass
                                                            .groups[groupID]
                                                            .activities[
                                                                activityID]
                                                            .turns[turnID]
                                                            .trials[trialID]
                                                            .cellulox
                                                            .x),
                                                    normalizecellulopath(
                                                        thisClass
                                                            .groups[groupID]
                                                            .activities[
                                                                activityID]
                                                            .turns[turnID]
                                                            .trials[trialID]
                                                            .cellulox
                                                            .y)),
                                              ),
                                              Positioned(
                                                left: ((thisClass.groups
                                                                    .length >
                                                                0)
                                                            ? thisClass
                                                                .groups[groupID]
                                                                .activities[
                                                                    activityID]
                                                                .turns[turnID]
                                                                .trials[trialID]
                                                                .cellulov
                                                                .x[((_currentCelluloSliderValue[
                                                                        groupID] *
                                                                    thisClass
                                                                        .groups[
                                                                            groupID]
                                                                        .activities[
                                                                            activityID]
                                                                        .turns[
                                                                            turnID]
                                                                        .trials[
                                                                            trialID]
                                                                        .cellulov
                                                                        .x
                                                                        .length
                                                                        .floor()))
                                                                .toInt()]
                                                            : 100.0) *
                                                        screenSizeWidth -
                                                    20,
                                                top: ((thisClass.groups.length >
                                                                0)
                                                            ? thisClass
                                                                .groups[groupID]
                                                                .activities[
                                                                    activityID]
                                                                .turns[turnID]
                                                                .trials[trialID]
                                                                .cellulov
                                                                .y[((_currentCelluloSliderValue[
                                                                        groupID] *
                                                                    thisClass
                                                                        .groups[
                                                                            groupID]
                                                                        .activities[
                                                                            activityID]
                                                                        .turns[
                                                                            turnID]
                                                                        .trials[
                                                                            trialID]
                                                                        .cellulov
                                                                        .y
                                                                        .length
                                                                        .floor()))
                                                                .toInt()]
                                                            : 200.0) *
                                                        screenSizeHeight -
                                                    20,
                                                width: 40,
                                                height: 40,
                                                child: Card(
                                                  child: Image.asset(
                                                      "assets/images/celluloPurple.png",
                                                      height: 40,
                                                      width: 40),
                                                ),
                                              ),
                                              Positioned(
                                                left: ((thisClass.groups
                                                                    .length >
                                                                0)
                                                            ? thisClass
                                                                .groups[groupID]
                                                                .activities[
                                                                    activityID]
                                                                .turns[turnID]
                                                                .trials[trialID]
                                                                .cellulov
                                                                .x[(((_currentCelluloSliderValue[
                                                                        groupID] *
                                                                    thisClass
                                                                        .groups[
                                                                            groupID]
                                                                        .activities[
                                                                            activityID]
                                                                        .turns[
                                                                            turnID]
                                                                        .trials[
                                                                            trialID]
                                                                        .cellulov
                                                                        .y
                                                                        .length
                                                                        .floor())))
                                                                .toInt()]
                                                            : 100.0) *
                                                        screenSizeWidth -
                                                    15,
                                                top: 125,
                                                width: 30,
                                                height: 30,
                                                child: Card(
                                                  child: Image.asset(
                                                      "assets/images/celluloRed.png",
                                                      height: 20,
                                                      width: 20),
                                                ),
                                              ),
                                              Positioned(
                                                left: 125,
                                                top: ((thisClass.groups.length >
                                                                0)
                                                            ? thisClass
                                                                .groups[groupID]
                                                                .activities[
                                                                    activityID]
                                                                .turns[turnID]
                                                                .trials[trialID]
                                                                .cellulov
                                                                .y[(((_currentCelluloSliderValue[
                                                                        groupID] *
                                                                    thisClass
                                                                        .groups[
                                                                            groupID]
                                                                        .activities[
                                                                            activityID]
                                                                        .turns[
                                                                            turnID]
                                                                        .trials[
                                                                            trialID]
                                                                        .cellulov
                                                                        .y
                                                                        .length
                                                                        .floor())))
                                                                .toInt()]
                                                            : 200.0) *
                                                        screenSizeHeight -
                                                    15,
                                                width: 30,
                                                height: 30,
                                                child: Card(
                                                  child: Image.asset(
                                                      "assets/images/celluloBlue.png",
                                                      height: 20,
                                                      width: 20),
                                                ),
                                              ),
                                            ]))),
                                    Slider(
                                        activeColor: Colors.purple,
                                        value:
                                            _currentCelluloSliderValue[groupID],
                                        min: 0.05,
                                        max: 0.95,
                                        // divisions: 5,
                                        // label: _currentSliderValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _currentCelluloSliderValue[
                                                groupID] = value;
                                          });
                                        }),
                                    Container(
                                        width: 480,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.red)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              /*
                    Container(
                      height: 140,
                      width:screenSizeHeight/2,
   
                     child: Column(children:[
                   
                    Padding(
                    padding: EdgeInsets.all(5.0),
                   child:   Card(
                        
                  color: Colors.blue,
                  child: ListTile(
                      title: 
                      
                      
                      
                      Text(
                    "Velocity Robot Blue:    ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                  ),
       
                  ))), 


                 Padding(
                    padding: EdgeInsets.all(5.0),
                   child:   Card(
                  color: Colors.red,
                  child: ListTile(
                      title: 
            
                      Text(
                    "Velocity Robot Red:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                  ),
    
                   ))), 

                   ])),
                   
                    Container(
                      height: 140,
                      width:screenSizeHeight/2,
   
                     child: Column(children:[
                   
                    Padding(
                    padding: EdgeInsets.all(5.0),
                   child:   Card(
                        
                  color: Colors.blue,
                  child: ListTile(
                      title: 
                      
                      
                      
                      Text(
                     double.parse((thisClass.groups[position]
                                                  .activities[activityID]
                                                  .turns[turnID].velocity[1]).toStringAsFixed(1)).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
       
                  ))), 


                 Padding(
                    padding: EdgeInsets.all(5.0),
                   child:   Card(
                  color: Colors.red,
                  child: ListTile(
                      title: 
                      
                  
                      
                      Text(
                      double.parse((thisClass.groups[position]
                                                  .activities[activityID]
                                                  .turns[turnID].velocity[0]).toStringAsFixed(1)).toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
    
                   ))), 

                   ])),
                   */
                                              Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Container(
                                                      height: 100,
                                                      width:
                                                          screenSizeHeight / 2,
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Card(
                                                              color:
                                                                  Colors.orange,
                                                              child: ListTile(
                                                                title: Text(
                                                                  "Mean Error: " +
                                                                      double.parse(
                                                                              (thisClass.groups[groupID].activities[activityID].turns[turnID].error).toStringAsFixed(1))
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ))))),
                                            ])),
                                  ]),
                            ]))),
              ),
              /*
                      Column(
                        children: <Widget>[
                          Row(
                              //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Robot Red Path',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      //   color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                Checkbox(
                                  //title: const Text('Animate Slowly'),
                                  value: celluloxSwitch,
                                  onChanged: (bool value) {
                                    setState(() {
                                      celluloxSwitch = value;
                                    });
                                  },
                                  // secondary: const Icon(Icons.hourglass_empty),
                                ),
                                Text(
                                  'Robot Blue Path',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      //   color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                Checkbox(
                                  //title: const Text('Animate Slowly'),
                                  value: celluloxSwitch,
                                  onChanged: (bool value) {
                                    setState(() {
                                      celluloxSwitch = value;
                                    });
                                  },
                                  // secondary: const Icon(Icons.hourglass_empty),
                                ),

                                /*
                Text(
                  'Show Students robot pattern',
                  style: TextStyle(
                      fontSize: 15.0,
                      //   color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Checkbox(
                  value: robotPatternSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      robotPatternSwitch = value;
                    });
                  },
                  // secondary: const Icon(Icons.hourglass_empty),
                ),
             */
                              ]),
                          Row(
                              //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Robot Purple Path',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      //   color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                Checkbox(
                                  //title: const Text('Animate Slowly'),
                                  value: celluloxSwitch,
                                  onChanged: (bool value) {
                                    setState(() {
                                      celluloxSwitch = value;
                                    });
                                  },
                                  // secondary: const Icon(Icons.hourglass_empty),
                                ),

                                /*
                Text(
                  'Show Students robot pattern',
                  style: TextStyle(
                      fontSize: 15.0,
                      //   color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Checkbox(
                  value: robotPatternSwitch,
                  onChanged: (bool value) {
                    setState(() {
                      robotPatternSwitch = value;
                    });
                  },
                  // secondary: const Icon(Icons.hourglass_empty),
                ),
             */
                              ]),
                          SizedBox(height: 20),
                        
                        ],
                      )
                      */
              /*
                      Column(
                          //    mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            infoTile(
                                (thisClass.groups.length > 0)
                                    ? thisClass
                                        .groups[groupID]
                                        .activities[activityID]
                                        .turns[turnID]
                                        .mistakes['slope']
                                        .toString()
                                    : '0',
                                'Mistakes in finding slope',
                                Colors.blue),
                            (activityID == 0)
                                ? infoTile(
                                    (thisClass.groups.length > 0)
                                        ? thisClass
                                            .groups[groupID]
                                            .activities[activityID]
                                            .turns[turnID]
                                            .mistakes['initialPoint']
                                            .toString()
                                        : '0',
                                    'Mistakes in finding initial Point',
                                    Colors.blue)
                                : infoTile(
                                    (thisClass.groups.length > 0)
                                        ? thisClass
                                            .groups[groupID]
                                            .activities[activityID]
                                            .turns[turnID]
                                            .mistakes['intercept']
                                            .toString()
                                        : '0',
                                    'Mistakes in finding intercept',
                                    Colors.blue),
                          ])
                    */

              /*
                Row(
                    //    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 100),
                      FloatingActionButton(
                        heroTag: "prevButton",
                        tooltip: 'Previous Turn',
                        onPressed: () {
                          if (turnID > 0) {
                            setState(() {
                              turnID = turnID - 1;
                            });
                          }
                        },
                        child: Icon(Icons.skip_previous),
                        backgroundColor: Palette.primaryColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        ((turnID + 1 > 1)
                                ? ((turnID + 1 > 2) ? 'Third ' : 'Second ')
                                : 'First ') +
                            "Turn ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(width: 10),
                      FloatingActionButton(
                        heroTag: "nextButton",
                        tooltip: 'Next Turn',
                        onPressed: () {
                          //       print('turnID' + turnID.toString());
                          if (turnID < 2) {
                            setState(() {
                              turnID = turnID + 1;
                            });
                          }
                        },
                        child: Icon(Icons.skip_next),
                        backgroundColor: Palette.primaryColor,
                      ),
                    ]),
                    */
            ]));
  }
}
