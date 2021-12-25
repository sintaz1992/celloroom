import 'package:dashboard/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/commons/theme.dart';
import 'package:dashboard/widgets/responsive_widget.dart';
import 'package:dashboard/widgets/sidebar_menu..dart';
import 'package:dashboard/widgets/group_List.dart';
import 'package:dashboard/widgets/group_names.dart';
import 'package:dashboard/model/Class.dart';
import 'package:provider/provider.dart';
import 'package:dashboard/model/activities/activity.Dart';
import 'package:dashboard/widgets/showAlertDialog.Dart';
import 'package:dashboard/widgets/countdown.dart';
import 'dart:async';
import 'package:dashboard/model/student.dart';
import 'package:dashboard/widgets/mapTablet.dart' as mapTablet;

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String starttext = 'Start';
  bool firstshow = false;

  ScrollController _globalscrollcontroller = new ScrollController();
  ScrollController _globalscrollcontroller2 = new ScrollController();
  Timer popuptimer;
  List<String> pacelist = ['Move the class to activity ...'];
  Timer timerdata;
  Timer timertime;
  List<String> activitylist = [
    'First Activity',
    'Second Activity',
    'Third Activity',
    'Fourth Activity',
  ];
  @override
  void initState() {
    super.initState();
    thisClass.elapseTimer.start();
    thisClass.getDocs();

    timerdata = new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      thisClass.setupDatabse();
      timerdata.cancel();
    });
    timertime = new Timer.periodic(new Duration(milliseconds: 5000), (time) {
      thisClass.dbSessionRef.update({
        'timepassed':
            thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    student.playgroundheight = (MediaQuery.of(context).size.width - 50) / 3;
    student.playgroundheight = (MediaQuery.of(context).size.width - 50) / 3;
    if (student.playgroundheight > 400) student.playgroundheight = 400;

    //if (student.playgroundheight < 30) student.playgroundheight = 30;
    student.cellulosize =
        student.playgroundheight * student.initialcellulosize / 500;

    // student.notifyListeners();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
          child: Consumer<Classroom>(
              builder: (context, model, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ResponsiveWidget.isLargeScreen(context)
                          ? SideBarMenu()
                          : Container(),
                      (thisClass.classPage == 1)
                          ? Flexible(
                              fit: FlexFit.loose,
                              child: Consumer<Classroom>(
                                  builder: (context, model, child) => Column(
                                        //mainAxisSize: MainAxisSize.min,
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 55,
                                            width: _media.width,
                                            child: AppBar(
                                              elevation: 4,
                                              centerTitle: true,
                                              title: Text(
                                                '',
                                              ),
                                              actions: [
                                                Text(''),
                                                Spacer(),
                                                thisClass.repairmode
                                                    ? Column(children: [
                                                        Spacer(),
                                                        Text(
                                                          'The robot of group ' +
                                                              thisClass
                                                                  .brokengroup
                                                                  .toString() +
                                                              ' does not work.',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 20),
                                                        ),
                                                        Spacer(),
                                                      ])
                                                    : Text(''),
                                                Spacer(),
                                                IconButton(
                                                    icon: Icon(Icons.help),
                                                    onPressed: () {
                                                      showAlertDialog3(
                                                          context,
                                                          'How to use the orchestartion tool?',
                                                          'First you need to ask your students to login to studentcelloroom.web.app. After they have to put their names, group number and press "join the session".',
                                                          'After all students joined the session, you can start your session and manage it with the orchestartion features. bon class!');
                                                    })
                                              ],
                                              backgroundColor: drawerBgColor,
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                  height:
                                                      0.7 * _media.height / 3,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 0.7 *
                                                            _media.height /
                                                            3,
                                                        width: _media.width /
                                                                6 +
                                                            _media.width / 18,
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    drawerBgColor,
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      drawerBgColor,
                                                                  width: 5,
                                                                )),
                                                        child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Spacer(flex: 1),
                                                              Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Spacer(
                                                                        flex:
                                                                            1),
                                                                    Consumer<
                                                                            Classroom>(
                                                                        builder: (context,
                                                                                model,
                                                                                child) =>
                                                                            IconButton(
                                                                              tooltip: starttext,
                                                                              icon: thisClass.startClass ? Icon(Icons.pause_circle_outline_outlined) : Icon(Icons.play_circle_outline_outlined),
                                                                              onPressed: () {
                                                                                if (thisClass.maxnumgroups > 0) {
                                                                                  if (!thisClass.startClass) {
                                                                                    // thisClass.getDocs();

                                                                                    thisClass.startClass = true;
                                                                                    setState(() {
                                                                                      starttext = 'Pause';
                                                                                    });
                                                                                    for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {}
                                                                                    thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                      "event": 'start',
                                                                                      "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                                    });
                                                                                  } else {
                                                                                    if (!thisClass.classPaused) {
                                                                                      setState(() {
                                                                                        thisClass.classPaused = true;
                                                                                      });
                                                                                      for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                        thisClass.dbSessionRef.collection('groups').doc((groupID + 1).toString()).collection('teacherpause').add({
                                                                                          'pause': true
                                                                                        });
                                                                                        thisClass.groupcolor[groupID] = Colors.orange;
                                                                                        thisClass.groupPaused[groupID] = true;
                                                                                      }
                                                                                      thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                        "event": 'pauseclass',
                                                                                        "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                                      });
                                                                                    } else {
                                                                                      setState(() {
                                                                                        thisClass.classPaused = false;
                                                                                      });

                                                                                      for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                        thisClass.dbSessionRef.collection('groups').doc((groupID + 1).toString()).collection('teacherpause').add({
                                                                                          'pause': false
                                                                                        });
                                                                                        thisClass.groupcolor[groupID] = drawerBgColor;
                                                                                        thisClass.groupPaused[groupID] = false;
                                                                                      }
                                                                                      thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                        "event": 'resumeclass',
                                                                                        "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                                      });
                                                                                    }
                                                                                  }
                                                                                }
                                                                              },
                                                                              color: thisClass.classPaused ? Colors.green : Colors.white,
                                                                              iconSize: _media.width / 25,
                                                                            )),
                                                                    /*
                                          Text(
                                            starttext,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          */
                                                                    Spacer(
                                                                        flex:
                                                                            1),
                                                                  ]),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                              Column(children: <
                                                                  Widget>[
                                                                Spacer(flex: 1),
                                                                PopupMenuButton(
                                                                  onSelected: (int
                                                                      index) {
                                                                    /*
                                                                        if (index ==
                                                                            2) {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                true;
                                                                            thisClass.movemode =
                                                                                true;
                                                                            thisClass.limitmode =
                                                                                false;
                                                                          });
                                                                        }
                                                                        if (index ==
                                                                            1) {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                true;
                                                                            thisClass.limitmode =
                                                                                true;
                                                                            thisClass.movemode =
                                                                                false;
                                                                          });
                                                                        }
                                                                        */
                                                                    if (index ==
                                                                        0) {
                                                                      setState(
                                                                          () {
                                                                        thisClass.activitySelect =
                                                                            true;
                                                                        thisClass.limitmode =
                                                                            false;
                                                                        thisClass.movemode =
                                                                            false;
                                                                      });
                                                                      /*s
                                                                          for (int i = 0;
                                                                              i < thisClass.maxnumgroups;
                                                                              i++) {
                                                                            thisClass.dbSessionRef.collection('groups').doc((i + 1).toString()).collection('teacheraclimit').add({
                                                                              'limit': acListT[3]
                                                                            });
                                                                          }

                                                                          thisClass
                                                                              .dbSessionRef
                                                                              .collection("teacherevents")
                                                                              .add({
                                                                            "event":
                                                                                'limitoff',
                                                                            "time":
                                                                                thisClass.elapseTimer.elapsedMilliseconds,
                                                                          });
                                                                          */
                                                                    }
                                                                  },
                                                                  tooltip:
                                                                      'Class pace',
                                                                  initialValue:
                                                                      thisClass
                                                                          .selectedAcIndex,
                                                                  child: Icon(
                                                                    (Icons
                                                                        .speed_outlined),
                                                                    color: Colors
                                                                        .white,
                                                                    size: _media
                                                                            .width /
                                                                        25,
                                                                  ),
                                                                  itemBuilder:
                                                                      (context) {
                                                                    return List.generate(
                                                                        pacelist
                                                                            .length,
                                                                        (index) {
                                                                      return PopupMenuItem(
                                                                        value:
                                                                            index,
                                                                        child: Text(
                                                                            pacelist[index]),
                                                                      );
                                                                    });
                                                                  },
                                                                ),
                                                                /*
                                          Padding(
                                              padding: EdgeInsets.only(top: 0),
                                              child: Text(
                                                'Pace',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          */
                                                                Spacer(flex: 1),
                                                              ]),
                                                              Spacer(flex: 1),
                                                            ]),
                                                      ),
                                                      GroupWidget(
                                                          media: _media),
                                                      Container(
                                                        height: 0.7 *
                                                            _media.height /
                                                            3,
                                                        width: _media.width /
                                                                6 -
                                                            20 -
                                                            _media.width / 18,
                                                        color: drawerBgColor,
                                                        child: thisClass
                                                                .activitySelect
                                                            ? (thisClass
                                                                    .limitmode
                                                                ? Center(
                                                                    child: TextButton(
                                                                        onPressed: () {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                false;
                                                                          });

                                                                          for (int i = 0;
                                                                              i < thisClass.maxnumgroups;
                                                                              i++) {
                                                                            thisClass.dbSessionRef.collection('groups').doc((i + 1).toString()).collection('teacheraclimit').add({
                                                                              'limit': acListT[thisClass.selectedAcIndex]
                                                                            });
                                                                          }

                                                                          thisClass
                                                                              .dbSessionRef
                                                                              .collection("teacherevents")
                                                                              .add({
                                                                            "event":
                                                                                'limitactivityclass',
                                                                            'activity':
                                                                                thisClass.selectedAcIndex,
                                                                            "time":
                                                                                thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              //border: Border.all(color: Colors.purple),
                                                                              borderRadius: new BorderRadius.circular(25.0),
                                                                            ),
                                                                            child: Padding(
                                                                                padding: EdgeInsets.all(16.0),
                                                                                child: Text(
                                                                                  'Limit the class',
                                                                                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                )))))
                                                                : Center(
                                                                    child: TextButton(
                                                                        onPressed: () {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                false;
                                                                          });

                                                                          for (int i = 0;
                                                                              i < thisClass.maxnumgroups;
                                                                              i++) {
                                                                            thisClass.dbSessionRef.collection('groups').doc((i + 1).toString()).update({
                                                                              'currentActivity': acListT[thisClass.selectedAcIndex],
                                                                            });

                                                                            thisClass.groups[i].activities[thisClass.selectedAcIndex].progress =
                                                                                [
                                                                              -2,
                                                                              -2,
                                                                              -2
                                                                            ];
                                                                            if (thisClass.selectedAcIndex ==
                                                                                0)
                                                                              thisClass.scoresac1[i] = 0;

                                                                            if (thisClass.selectedAcIndex ==
                                                                                1)
                                                                              thisClass.scoresac2[i] = 0;
                                                                            if (thisClass.selectedAcIndex ==
                                                                                2)
                                                                              thisClass.scoresac3[i] = 0;
                                                                            if (thisClass.selectedAcIndex ==
                                                                                2)
                                                                              thisClass.scoresac4[i] = 0;
                                                                          }

                                                                          thisClass
                                                                              .dbSessionRef
                                                                              .collection("teacherevents")
                                                                              .add({
                                                                            "event":
                                                                                'moveactivityclass',
                                                                            'activity':
                                                                                thisClass.selectedAcIndex,
                                                                            "time":
                                                                                thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              //border: Border.all(color: Colors.purple),
                                                                              borderRadius: new BorderRadius.circular(25.0),
                                                                            ),
                                                                            child: Padding(
                                                                                padding: EdgeInsets.all(16.0),
                                                                                child: Text(
                                                                                  'Move to this activity',
                                                                                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                ))))))
                                                            : Container(),
                                                      ),
                                                      /*
                            Expanded(
                                child: Container(
                                    // width: _media.height,
                                    child: CountDownTimer2()
                                    //  height: _media.height,
                                    ))
                                    */
                                                    ],
                                                  ))),
                                          thisClass.maxnumgroups > 0
                                              ? Scrollbar(
                                                  thickness: 5,
                                                  isAlwaysShown: true,
                                                  child: Container(
                                                    // alignment: Alignmen,
                                                    decoration:
                                                        new BoxDecoration(
                                                      // You can use like this way or like the below line
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(3.0),
                                                    ),
                                                    height: _media.height -
                                                        0.7 *
                                                            _media.height /
                                                            3 -
                                                        55 -
                                                        20 -
                                                        20,
                                                    // width: _media.width / 6,
                                                    child: Consumer<Classroom>(
                                                        builder: (context,
                                                                model, child) =>
                                                            ListView.builder(
                                                                itemCount: thisClass
                                                                    .maxnumgroups,
                                                                itemBuilder:
                                                                    (context,
                                                                        int position) {
                                                                  return Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .start,
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .start,
                                                                          children: <
                                                                              Widget>[
                                                                            Container(
                                                                                height: _media.height / 12,
                                                                                width: _media.width / 6 + _media.width / 18,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.white60,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(10),
                                                                                      bottomLeft: Radius.circular(10),
                                                                                    ),
                                                                                    border: Border.all(
                                                                                      color: thisClass.groupcolor[position],
                                                                                      width: 10,
                                                                                    )),
                                                                                child: Row(children: <Widget>[
                                                                                  new Padding(
                                                                                      padding: EdgeInsets.all(0),
                                                                                      child: Container(
                                                                                        width: _media.width / 22,
                                                                                        height: _media.height / 18,
                                                                                        //I used some padding without fixed width and height
                                                                                        decoration: new BoxDecoration(
                                                                                          shape: BoxShape.circle, // You can use like this way or like the below line
                                                                                          //borderRadius: new BorderRadius.circular(30.0),
                                                                                          color: thisClass.groupcolor[position],
                                                                                        ),
                                                                                        child: FittedBox(
                                                                                            fit: BoxFit.contain,
                                                                                            child: Padding(
                                                                                                padding: EdgeInsets.all(5),
                                                                                                child: Text(
                                                                                                  (position + 1).toString(),
                                                                                                  style: new TextStyle(color: Colors.white),
                                                                                                  textAlign: TextAlign.center,
                                                                                                ))), // You can add a Icon instead of text also, like below.
                                                                                        //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                                                                      )),
                                                                                  Padding(
                                                                                      padding: EdgeInsets.all(2),
                                                                                      child: Container(
                                                                                        width: _media.width / 6 + _media.width / 18 - _media.width / 16,
                                                                                        height: _media.height / 11,
                                                                                        child: Scrollbar(
                                                                                            child: SingleChildScrollView(
                                                                                                scrollDirection: Axis.horizontal,
                                                                                                child: Row(
                                                                                                    //    shrinkWrap: true,
                                                                                                    // Create a grid with 2 columns. If you change the scrollDirection to
                                                                                                    // horizontal, this produces 2 rows.
                                                                                                    //  crossAxisCount: 3,
                                                                                                    //crossAxisSpacing: 50,
                                                                                                    // Generate 100 widgets that display their index in the List.
                                                                                                    children: List.generate(thisClass.students[position].length, (index) {
                                                                                                  return Padding(
                                                                                                      padding: EdgeInsets.all(1),
                                                                                                      child: Card(
                                                                                                          //height: _media.height / 44,
                                                                                                          color: drawerBgColor,
                                                                                                          child: FittedBox(
                                                                                                              fit: BoxFit.fill,
                                                                                                              child: Padding(
                                                                                                                  padding: EdgeInsets.all(5),
                                                                                                                  child: Text(
                                                                                                                    thisClass.students[position][index],
                                                                                                                    style: new TextStyle(color: Colors.white, fontSize: 17),
                                                                                                                  )))));
                                                                                                })))),
                                                                                      )),
                                                                                ])),
                                                                            GroupNamesWidget(
                                                                              media: _media,
                                                                              groupID: position,
                                                                            ),
                                                                            Container(
                                                                                height: _media.height / 12,
                                                                                width: _media.width / 6 - 20 - _media.width / 18,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white60,
                                                                                  border: Border.all(
                                                                                    color: thisClass.groupcolor[position],
                                                                                    width: 10,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topRight: Radius.circular(10),
                                                                                    bottomRight: Radius.circular(10),
                                                                                  ),
                                                                                ),
                                                                                child: thisClass.startClass
                                                                                    ? Row(children: <Widget>[
                                                                                        Spacer(flex: 1),
                                                                                        Consumer<Classroom>(
                                                                                            builder: (context, model, child) => Container(
                                                                                                height: _media.height / 10,
                                                                                                child: Center(
                                                                                                    child: Padding(
                                                                                                        padding: EdgeInsets.only(bottom: 5),
                                                                                                        child: InkWell(
                                                                                                          //tooltip: 'Pause the group',
                                                                                                          child: thisClass.startClass
                                                                                                              ? Icon(
                                                                                                                  Icons.pause_circle_outline_outlined,
                                                                                                                  size: _media.height / 20,
                                                                                                                  color: thisClass.groupPaused[position] ? Colors.red : drawerBgColor,
                                                                                                                )
                                                                                                              : Icon(
                                                                                                                  Icons.play_circle_outline_outlined,
                                                                                                                  size: _media.height / 20,
                                                                                                                  color: drawerBgColor,
                                                                                                                ),
                                                                                                          onTap: () {
                                                                                                            if (!thisClass.startClass) {
                                                                                                            } else {
                                                                                                              if (!thisClass.groupPaused[position]) {
                                                                                                                setState(() {
                                                                                                                  thisClass.groupcolor[position] = Colors.green;
                                                                                                                });
                                                                                                                thisClass.groupPaused[position] = true;

                                                                                                                thisClass.dbSessionRef.collection('groups').doc((position + 1).toString()).collection('teacherpause').add({'pause': true});
                                                                                                                thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                                                  "event": 'pausegroup',
                                                                                                                  'group': position + 1,
                                                                                                                  "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                                                                });
                                                                                                                var numpause = 0;
                                                                                                                for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                                                  if (thisClass.groupPaused[groupID] == true) {
                                                                                                                    numpause = numpause + 1;
                                                                                                                  } else {
                                                                                                                    break;
                                                                                                                  }
                                                                                                                }
                                                                                                                if (numpause == thisClass.maxnumgroups)
                                                                                                                  setState(() {
                                                                                                                    thisClass.classPaused = true;
                                                                                                                  });
                                                                                                              } else {
                                                                                                                setState(() {
                                                                                                                  thisClass.groupcolor[position] = drawerBgColor;
                                                                                                                });
                                                                                                                thisClass.groupPaused[position] = false;
                                                                                                                thisClass.dbSessionRef.collection('groups').doc((position + 1).toString()).collection('teacherpause').add({'pause': false});
                                                                                                                thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                                                  "event": 'resumegroup',
                                                                                                                  'group': position + 1,
                                                                                                                  "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                                                                });
                                                                                                                var numpause = 0;
                                                                                                                for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                                                  if (thisClass.groupPaused[groupID] == false) {
                                                                                                                    numpause = numpause + 1;
                                                                                                                  } else {
                                                                                                                    break;
                                                                                                                  }
                                                                                                                }
                                                                                                                if (numpause == thisClass.maxnumgroups)
                                                                                                                  setState(() {
                                                                                                                    thisClass.classPaused = false;
                                                                                                                  });
                                                                                                              }
                                                                                                            }
                                                                                                          },
                                                                                                        ))))),
                                                                                        Spacer(flex: 1),
                                                                                        Container(
                                                                                            height: _media.height / 10,
                                                                                            child: Center(
                                                                                                child: Padding(
                                                                                                    padding: EdgeInsets.only(bottom: 5),
                                                                                                    child: PopupMenuButton(
                                                                                                      onSelected: (int index) {
                                                                                                        thisClass.dbSessionRef.collection('groups').doc((position + 1).toString()).update({
                                                                                                          'currentActivity': acListT[index],
                                                                                                        });
                                                                                                        thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                                          "event": 'moveactivitygroup',
                                                                                                          'group': position + 1,
                                                                                                          'activity': index,
                                                                                                          "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                                                        });
                                                                                                      },
                                                                                                      tooltip: 'Move the group to ...',
                                                                                                      initialValue: thisClass.selectedAcIndex,
                                                                                                      child: Icon(
                                                                                                        (Icons.exit_to_app_outlined),
                                                                                                        color: drawerBgColor,
                                                                                                        size: _media.height / 20,
                                                                                                      ),
                                                                                                      itemBuilder: (context) {
                                                                                                        return List.generate(activitylist.length, (index) {
                                                                                                          return PopupMenuItem(
                                                                                                            value: index,
                                                                                                            child: Text(activitylist[index]),
                                                                                                          );
                                                                                                        });
                                                                                                      },
                                                                                                    )))),
                                                                                        Spacer(flex: 1),
                                                                                        Container(
                                                                                            height: _media.height / 10,
                                                                                            child: Center(
                                                                                                child: Padding(
                                                                                                    padding: EdgeInsets.only(bottom: 5),
                                                                                                    child: InkWell(
                                                                                                      //tooltip: 'Pause the group',
                                                                                                      child: Icon(
                                                                                                        Icons.refresh,
                                                                                                        size: _media.height / 20,
                                                                                                        color: drawerBgColor,
                                                                                                      ),

                                                                                                      onTap: () {
                                                                                                        if (!thisClass.startClass) {
                                                                                                        } else {
                                                                                                          print('dccd');
                                                                                                          thisClass.dbSessionRef.collection('groups').doc((position + 1).toString()).delete();
                                                                                                          thisClass.students[position] = [];
                                                                                                          thisClass.groups[position].activities[0].progress = [-2, -2, -2];
                                                                                                          thisClass.groups[position].activities[1].progress = [-2, -2, -2];
                                                                                                          thisClass.groups[position].activities[2].progress = [-2, -2, -2];
                                                                                                          thisClass.groups[position].activities[3].progress = [-2, -2, -2];
                                                                                                          thisClass.scoresac1[position] = 0;
                                                                                                          thisClass.scoresac2[position] = 0;
                                                                                                          thisClass.scoresac3[position] = 0;
                                                                                                          thisClass.scoresac4[position] = 0;
                                                                                                        }
                                                                                                      },
                                                                                                    )))),
                                                                                        /*
                                                                                        Container(
                                                                                            height: _media.height / 10,
                                                                                            child: Center(
                                                                                                child: Tooltip(
                                                                                                    message: 'Add a member',
                                                                                                    child: InkWell(
                                                                                                      onTap: () {
                                                                                                        // showAlertDialog2(context, '', ',', 'Please ask all the students in this group to refresh their pages. After they need to login');

                                                                                                        thisClass.numstudents[position] = 10;
                                                                                                        print(thisClass.numstudents);
                                                                                                        thisClass.dbSessionRef.collection('groups').doc((position + 1).toString()).collection('numberstudents').add({'is4person': true});
                                                                                                        thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                                          "event": 'add1persongroup',
                                                                                                          'group': position + 1,
                                                                                                          "time": thisClass.elapseTimer.elapsedMilliseconds,
                                                                                                        });
                                                                                                        thisClass.notifyListeners();
                                                                                                      },
                                                                                                      child: Icon(
                                                                                                        (Icons.add_circle_outlined),
                                                                                                        color: thisClass.numstudents[position] == 10 ? Colors.green : drawerBgColor,
                                                                                                        size: _media.height / 20,
                                                                                                      ),
                                                                                                    )))),
                                                                                                    */
                                                                                      ])
                                                                                    : Container()),
                                                                            /*
                                      Expanded(
                                          child: Container(
                                        // width: _media.height,
                                        height: _media.height,
                                      ))
                                      */
                                                                          ]));
                                                                })),
                                                  ))
                                              : Container(
                                                  // alignment: Alignmen,
                                                  decoration: new BoxDecoration(
                                                    // You can use like this way or like the below line
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(3.0),
                                                  ),
                                                  height:
                                                      2 * _media.height / 3 -
                                                          55,
                                                  // width: _media.width / 6,
                                                  child: Center(
                                                      child: Text(
                                                    'No groups yet\nFor more information, click on the Help button in the top-right of the tool.',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        height: 1.4,
                                                        fontFamily:
                                                            'RobotoMono',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                        ],
                                      )),
                            )
                          : (thisClass.classPage == 2)
                              ? Flexible(
                                  fit: FlexFit.loose,
                                  child: Consumer<Classroom>(
                                      builder: (context, model, child) =>
                                          Column(
                                            //mainAxisSize: MainAxisSize.min,
                                            //crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 55,
                                                width: _media.width,
                                                child: AppBar(
                                                  elevation: 4,
                                                  centerTitle: true,
                                                  title: Text(
                                                    '',
                                                  ),
                                                  actions: [
                                                    IconButton(
                                                        icon: Icon(Icons.help),
                                                        onPressed: () {
                                                          showAlertDialog3(
                                                              context,
                                                              'How to use the orchestartion tool?',
                                                              'First you need to ask your students to login to studentcelloroom.web.app. After they have to put their names, group number and press "join the session".',
                                                              'After all students joined the session, you can start your session and manage it with the orchestartion features. bon class!');
                                                        })
                                                  ],
                                                  backgroundColor:
                                                      drawerBgColor,
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Container(
                                                      height: 0.7 *
                                                          _media.height /
                                                          3,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            height: 0.7 *
                                                                _media.height /
                                                                3,
                                                            width: _media
                                                                        .width /
                                                                    6 +
                                                                _media.width /
                                                                    18,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color:
                                                                        drawerBgColor,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          drawerBgColor,
                                                                      width: 5,
                                                                    )),
                                                            child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Spacer(
                                                                      flex: 1),
                                                                  /*
                                                              Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Spacer(
                                                                        flex:
                                                                            1),
                                                                    Consumer<
                                                                            Classroom>(
                                                                        builder: (context,
                                                                                model,
                                                                                child) =>
                                                                            IconButton(
                                                                              tooltip: starttext,
                                                                              icon: thisClass.startClass ? Icon(Icons.pause_circle_outline_outlined) : Icon(Icons.play_circle_outline_outlined),
                                                                              onPressed: () {
                                                                                if (thisClass.maxnumgroups > 0) {
                                                                                  if (!thisClass.startClass) {
                                                                                    thisClass.startClass = true;
                                                                                    setState(() {
                                                                                      starttext = 'Pause';
                                                                                    });
                                                                                    for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                      thisClass.dbSessionRef.collection('groups').doc((groupID + 1).toString()).collection('teacherpermis').add({
                                                                                        'permis': true
                                                                                      });
                                                                                    }
                                                                                    thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                      "event": 'start',
                                                                                      "time": thisClass.elapseTimer.elapsedMilliseconds,
                                                                                    });
                                                                                  } else {
                                                                                    if (!thisClass.classPaused) {
                                                                                      setState(() {
                                                                                        thisClass.classPaused = true;
                                                                                      });
                                                                                      for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                        thisClass.dbSessionRef.collection('groups').doc((groupID + 1).toString()).collection('teacherpause').add({
                                                                                          'pause': true
                                                                                        });
                                                                                        thisClass.groupcolor[groupID] = Colors.green;
                                                                                        thisClass.groupPaused[groupID] = true;
                                                                                      }
                                                                                      thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                        "event": 'pauseclass',
                                                                                        "time": thisClass.elapseTimer.elapsedMilliseconds,
                                                                                      });
                                                                                    } else {
                                                                                      setState(() {
                                                                                        thisClass.classPaused = false;
                                                                                      });

                                                                                      for (int groupID = 0; groupID < thisClass.maxnumgroups; groupID++) {
                                                                                        thisClass.dbSessionRef.collection('groups').doc((groupID + 1).toString()).collection('teacherpause').add({
                                                                                          'pause': false
                                                                                        });
                                                                                        thisClass.groupcolor[groupID] = drawerBgColor;
                                                                                        thisClass.groupPaused[groupID] = false;
                                                                                      }
                                                                                      thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                        "event": 'resumeclass',
                                                                                        "time": thisClass.elapseTimer.elapsedMilliseconds,
                                                                                      });
                                                                                    }
                                                                                  }
                                                                                }
                                                                              },
                                                                              color: thisClass.classPaused ? Colors.green : Colors.white,
                                                                              iconSize: _media.width / 25,
                                                                            )),
                                                                    /*
                                          Text(
                                            starttext,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          */
                                                                    Spacer(
                                                                        flex:
                                                                            1),
                                                                  ]),
                                                              Spacer(
                                                                flex: 1,
                                                              ),
                                                              Column(
                                                                  children: <
                                                                      Widget>[
                                                                    Spacer(
                                                                        flex:
                                                                            1),
                                                                    PopupMenuButton(
                                                                      onSelected:
                                                                          (int
                                                                              index) {
                                                                        if (index ==
                                                                            2) {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                true;
                                                                            thisClass.movemode =
                                                                                true;
                                                                            thisClass.limitmode =
                                                                                false;
                                                                          });
                                                                        }
                                                                        if (index ==
                                                                            1) {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                true;
                                                                            thisClass.limitmode =
                                                                                true;
                                                                            thisClass.movemode =
                                                                                false;
                                                                          });
                                                                        }
                                                                        if (index ==
                                                                            0) {
                                                                          setState(
                                                                              () {
                                                                            thisClass.activitySelect =
                                                                                false;
                                                                            thisClass.limitmode =
                                                                                false;
                                                                            thisClass.movemode =
                                                                                false;
                                                                          });
                                                                          for (int i = 0;
                                                                              i < thisClass.maxnumgroups;
                                                                              i++) {
                                                                            thisClass.dbSessionRef.collection('groups').doc((i + 1).toString()).collection('teacheraclimit').add({
                                                                              'limit': acListT[3]
                                                                            });
                                                                          }

                                                                          thisClass
                                                                              .dbSessionRef
                                                                              .collection("teacherevents")
                                                                              .add({
                                                                            "event":
                                                                                'limitoff',
                                                                            "time":
                                                                                thisClass.elapseTimer.elapsedMilliseconds,
                                                                          });
                                                                        }
                                                                      },
                                                                      tooltip:
                                                                          'Class pace',
                                                                      initialValue:
                                                                          thisClass
                                                                              .selectedAcIndex,
                                                                      child:
                                                                          Icon(
                                                                        (Icons
                                                                            .speed_outlined),
                                                                        color: Colors
                                                                            .white,
                                                                        size: _media.width /
                                                                            25,
                                                                      ),
                                                                      itemBuilder:
                                                                          (context) {
                                                                        return List.generate(
                                                                            pacelist.length,
                                                                            (index) {
                                                                          return PopupMenuItem(
                                                                            value:
                                                                                index,
                                                                            child:
                                                                                Text(pacelist[index]),
                                                                          );
                                                                        });
                                                                      },
                                                                    ),
                                                                    /*
                                          Padding(
                                              padding: EdgeInsets.only(top: 0),
                                              child: Text(
                                                'Pace',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          */
                                                                    Spacer(
                                                                        flex:
                                                                            1),
                                                                  ]),
                                                                  */
                                                                  Spacer(
                                                                      flex: 1),
                                                                ]),
                                                          ),
                                                          GroupWidget(
                                                              media: _media),
                                                          Container(
                                                            height: 0.7 *
                                                                _media.height /
                                                                3,
                                                            width: _media
                                                                        .width /
                                                                    6 -
                                                                20 -
                                                                _media.width /
                                                                    18,
                                                            color:
                                                                drawerBgColor,
                                                            child: thisClass
                                                                    .activitySelect
                                                                ? (thisClass
                                                                        .limitmode
                                                                    ? Center(
                                                                        child: TextButton(
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                thisClass.activitySelect = false;
                                                                              });

                                                                              for (int i = 0; i < thisClass.maxnumgroups; i++) {
                                                                                thisClass.dbSessionRef.collection('groups').doc((i + 1).toString()).collection('teacheraclimit').add({
                                                                                  'limit': acListT[thisClass.selectedAcIndex]
                                                                                });
                                                                              }

                                                                              thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                "event": 'limitactivityclass',
                                                                                'activity': thisClass.selectedAcIndex,
                                                                                "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  //border: Border.all(color: Colors.purple),
                                                                                  borderRadius: new BorderRadius.circular(25.0),
                                                                                ),
                                                                                child: Padding(
                                                                                    padding: EdgeInsets.all(16.0),
                                                                                    child: Text(
                                                                                      'Limit the class',
                                                                                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                    )))))
                                                                    : Center(
                                                                        child: TextButton(
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                thisClass.activitySelect = false;
                                                                              });

                                                                              for (int i = 0; i < thisClass.maxnumgroups; i++) {
                                                                                thisClass.dbSessionRef.collection('groups').doc((i + 1).toString()).update({
                                                                                  'currentActivity': acListT[thisClass.selectedAcIndex],
                                                                                });
                                                                              }

                                                                              thisClass.dbSessionRef.collection("teacherevents").add({
                                                                                "event": 'moveactivityclass',
                                                                                'activity': thisClass.selectedAcIndex,
                                                                                "time": thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.white,
                                                                                  //border: Border.all(color: Colors.purple),
                                                                                  borderRadius: new BorderRadius.circular(25.0),
                                                                                ),
                                                                                child: Padding(
                                                                                    padding: EdgeInsets.all(16.0),
                                                                                    child: Text(
                                                                                      'Move to this activity',
                                                                                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                    ))))))
                                                                : Container(),
                                                          ),
                                                          /*
                            Expanded(
                                child: Container(
                                    // width: _media.height,
                                    child: CountDownTimer2()
                                    //  height: _media.height,
                                    ))
                                    */
                                                        ],
                                                      ))),
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                                child: thisClass.maxnumgroups >
                                                        0
                                                    ? Scrollbar(
                                                        thickness: 5,
                                                        isAlwaysShown: true,
                                                        child: Container(
                                                          // alignment: Alignmen,
                                                          decoration:
                                                              new BoxDecoration(
                                                            // You can use like this way or like the below line
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    3.0),
                                                          ),
                                                          height: _media
                                                                  .height -
                                                              0.7 *
                                                                  _media
                                                                      .height /
                                                                  3 -
                                                              55 -
                                                              20 -
                                                              20,
                                                          // width: _media.width / 6,
                                                          child: Consumer<
                                                                  Classroom>(
                                                              builder: (context,
                                                                      model,
                                                                      child) =>
                                                                  ListView.builder(
                                                                      itemCount: thisClass.maxnumgroups,
                                                                      itemBuilder: (context, int position) {
                                                                        return Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10),
                                                                            child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                                              Container(
                                                                                  height: _media.height / 12,
                                                                                  // width: _media.width / 6 + _media.width / 18,
                                                                                  decoration: BoxDecoration(
                                                                                      color: Colors.white60,
                                                                                      borderRadius: BorderRadius.only(
                                                                                        topLeft: Radius.circular(10),
                                                                                        bottomLeft: Radius.circular(10),
                                                                                      ),
                                                                                      border: Border.all(
                                                                                        color: thisClass.groupcolor[position],
                                                                                        width: 10,
                                                                                      )),
                                                                                  child: Row(children: <Widget>[
                                                                                    new Padding(
                                                                                        padding: EdgeInsets.all(0),
                                                                                        child: Container(
                                                                                          width: _media.width / 22,
                                                                                          height: _media.height / 18,
                                                                                          //I used some padding without fixed width and height
                                                                                          decoration: new BoxDecoration(
                                                                                            shape: BoxShape.circle, // You can use like this way or like the below line
                                                                                            //borderRadius: new BorderRadius.circular(30.0),
                                                                                            color: thisClass.groupcolor[position],
                                                                                          ),
                                                                                          child: FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Padding(
                                                                                                  padding: EdgeInsets.all(5),
                                                                                                  child: Text(
                                                                                                    (position + 1).toString(),
                                                                                                    style: new TextStyle(color: Colors.white),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ))), // You can add a Icon instead of text also, like below.
                                                                                          //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                                                                                        )),
                                                                                    Padding(
                                                                                        padding: EdgeInsets.all(2),
                                                                                        child: Container(
                                                                                          width: _media.width / 6 + _media.width / 18 - _media.width / 16,
                                                                                          height: _media.height / 11,
                                                                                          child: Row(
                                                                                              //    shrinkWrap: true,
                                                                                              // Create a grid with 2 columns. If you change the scrollDirection to
                                                                                              // horizontal, this produces 2 rows.
                                                                                              //  crossAxisCount: 3,
                                                                                              //crossAxisSpacing: 50,
                                                                                              // Generate 100 widgets that display their index in the List.
                                                                                              children: List.generate(thisClass.students[position].length, (index) {
                                                                                            return Padding(
                                                                                                padding: EdgeInsets.all(1),
                                                                                                child: Card(
                                                                                                    //height: _media.height / 44,
                                                                                                    color: drawerBgColor,
                                                                                                    child: FittedBox(
                                                                                                        fit: BoxFit.fill,
                                                                                                        child: Padding(
                                                                                                            padding: EdgeInsets.all(5),
                                                                                                            child: Text(
                                                                                                              thisClass.students[position][index],
                                                                                                              style: new TextStyle(color: Colors.white, fontSize: 17),
                                                                                                            )))));
                                                                                          })),
                                                                                        )),
                                                                                    Container(
                                                                                        decoration: BoxDecoration(
                                                                                            color: Colors.white60,
                                                                                            border: Border.all(
                                                                                              color: thisClass.groupcolor[position],
                                                                                              width: 5,
                                                                                            )),
                                                                                        height: _media.height / 12,
                                                                                        width: (2 * _media.width / 3 - 100) / 4,
                                                                                        child: Stack(children: [
                                                                                          Padding(
                                                                                              padding: EdgeInsets.all(4),
                                                                                              child: Container(
                                                                                                  height: _media.height / 12,
                                                                                                  width: (2 * _media.width / 3 - 100) / 4,
                                                                                                  child: LinearProgressIndicator(
                                                                                                    backgroundColor: Colors.white,
                                                                                                    value: thisClass.scoresac1[position] / 36,
                                                                                                    semanticsLabel: 'Linear progress indicator',
                                                                                                  ))),
                                                                                          Center(
                                                                                              // top: _media.height / 12 / 4,
                                                                                              //left: (2 * _media.width / 3 - 100) / 4 - 60 / 500 * _media.height,
                                                                                              child: Text(thisClass.scoresac1[position].toString() + (thisClass.timeac1[position] > 0 ? (' Stars in ' + (thisClass.timeac1[position] / 60).floor().toString() + ' minutes ' + (thisClass.timeac1[position] % 60).toString() + ' seconds') : (' Stars')), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                                                                          //   Positioned(top: 5, left: (2 * _media.width / 3 - 100) / 4 - 40 / 500 * _media.height, child: Image.asset("assets/images/starpurple.png", height: 15 / 500 * _media.height, width: _media.width * 15 / 500))
                                                                                        ])),
                                                                                    Container(
                                                                                      decoration: BoxDecoration(
                                                                                          color: Colors.white60,
                                                                                          border: Border.all(
                                                                                            color: thisClass.groupcolor[position],
                                                                                            width: 5,
                                                                                          )),
                                                                                      height: _media.height / 12,
                                                                                      width: (2 * _media.width / 3 - 100) / 4,
                                                                                      child: Stack(children: [
                                                                                        Padding(
                                                                                            padding: EdgeInsets.all(4),
                                                                                            child: Container(
                                                                                                height: _media.height / 12,
                                                                                                width: (2 * _media.width / 3 - 100) / 4,
                                                                                                child: LinearProgressIndicator(
                                                                                                  backgroundColor: Colors.white,
                                                                                                  value: thisClass.scoresac2[position] / 18,
                                                                                                  semanticsLabel: 'Linear progress indicator',
                                                                                                ))),
                                                                                        Center(
                                                                                            //top: _media.height / 12 / 4,
                                                                                            //left: (2 * _media.width / 3 - 100) / 4 - 60 / 500 * _media.height,
                                                                                            child: Text(thisClass.scoresac2[position].toString() + (thisClass.timeac2[position] > 0 ? (' Stars in ' + (thisClass.timeac2[position] / 60).floor().toString() + ' minutes ' + (thisClass.timeac2[position] % 60).toString() + ' seconds') : (' Stars')), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                                                                        //   Positioned(top: 5, left: (2 * _media.width / 3 - 100) / 4 - 40 / 500 * _media.height, child: Image.asset("assets/images/starpurple.png", height: 15 / 500 * _media.height, width: _media.width * 15 / 500))
                                                                                      ]),
                                                                                    ),
                                                                                    Container(
                                                                                        decoration: BoxDecoration(
                                                                                            color: Colors.white60,
                                                                                            border: Border.all(
                                                                                              color: thisClass.groupcolor[position],
                                                                                              width: 5,
                                                                                            )),
                                                                                        height: _media.height / 12,
                                                                                        width: (2 * _media.width / 3 - 100) / 4,
                                                                                        child: Stack(children: [
                                                                                          Padding(
                                                                                              padding: EdgeInsets.all(4),
                                                                                              child: Container(
                                                                                                  height: _media.height / 12,
                                                                                                  width: (2 * _media.width / 3 - 100) / 4,
                                                                                                  child: LinearProgressIndicator(
                                                                                                    backgroundColor: Colors.white,
                                                                                                    value: thisClass.scoresac3[position] / 15,
                                                                                                    semanticsLabel: 'Linear progress indicator',
                                                                                                  ))),
                                                                                          Center(
                                                                                              //   top: _media.height / 12 / 4,
                                                                                              // left: (2 * _media.width / 3 - 100) / 4 - 120 / 500 * _media.height,
                                                                                              child: Text(
                                                                                            thisClass.scoresac3[position].toString() + (thisClass.timeac3[position] > 0 ? (' Astrounats in ' + (thisClass.timeac3[position] / 60).floor().toString() + ' minutes ' + (thisClass.timeac3[position] % 60).toString() + ' seconds') : (' Astrounats')),
                                                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                                          )),
                                                                                          //  Positioned(top: 5, left: (2 * _media.width / 3 - 100) / 4 - 40 / 500 * _media.height, child: Image.asset("assets/images/spacer2.png", height: 15 / 500 * _media.height, width: _media.width * 15 / 500)),
                                                                                        ])),
                                                                                    Container(
                                                                                        decoration: BoxDecoration(
                                                                                            color: Colors.white60,
                                                                                            border: Border.all(
                                                                                              color: thisClass.groupcolor[position],
                                                                                              width: 5,
                                                                                            )),
                                                                                        height: _media.height / 12,
                                                                                        width: (2 * _media.width / 3 - 100) / 4,
                                                                                        child: Stack(children: [
                                                                                          Padding(
                                                                                              padding: EdgeInsets.all(4),
                                                                                              child: Container(
                                                                                                  height: _media.height / 12,
                                                                                                  width: (2 * _media.width / 3 - 100) / 4,
                                                                                                  child: LinearProgressIndicator(
                                                                                                    backgroundColor: Colors.white,
                                                                                                    value: thisClass.scoresac4[position] / 15,
                                                                                                    semanticsLabel: 'Linear progress indicator',
                                                                                                  ))),
                                                                                          Center(child: Text(thisClass.scoresac4[position].toString() + (thisClass.timeac4[position] > 0 ? (' Astrounats in ' + (thisClass.timeac4[position] / 60).floor().toString() + ' minutes ' + (thisClass.timeac4[position] % 60).toString() + ' seconds ') : (' Astrounats')), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                                                                          // Positioned(top: 5, left: (2 * _media.width / 3 - 100) / 4 - 40 / 500 * _media.height, child: Image.asset("assets/images/spacer2.png", height: 15 / 500 * _media.height, width: _media.width * 15 / 500))
                                                                                        ])),
                                                                                  ])),
                                                                            ]));
                                                                      })),
                                                        ))
                                                    : Container(
                                                        // alignment: Alignmen,
                                                        decoration:
                                                            new BoxDecoration(
                                                          // You can use like this way or like the below line
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  3.0),
                                                        ),
                                                        height: 2 *
                                                                _media.height /
                                                                3 -
                                                            55,
                                                        // width: _media.width / 6,
                                                        child: Center(
                                                            child: Text(
                                                          'No groups yet\nFor more information, click on the Help button in the top-right of the tool.',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              height: 1.4,
                                                              fontFamily:
                                                                  'RobotoMono',
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ))),
                                              )
                                            ],
                                          )),
                                )
                              : (thisClass.classPage == 3)
                                  ? Flexible(
                                      fit: FlexFit.loose,
                                      child: Consumer<Classroom>(
                                          builder: (context, model, child) =>
                                              Column(
                                                //mainAxisSize: MainAxisSize.min,
                                                //crossAxisAlignment: CrossAxisAlignment.start,
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 55,
                                                    width: _media.width,
                                                    child: AppBar(
                                                      elevation: 4,
                                                      centerTitle: true,
                                                      title: Text(
                                                        'Dashboard for Line Activities',
                                                      ),
                                                      actions: [
                                                        IconButton(
                                                            icon: Icon(
                                                                Icons.help),
                                                            onPressed: () {
                                                              showAlertDialog3(
                                                                  context,
                                                                  'How to use the orchestartion tool?',
                                                                  'First you need to ask your students to login to studentcelloroom.web.app. After they have to put their names, group number and press "join the session".',
                                                                  'After all students joined the session, you can start your session and manage it with the orchestartion features. bon class!');
                                                            })
                                                      ],
                                                      backgroundColor:
                                                          drawerBgColor,
                                                    ),
                                                  ),
                                                  GroupDashboard(
                                                    currentgroupID: 0,
                                                  ),
                                                ],
                                              )),
                                    )
                                  : (thisClass.classPage == 4)
                                      ? Flexible(
                                          fit: FlexFit.loose,
                                          child: Consumer<Classroom>(
                                              builder: (context, model,
                                                      child) =>
                                                  Column(
                                                    //mainAxisSize: MainAxisSize.min,
                                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 55,
                                                        width: _media.width,
                                                        child: AppBar(
                                                          elevation: 4,
                                                          centerTitle: true,
                                                          title: Text(
                                                            'Dashboard for Line Activities',
                                                          ),
                                                          actions: [
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons.help),
                                                                onPressed: () {
                                                                  showAlertDialog3(
                                                                      context,
                                                                      'How to use the orchestartion tool?',
                                                                      'First you need to ask your students to login to studentcelloroom.web.app. After they have to put their names, group number and press "join the session".',
                                                                      'After all students joined the session, you can start your session and manage it with the orchestartion features. bon class!');
                                                                })
                                                          ],
                                                          backgroundColor:
                                                              drawerBgColor,
                                                        ),
                                                      ),
                                                      GroupDashboardSole(
                                                        currentgroupID: 0,
                                                      ),
                                                    ],
                                                  )),
                                        )
                                      : Flexible(
                                          fit: FlexFit.loose,
                                          child: Consumer<Classroom>(
                                              builder: (context, model,
                                                      child) =>
                                                  Column(
                                                    //mainAxisSize: MainAxisSize.min,
                                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 55,
                                                        width: _media.width,
                                                        child: AppBar(
                                                          elevation: 4,
                                                          centerTitle: true,
                                                          title: Text(
                                                            'Dashboard for Line Activities',
                                                          ),
                                                          actions: [
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons.help),
                                                                onPressed: () {
                                                                  showAlertDialog3(
                                                                      context,
                                                                      'How to use the orchestartion tool?',
                                                                      'First you need to ask your students to login to studentcelloroom.web.app. After they have to put their names, group number and press "join the session".',
                                                                      'After all students joined the session, you can start your session and manage it with the orchestartion features. bon class!');
                                                                })
                                                          ],
                                                          backgroundColor:
                                                              drawerBgColor,
                                                        ),
                                                      ),
                                                      GroupDashboardDouble(
                                                        currentgroupID: 0,
                                                      ),
                                                    ],
                                                  )),
                                        ),
                    ],
                  )),
        );
      },
    );
  }
}
