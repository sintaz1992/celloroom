import 'package:dashboard/Dash_Activities/Ac1.dart';
import 'package:dashboard/Dash_Activities/Ac2.dart';
import 'package:dashboard/Dash_Activities/Ac3.dart';
import 'package:dashboard/Dash_Activities/Ac4.dart';
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
import 'package:dashboard/widgets/mapShapeMaker.dart';
import 'package:dashboard/widgets/miniature.dart';
import 'package:provider/provider.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
//import 'package:dashboard/model/core/models/productModel.dart';
//import 'package:dashboard/model/core/viewmodels/CRUDModel.dart';
//import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class Debriefing extends StatefulWidget {
  @override
  DebriefingState createState() => DebriefingState();
}

class DebriefingState extends State<Debriefing> {
  bool mistakesSwitch = false;
  bool rankingSwitch = false;
  bool robotPatternSwitch = true;
  int activityID = 0;
  int activityListIndex = 0;
  double _userRating = 3.0;
  int numofgroups = thisClass.groups.length;
  int _currentSelection = 0;
  int currentstepActivation = 0;
  String playButtonText = 'Pause All';
  String selectedactivity = 'Ac1';
  CountDownController _controller = CountDownController();
  bool activitystarted = false;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Live Mode'),
    Tab(text: 'Class Gallery'),
  ];
  final List<Tab> myTabs2 = <Tab>[
    Tab(text: 'First Turn'),
    Tab(text: 'Second Turn'),
    Tab(text: 'Third Turn'),
    Tab(text: 'All in one'),
  ];
  @override
  void initState() {
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

        // leading: IconButton(
        //    icon: const Icon(Icons.menu),
        //    iconSize: 28.0,
        //    onPressed: () {},
        //  ),
        //  actions: <Widget>[
        //    IconButton(
        //     icon: const Icon(Icons.notifications_none),
        //     iconSize: 28.0,
        //     onPressed: () {},
        //   ),
        //  ],
      ),
      body: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Palette.primaryColor,
              elevation: 0.0,
              bottom: TabBar(
                tabs: myTabs,
              ),
              // leading: IconButton(
              //    icon: const Icon(Icons.menu),
              //    iconSize: 28.0,
              //    onPressed: () {},
              //  ),
              //  actions: <Widget>[
              //    IconButton(
              //     icon: const Icon(Icons.notifications_none),
              //     iconSize: 28.0,
              //     onPressed: () {},
              //   ),
              //  ],
            ),
            body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(children: [
                Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      border: Border.all(color: Colors.purple),
                      //  borderRadius: new BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      'Activities',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                Container(
                    height: 340,
                    width: 300,
                    // margin: const EdgeInsets.all(15.0),
                    //  padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      border: Border.all(color: Colors.purple),
                      //  borderRadius: new BorderRadius.circular(25.0),
                    ),
                    child: ListView.builder(
                        itemCount: acListD.length,
                        itemBuilder: (context, int position) {
                          return ListTile(
                            leading: Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                            ),
                            onTap: () {
                              setState(() {
                                activityListIndex = position;
                                //  print(acList.length);
                                activityID = position;
                              });
                            },
                            title: Text(
                              acListD[position],
                              style: TextStyle(
                                  color: (activityListIndex == position)
                                      ? Colors.blue
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          );
                        })),
              ]),
              SizedBox(
                  // height: 1000,
                  width: 1300,
                  child: TabBarView(
                    children: [
                      Column(children: [
                        SizedBox(
                            height: 430,
                            child: (true)
                                ? Consumer<Classroom>(
                                    builder: (context, model, child) =>
                                        Container(
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
                                                        GroupDashboard(
                                                            currentgroupID:
                                                                position)));
                                          },
                                          title: Row(children: <Widget>[
                                            Stack(children: <Widget>[
                                              CustomPaint(
                                                size: Size(100, 100),
                                                painter: HexagonPainter(
                                                    Offset(50, 50),
                                                    40.0,
                                                    (thisClass
                                                                    .groups[
                                                                        position]
                                                                    .cellulox
                                                                    .status ==
                                                                2 &&
                                                            thisClass
                                                                    .groups[
                                                                        position]
                                                                    .celluloy
                                                                    .status ==
                                                                2 &&
                                                            thisClass
                                                                    .groups[
                                                                        position]
                                                                    .tabletStatus ==
                                                                'YES')
                                                        ? Colors.green
                                                        : Colors.green),
                                              ),
                                              CustomPaint(
                                                size: Size(100, 100),
                                                painter: HexagonPainter(
                                                    Offset(50, 50),
                                                    30.0,
                                                    Colors.white),
                                              ),
                                              Container(
                                                  width: 100,
                                                  height: 100,
                                                  child: Center(
                                                      child: Text(
                                                    thisClass
                                                        .groups[position].id,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ))),
                                            ]),
                                            SizedBox(width: 17),
                                            SizedBox(width: 25),
                                            SizedBox(
                                              width: 25,
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
                                                      child: SfRadialGauge(
                                                          axes: <RadialAxis>[
                                                            RadialAxis(
                                                                showLabels:
                                                                    false,
                                                                minimum: 0,
                                                                maximum: 100,
                                                                ranges: <
                                                                    GaugeRange>[
                                                                  GaugeRange(
                                                                      startValue:
                                                                          0,
                                                                      endValue: (thisClass.groups[position].engagementX > 10 &&
                                                                              thisClass.groups[position].engagementY >
                                                                                  10)
                                                                          ? (thisClass.groups[position].engagementX *
                                                                              100 /
                                                                              thisClass
                                                                                  .groups[
                                                                                      position]
                                                                                  .engagement)
                                                                          : 50,
                                                                      color: Colors
                                                                          .red,
                                                                      startWidth:
                                                                          10,
                                                                      endWidth:
                                                                          10),
                                                                  GaugeRange(
                                                                      startValue: (thisClass.groups[position].engagementX > 10 &&
                                                                              thisClass.groups[position].engagementY >
                                                                                  10)
                                                                          ? (thisClass.groups[position].engagementX *
                                                                              100 /
                                                                              thisClass
                                                                                  .groups[
                                                                                      position]
                                                                                  .engagement)
                                                                          : 50,
                                                                      endValue:
                                                                          100,
                                                                      color: Colors
                                                                          .blue,
                                                                      startWidth:
                                                                          10,
                                                                      endWidth:
                                                                          10)
                                                                ],
                                                                annotations: <
                                                                    GaugeAnnotation>[
                                                                  GaugeAnnotation(
                                                                      angle: 90,
                                                                      positionFactor:
                                                                          0.5)
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

                                            /*
                                    MaterialButton(
                                      color: Colors.red,
                                      elevation: 0,
                                      onPressed: () {
                                        setState(() {
                                          if (playButtonText == 'Pause All')
                                            playButtonText = 'Resume All';
                                          else
                                            playButtonText = 'Pause All';
                                        });
                                        for (int groupID = 0;
                                            groupID < thisClass.groups.length;
                                            groupID++) {
                                          if (playButtonText == 'Pause All')
                                            thisClass.dbSessionRef
                                                .collection('groups')
                                                .doc(
                                                    thisClass.groupIDs[groupID])
                                                .update({'isPaused': false});

                                          if (playButtonText == 'Resume All')
                                            thisClass.dbSessionRef
                                                .collection('groups')
                                                .doc(
                                                    thisClass.groupIDs[groupID])
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
                                    */
                                          ]),
                                          trailing: IconButton(
                                            icon: Icon(Icons.more_vert),
                                            onPressed: () {
                                              //   _onDeleteItemPressed(index);
                                            },
                                          ),
                                        ));
                                      },
                                    )),
                                  )
                                : Text('')),
                      ]),
                      DefaultTabController(
                          length: 4,
                          child: Scaffold(
                            backgroundColor: Colors.white,
                            appBar: AppBar(
                              backgroundColor: Palette.primaryColor,
                              elevation: 0.0,
                              bottom: TabBar(
                                tabs: myTabs2,
                              ),
                              // leading: IconButton(
                              //    icon: const Icon(Icons.menu),
                              //    iconSize: 28.0,
                              //    onPressed: () {},
                              //  ),
                              //  actions: <Widget>[
                              //    IconButton(
                              //     icon: const Icon(Icons.notifications_none),
                              //     iconSize: 28.0,
                              //     onPressed: () {},
                              //   ),
                              //  ],
                            ),
                            body: SizedBox(
                                height: 600,
                                width: 1300,
                                child: TabBarView(
                                  children: [
                                    Consumer<Classroom>(
                                        builder: (context, model, child) =>
                                            Container(
                                              width: 550,
                                              height: 600,
                                              child: GridView.count(
                                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                                  // horizontal, this produces 2 rows.
                                                  crossAxisCount: 2,
                                                  // Generate 100 widgets that display their index in the List.
                                                  children: List.generate(
                                                    thisClass.groups.length,
                                                    (position) {
                                                      return Card(
                                                          child: ListTile(
                                                        onLongPress: () {
                                                          /*
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupDashboard(currentgroupID: position)));
                      */
                                                        },
                                                        title: Row(children: <
                                                            Widget>[
                                                          SizedBox(width: 17),
                                                          Text(
                                                            thisClass
                                                                .groups[
                                                                    position]
                                                                .id,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 13),
                                                          ),
                                                          SizedBox(width: 25),
                                                          minituare(
                                                              position,
                                                              1,
                                                              mistakesSwitch,
                                                              rankingSwitch,
                                                              robotPatternSwitch),
                                                          SizedBox(
                                                            width: 25,
                                                          ),
                                                        ]),
                                                        trailing: Icon(
                                                            Icons.more_vert),
                                                      ));
                                                    },
                                                  )),
                                            )),
                                    Consumer<Classroom>(
                                      builder: (context, model, child) => Container(
                                          width: 550,
                                          height: 550,
                                          child: GridView.count(
                                              // Create a grid with 2 columns. If you change the scrollDirection to
                                              // horizontal, this produces 2 rows.
                                              crossAxisCount: 2,
                                              // Generate 100 widgets that display their index in the List.
                                              children: List.generate(
                                                thisClass.groups.length,
                                                (position) {
                                                  return Card(
                                                      child: ListTile(
                                                    onLongPress: () {
                                                      /*
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupDashboard(currentgroupID: position)));
                      */
                                                    },
                                                    title: minituare(
                                                        position,
                                                        2,
                                                        mistakesSwitch,
                                                        rankingSwitch,
                                                        robotPatternSwitch),
                                                  ));
                                                },
                                              ))),
                                    ),
                                    Consumer<Classroom>(
                                      builder: (context, model, child) => Container(
                                          width: 550,
                                          height: 550,
                                          child: GridView.count(
                                              // Create a grid with 2 columns. If you change the scrollDirection to
                                              // horizontal, this produces 2 rows.
                                              crossAxisCount: 2,
                                              // Generate 100 widgets that display their index in the List.
                                              children: List.generate(
                                                thisClass.groups.length,
                                                (position) {
                                                  return Card(
                                                      child: ListTile(
                                                    onLongPress: () {
                                                      /*
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupDashboard(currentgroupID: position)));
                      */
                                                    },
                                                    title:
                                                        Row(children: <Widget>[
                                                      SizedBox(width: 17),
                                                      Text(
                                                        thisClass
                                                            .groups[position]
                                                            .id,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13),
                                                      ),
                                                      SizedBox(width: 25),
                                                      minituare(
                                                          position,
                                                          1,
                                                          mistakesSwitch,
                                                          rankingSwitch,
                                                          robotPatternSwitch),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      minituare(
                                                          position,
                                                          2,
                                                          mistakesSwitch,
                                                          rankingSwitch,
                                                          robotPatternSwitch),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      minituare(
                                                          position,
                                                          3,
                                                          mistakesSwitch,
                                                          rankingSwitch,
                                                          robotPatternSwitch),
                                                    ]),
                                                    trailing:
                                                        Icon(Icons.more_vert),
                                                  ));
                                                },
                                              ))),
                                    ),
                                    Consumer<Classroom>(
                                      builder: (context, model, child) => Container(
                                          width: 550,
                                          height: 550,
                                          child: GridView.count(
                                              // Create a grid with 2 columns. If you change the scrollDirection to
                                              // horizontal, this produces 2 rows.
                                              crossAxisCount: 2,
                                              // Generate 100 widgets that display their index in the List.
                                              children: List.generate(
                                                thisClass.groups.length,
                                                (position) {
                                                  return Card(
                                                      child: ListTile(
                                                    onLongPress: () {
                                                      /*
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupDashboard(currentgroupID: position)));
                      */
                                                    },
                                                    title:
                                                        Row(children: <Widget>[
                                                      SizedBox(width: 17),
                                                      Text(
                                                        thisClass
                                                            .groups[position]
                                                            .id,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13),
                                                      ),
                                                      SizedBox(width: 25),
                                                      minituare(
                                                          position,
                                                          3,
                                                          mistakesSwitch,
                                                          rankingSwitch,
                                                          robotPatternSwitch),
                                                    ]),
                                                  ));
                                                },
                                              ))),
                                    ),
                                  ],
                                )),
                          )),
                    ],
                  )),
            ]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (playButtonText == 'Start the activity')
              playButtonText = 'Pause the activity';
            else
              playButtonText = 'Resume the activity';
          });
          for (int groupID = 0; groupID < thisClass.groups.length; groupID++) {
            if (playButtonText == 'Pause All')
              thisClass.dbSessionRef
                  .collection('groups')
                  .doc(thisClass.groupIDs[groupID])
                  .update({'isPaused': false});

            if (playButtonText == 'Resume All')
              thisClass.dbSessionRef
                  .collection('groups')
                  .doc(thisClass.groupIDs[groupID])
                  .update({'isPaused': true});
          }
        },
        tooltip: playButtonText,
        child: activitystarted
            ? Icon(Icons.pause_circle_filled)
            : Icon(Icons.play_circle_filled),
        elevation: 6.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: InkWell(
                  focusColor: Colors.orange,
                  child: Text('What should I do?'),
                  onTap: () {
                    setState(() {
                      print('');
                    });
                  },
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: InkWell(
                  focusColor: Colors.orange,
                  child: Text('Student Preview'),
                  onTap: () {
                    setState(() {
                      print('');
                    });
                  },
                )),
            CircularCountDownTimer(
              // Countdown duration in Seconds
              duration: 10,

              // Controller to control (i.e Pause, Resume, Restart) the Countdown
              controller: _controller,

              // Width of the Countdown Widget
              width: 100,

              // Height of the Countdown Widget
              height: 100,

              // Default Color for Countdown Timer
              color: Colors.white,

              // Filling Color for Countdown Timer
              fillColor: Colors.red,

              // Background Color for Countdown Widget
              backgroundColor: null,

              // Border Thickness of the Countdown Circle
              strokeWidth: 5.0,

              // Text Style for Countdown Text
              textStyle: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),

              // true for reverse countdown (max to 0), false for forward countdown (0 to max)
              isReverse: false,

              // true for reverse animation, false for forward animation
              isReverseAnimation: false,

              // Optional [bool] to hide the [Text] in this widget.
              isTimerTextShown: true,

              // Function which will execute when the Countdown Ends
              onComplete: () {
                // Here, do whatever you want
              },
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
      ),
    );
  }
}
