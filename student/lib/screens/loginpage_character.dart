import 'package:flutter/material.dart';
//import 'package:student/loginpage_robots.dart';
import 'dart:async';
import 'package:student/model/Cellulo.dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:student/screens/Game.dart';
import 'package:student/activities/Ac6.dart';
import 'package:student/activities/Ac7.dart';
import 'package:student/activities/Ac8.dart';
import 'package:student/activities/Ac4.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:student/activities/Ac3.dart';
import 'package:student/activities/Ac2.dart';
import 'package:student/activities/Ac1.dart';
import 'package:student/activities/Ac0.dart';
import 'package:student/activities/Ac1_tt.dart';
//import 'package:student/Database.dart';
//import 'package:student/widgets/showAlertDialog.Dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:student/commonFunctions/checkstartgame.dart';

class LoginPage2 extends StatefulWidget {
  LoginPage2({Key key}) : super(key: key);

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controllersessionID = TextEditingController();
  Timer timerEnagagement;
  final teamname = "1";
  String curActivity = 'Ac2';
  String rolevalue;

  @override
  void initState() {
    super.initState();
    initialdatabase();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget nextButton() {
    return InkWell(
      onTap: () {
        //  cellulox.colorset;
        /// cellulox.setcolor2();

        if (!student.clickB && !student.clickR && !student.clickM) {
          // student.currentActivity = curActivity;
          for (int i = 6; i > 0; i--) {
            cellulox.setColor(0, 0, 0, 1, i - 1, 0);
          }
          for (int i = 6; i > 0; i--) {
            celluloy.setColor(0, 0, 0, 1, i - 1, 1);
          }
          Timer runanimation =
              new Timer.periodic(new Duration(milliseconds: 100), (time) {
            cellulox.getrobotx(0);
            cellulox.getroboty(0);
            celluloy.getrobotx(1);
            celluloy.getroboty(1);
          });

          Timer runtechnical =
              new Timer.periodic(new Duration(milliseconds: 3000), (time) {
            cellulox.connectionStatus(0);
            // cellulox.connectionStatus(1);
          });

          student.setupDatabse2();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Game()));
        } else
          showAlertDialogmain(
              context,
              AppTranslations.of(context).text("dialog_char_just"),
              AppTranslations.of(context).text("dialog_char_fill"));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(

            // borderRadius: BorderRadius.all(Radius.circular(0)),
            /*
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            */
            color: Colors.blueGrey[300]),
        child: Text(
          AppTranslations.of(context).text("loginpage_char_button"),
          style: student.titletext,
        ),
      ),
    );
  }

  void initialdatabase() {
    student.clickB = false;
    student.clickM = false;
    student.clickR = false;
    student.clickN = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(AppTranslations.of(context).text("loginpage_char_appbar"),
              style: student.appbar),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Consumer<Student>(
            builder: (context, model, child) => SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.all(60.0),
                                child: Container(
                                    width: 860,
                                    color: Colors.blueGrey,
                                    child: Column(children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Column(children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    if (student.clickR ==
                                                        true) {
                                                      student.role = 1;
                                                      {
                                                        student.dbRef =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'sessions')
                                                                .doc(student
                                                                    .sessionID)
                                                                .collection(
                                                                    'groups')
                                                                .doc(student
                                                                    .groupname)
                                                                .collection(
                                                                    'members')
                                                                .doc(student
                                                                    .name);
                                                        student.dbRef.set({
                                                          'role': student.role,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc1t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc2t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc3t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc4t': false,
                                                        });
                                                        if (student.role == 1) {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'sessions')
                                                              .doc(student
                                                                  .sessionID)
                                                              .collection(
                                                                  'groups')
                                                              .doc(student
                                                                  .groupname)
                                                              .collection(
                                                                  'members')
                                                              .get()
                                                              .then((value) => {
                                                                    if (value
                                                                            .size <
                                                                        2)
                                                                      {}
                                                                    else
                                                                      {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .update({
                                                                          'member1name':
                                                                              student.name,
                                                                        }),
                                                                      }
                                                                  });
                                                        }

                                                        student.clickB = false;
                                                        student.clickM = false;
                                                        student.clickR = false;
                                                        student.clickN = false;
                                                      }
                                                    } else {}
                                                  },
                                                  child: Container(
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/manRtall.png',

                                                                /// height: student.playgroundheight,
                                                                //  width:
                                                                //student.playgroundwidth
                                                              ))))),
                                              Container(
                                                width: 100,
                                                //  height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.blueGrey),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    child: Text(
                                                      student.groupmember1name,
                                                      style: student.titletext,
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              ),
                                            ]),
                                            SizedBox(width: 80),
                                            Column(children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    if (student.clickB ==
                                                        true) {
                                                      student.role = 2;
                                                      {
                                                        student.dbRef =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'sessions')
                                                                .doc(student
                                                                    .sessionID)
                                                                .collection(
                                                                    'groups')
                                                                .doc(student
                                                                    .groupname)
                                                                .collection(
                                                                    'members')
                                                                .doc(student
                                                                    .name);
                                                        student.dbRef.set({
                                                          'role': student.role,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc1t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc2t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc3t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc4t': false,
                                                        });
                                                        if (student.role == 2) {
                                                          student.groupmember2name =
                                                              student.name;

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'sessions')
                                                              .doc(student
                                                                  .sessionID)
                                                              .collection(
                                                                  'groups')
                                                              .doc(student
                                                                  .groupname)
                                                              .collection(
                                                                  'members')
                                                              .get()
                                                              .then((value) => {
                                                                    if (value
                                                                            .size <
                                                                        2)
                                                                      {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .set({
                                                                          'currentActivity':
                                                                              student.currentActivity,
                                                                          'CurrentTurn':
                                                                              1,
                                                                          'startGame':
                                                                              student.startGame,
                                                                          'scoreX':
                                                                              student.scoreX,
                                                                          'scoreY':
                                                                              student.scoreY,
                                                                          'scoreV':
                                                                              student.scoreV,
                                                                          'reachendX':
                                                                              false,
                                                                          'reachendY':
                                                                              false,
                                                                          'reachendV':
                                                                              false,
                                                                          'isPaused':
                                                                              false,
                                                                          'member1name':
                                                                              '',
                                                                          'member2name':
                                                                              student.name,
                                                                          'member3name':
                                                                              '',
                                                                          'member4name':
                                                                              '',
                                                                        }),
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .collection("celluloPosition")
                                                                            .doc("celluloBlue")
                                                                            .collection('position')
                                                                            .add({
                                                                          "x": student
                                                                              .celluloy
                                                                              .x,
                                                                          "y": student
                                                                              .celluloy
                                                                              .y,
                                                                          "studentName":
                                                                              student.name,
                                                                        }),
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .collection("celluloPosition")
                                                                            .doc("celluloRed")
                                                                            .collection('position')
                                                                            .add({
                                                                          "x": student
                                                                              .celluloy
                                                                              .x,
                                                                          "y": student
                                                                              .celluloy
                                                                              .y,
                                                                          "studentName":
                                                                              student.name,
                                                                        }),
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .collection("events")
                                                                            .add({
                                                                          "type":
                                                                              'start',
                                                                        }),
                                                                      }
                                                                    else
                                                                      {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .update({
                                                                          'member2name':
                                                                              student.name,
                                                                        }),
                                                                      }
                                                                  });
                                                        }

                                                        student.clickB = false;
                                                        student.clickM = false;
                                                        student.clickR = false;
                                                        student.clickN = false;
                                                      }
                                                    } else {}
                                                  },
                                                  child: Container(
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/manBtall.png',
                                                              ))))),
                                              Container(
                                                width: 100,
                                                //  height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.blueGrey),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    child: Text(
                                                      student.groupmember2name,
                                                      style: student.titletext,
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              ),
                                            ]),
                                            SizedBox(width: 80),
                                            Column(children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    if (student.clickM ==
                                                        true) {
                                                      student.role = 3;
                                                      {
                                                        student.dbRef =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'sessions')
                                                                .doc(student
                                                                    .sessionID)
                                                                .collection(
                                                                    'groups')
                                                                .doc(student
                                                                    .groupname)
                                                                .collection(
                                                                    'members')
                                                                .doc(student
                                                                    .name);
                                                        student.dbRef.set({
                                                          'role': student.role,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc1t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc2t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc3t': false,
                                                        });
                                                        student.dbRef.update({
                                                          'readTutAc4t': false,
                                                        });
                                                        if (student.role == 3) {
                                                          student.groupmember3name =
                                                              student.name;

                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'sessions')
                                                              .doc(student
                                                                  .sessionID)
                                                              .collection(
                                                                  'groups')
                                                              .doc(student
                                                                  .groupname)
                                                              .collection(
                                                                  'members')
                                                              .get()
                                                              .then((value) => {
                                                                    if (value
                                                                            .size <
                                                                        2)
                                                                      {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .set({
                                                                          'currentActivity':
                                                                              student.currentActivity,
                                                                          'CurrentTurn':
                                                                              1,
                                                                          'startGame':
                                                                              student.startGame,
                                                                          'scoreX':
                                                                              student.scoreX,
                                                                          'scoreY':
                                                                              student.scoreY,
                                                                          'scoreV':
                                                                              student.scoreV,
                                                                          'reachendX':
                                                                              false,
                                                                          'reachendY':
                                                                              false,
                                                                          'reachendV':
                                                                              false,
                                                                          'isPaused':
                                                                              false,
                                                                          'member1name':
                                                                              '',
                                                                          'member2name':
                                                                              '',
                                                                          'member3name':
                                                                              student.name,
                                                                          'member4name':
                                                                              '',
                                                                        }),
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .collection("celluloPosition")
                                                                            .doc("celluloBlue")
                                                                            .collection('position')
                                                                            .add({
                                                                          "x": student
                                                                              .celluloy
                                                                              .x,
                                                                          "y": student
                                                                              .celluloy
                                                                              .y,
                                                                          "studentName":
                                                                              student.name,
                                                                        }),
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .collection("celluloPosition")
                                                                            .doc("celluloRed")
                                                                            .collection('position')
                                                                            .add({
                                                                          "x": student
                                                                              .celluloy
                                                                              .x,
                                                                          "y": student
                                                                              .celluloy
                                                                              .y,
                                                                          "studentName":
                                                                              student.name,
                                                                        }),
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .collection("events")
                                                                            .add({
                                                                          "type":
                                                                              'start',
                                                                        }),
                                                                      }
                                                                    else
                                                                      {
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection('sessions')
                                                                            .doc(student.sessionID)
                                                                            .collection('groups')
                                                                            .doc(student.groupname)
                                                                            .update({
                                                                          'member3name':
                                                                              student.name,
                                                                        }),
                                                                      }
                                                                  });
                                                        }

                                                        student.clickB = false;
                                                        student.clickM = false;
                                                        student.clickR = false;
                                                        student.clickN = false;
                                                      }
                                                    } else {}
                                                  },
                                                  child: Container(
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/manMtall.png',
                                                              ))))),
                                              Container(
                                                width: 100,
                                                //  height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.blueGrey),
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    child: Text(
                                                      student.groupmember3name,
                                                      style: student.titletext,
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              ),
                                            ]),
                                            (student.is4person)
                                                ? SizedBox(width: 80)
                                                : Container(),
                                            (student.is4person)
                                                ? Column(children: <Widget>[
                                                    InkWell(
                                                        onTap: () {
                                                          if (student.clickN ==
                                                              true) {
                                                            student.role = 4;
                                                            {
                                                              student.dbRef = FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'sessions')
                                                                  .doc(student
                                                                      .sessionID)
                                                                  .collection(
                                                                      'groups')
                                                                  .doc(student
                                                                      .groupname)
                                                                  .collection(
                                                                      'members')
                                                                  .doc(student
                                                                      .name);
                                                              student.dbRef
                                                                  .set({
                                                                'role': student
                                                                    .role,
                                                              });
                                                              student.dbRef
                                                                  .update({
                                                                'readTutAc1t':
                                                                    false,
                                                              });
                                                              student.dbRef
                                                                  .update({
                                                                'readTutAc2t':
                                                                    false,
                                                              });
                                                              student.dbRef
                                                                  .update({
                                                                'readTutAc3t':
                                                                    false,
                                                              });
                                                              student.dbRef
                                                                  .update({
                                                                'readTutAc4t':
                                                                    false,
                                                              });
                                                              if (student
                                                                      .role ==
                                                                  4) {
                                                                student.groupmember4name =
                                                                    student
                                                                        .name;

                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'sessions')
                                                                    .doc(student
                                                                        .sessionID)
                                                                    .collection(
                                                                        'groups')
                                                                    .doc(student
                                                                        .groupname)
                                                                    .collection(
                                                                        'members')
                                                                    .get()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.size < 2)
                                                                                {
                                                                                  print('first memebr'),
                                                                                  FirebaseFirestore.instance.collection('sessions').doc(student.sessionID).collection('groups').doc(student.groupname).set({
                                                                                    'currentActivity': student.currentActivity,
                                                                                    'CurrentTurn': 1,
                                                                                    'startGame': student.startGame,
                                                                                    'scoreX': student.scoreX,
                                                                                    'scoreY': student.scoreY,
                                                                                    'scoreV': student.scoreV,
                                                                                    'reachendX': false,
                                                                                    'reachendY': false,
                                                                                    'reachendV': false,
                                                                                    'isPaused': false,
                                                                                    'member1name': '',
                                                                                    'member2name': '',
                                                                                    'member3name': '',
                                                                                    'member4name': student.name
                                                                                  }),
                                                                                  FirebaseFirestore.instance.collection('sessions').doc(student.sessionID).collection('groups').doc(student.groupname).collection("celluloPosition").doc("celluloBlue").collection('position').add({
                                                                                    "x": student.celluloy.x,
                                                                                    "y": student.celluloy.y,
                                                                                    "studentName": student.name,
                                                                                  }),
                                                                                  FirebaseFirestore.instance.collection('sessions').doc(student.sessionID).collection('groups').doc(student.groupname).collection("celluloPosition").doc("celluloRed").collection('position').add({
                                                                                    "x": student.celluloy.x,
                                                                                    "y": student.celluloy.y,
                                                                                    "studentName": student.name,
                                                                                  }),
                                                                                  FirebaseFirestore.instance.collection('sessions').doc(student.sessionID).collection('groups').doc(student.groupname).collection("events").add({
                                                                                    "type": 'start',
                                                                                  }),
                                                                                }
                                                                              else
                                                                                {
                                                                                  FirebaseFirestore.instance.collection('sessions').doc(student.sessionID).collection('groups').doc(student.groupname).update({
                                                                                    'member4name': student.name,
                                                                                  }),
                                                                                }
                                                                            });
                                                              }

                                                              student.clickB =
                                                                  false;
                                                              student.clickM =
                                                                  false;
                                                              student.clickR =
                                                                  false;
                                                              student.clickN =
                                                                  false;
                                                            }
                                                          } else {}
                                                        },
                                                        child: Container(
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                child: Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/manNtall.png',
                                                                    ))))),
                                                    Container(
                                                      width: 100,
                                                      //  height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color:
                                                              Colors.blueGrey),
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          child: Text(
                                                            student
                                                                .groupmember4name,
                                                            style: student
                                                                .titletext,
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                    ),
                                                  ])
                                                : Container(),
                                          ]),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      nextButton()
                                    ])))))))));
  }
}
