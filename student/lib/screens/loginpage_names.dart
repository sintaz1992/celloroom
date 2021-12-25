import 'package:flutter/material.dart';
//import 'package:student/loginpage_robots.dart';

import 'package:flutter/services.dart';
import 'dart:async';

import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/model/student.dart';
import 'package:student/model/Cellulo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:student/screens/loginpage_character.dart';
import 'package:student/services/app_translations.dart';
import 'package:student/services/application.dart';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:ffi/ffi.dart';
import 'dart:convert' show utf8;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controllerrobotred = TextEditingController();
  TextEditingController controllerrobotblue = TextEditingController();
  TextEditingController controllersessionID = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String dropdownValue = 'fa';
  Timer timerEnagagement;
  final teamname = "1";
  List<String> groupnames = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
  ];
  int selectedgroup = -1;
  String rolevalue;

  String nativeMessage = '';
  int robot = -1;
  bool colorset = false;
  bool velocityset = false;
  void initialdatabase() {
    if (!student.is4person) {
      FirebaseFirestore.instance
          .collection('sessions')
          .doc(student.sessionID)
          .collection('groups')
          .doc(student.groupname)
          .set({
        'currentActivity': student.currentActivity,
        'CurrentTurn': 1,
        'permis': false,
        'startGame': student.startGame,
        'scoreX': student.scoreX,
        'scoreY': student.scoreY,
        'scoreV': student.scoreV,
        'reachendX': false,
        'reachendY': false,
        'reachendV': false,
        'isPaused': false,
        'member1name': student.groupmember1name,
        'member2name': student.groupmember2name,
        'member3name': student.groupmember3name,
        'member4name': '',
      });
    } else {
      FirebaseFirestore.instance
          .collection('sessions')
          .doc(student.sessionID)
          .collection('groups')
          .doc(student.groupname)
          .set({
        'currentActivity': student.currentActivity,
        'CurrentTurn': 1,
        'permis': false,
        'startGame': student.startGame,
        'scoreX': student.scoreX,
        'scoreY': student.scoreY,
        'scoreV': student.scoreV,
        'reachendX': false,
        'reachendY': false,
        'reachendV': false,
        'isPaused': false,
        'member1name': student.groupmember1name,
        'member2name': student.groupmember2name,
        'member3name': student.groupmember3name,
        'member4name': student.groupmember4name,
      });
    }

    FirebaseFirestore.instance
        .collection('sessions')
        .doc(student.sessionID)
        .collection('groups')
        .doc(student.groupname)
        .collection("celluloPosition")
        .doc("celluloBlue")
        .collection('position')
        .add({
      "x": student.celluloy.x,
      "y": student.celluloy.y,
    });
    FirebaseFirestore.instance
        .collection('sessions')
        .doc(student.sessionID)
        .collection('groups')
        .doc(student.groupname)
        .collection("celluloPosition")
        .doc("celluloRed")
        .collection('position')
        .add({
      "x": student.celluloy.x,
      "y": student.celluloy.y,
    });
    FirebaseFirestore.instance
        .collection('sessions')
        .doc(student.sessionID)
        .collection('groups')
        .doc(student.groupname)
        .collection("events")
        .add({
      "type": 'start',
    });

    student.dbRef = FirebaseFirestore.instance
        .collection('sessions')
        .doc(student.sessionID)
        .collection('groups')
        .doc(student.groupname)
        .collection('members')
        .doc(student.name);
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
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget joinButton() {
    return InkWell(
      onTap: () {
        if (student.groupname != '' &&
            student.groupname != null &&
            controller1.text != null &&
            controller1.text != '' &&
            controller2.text != null &&
            controller2.text != '' &&
            controller3.text != null &&
            controller3.text != '' &&
            controllerrobotred.text != null &&
            controllerrobotred.text != '' &&
            controllerrobotblue.text != null &&
            controllerrobotblue.text != '') {
          student.iamready = true;
          student.sessionID = '22';
          // cellulox.robotID = int.parse(controllerrobotred.text);
          //celluloy.robotID = int.parse(controllerrobotblue.text);
          student.name = controller1.text;
          student.dbSessionRef = FirebaseFirestore.instance
              .collection('sessions')
              .doc(student.sessionID);
          student.dbGroupRef = FirebaseFirestore.instance
              .collection('sessions')
              .doc(student.sessionID)
              .collection('groups')
              .doc(student.groupname);
          student.setupDatabse();

          student.elapseTimer.start();
          Navigator.pushReplacement(student.keylogin.currentState.context,
              MaterialPageRoute(builder: (context) => LoginPage2()));
        } else {}
        cellulox.robotID = int.parse(controllerrobotred.text);
        celluloy.robotID = int.parse(controllerrobotblue.text);
        cellulox.setup();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.blueGrey[300]),
        child: Text(
          student.iamready
              ? AppTranslations.of(context)
                  .text("loginpage_name_button_waiting")
              : AppTranslations.of(context).text("loginpage_name_button"),
          style: student.titletext,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    student.playgroundheight = (MediaQuery.of(context).size.width - 50) / (2);
    if (student.playgroundheight < 500) student.playgroundheight = 500;
    // student.cellulosize = student.playgroundheight * 60 / 500;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(
              AppTranslations.of(context).text("loginpage_name_appbar_text"),
              style: student.appbar),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blueGrey,
                        border: Border.all()),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                      value: dropdownValue,
                      dropdownColor: Colors.blueGrey,
                      icon: Icon(Icons.language),
                      iconSize: 16,
                      elevation: 16,
                      style: TextStyle(color: Colors.white),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                        application.onLocaleChanged(Locale(dropdownValue));
                      },
                      items: <String>['en', 'fr', 'fa']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ))))
          ],
        ),
        backgroundColor: Colors.white,
        body: Consumer<Student>(
            builder: (context, model, child) => SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Center(
                            child: Column(children: [
                          Row(children: [
                            Image.asset('assets/images/leftdecor.png'),
                            Padding(
                                padding: EdgeInsets.all(60.0),
                                child: Container(
                                    height: 620,
                                    width: 370 / 500 * student.playgroundheight,
                                    color: Colors.blueGrey,
                                    child: Column(children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      width: 300,
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          color: Colors.white),
                                                      child: TextField(
                                                        style:
                                                            student.fieldtext,
                                                        controller: controller1,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: AppTranslations
                                                                    .of(context)
                                                                .text(
                                                                    "loginpage_name_name1"),
                                                            hintStyle: student
                                                                .hinttext),
                                                      ),
                                                    )),
                                              ])),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      width: 300,
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white),
                                                      child: TextField(
                                                        style:
                                                            student.fieldtext,
                                                        controller: controller2,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: AppTranslations
                                                                    .of(context)
                                                                .text(
                                                                    "loginpage_name_name2"),
                                                            hintStyle: student
                                                                .hinttext),
                                                      ),
                                                    )),
                                              ])),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                      width: 300,
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white),
                                                      child: TextField(
                                                        style:
                                                            student.fieldtext,
                                                        controller: controller3,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: AppTranslations
                                                                    .of(context)
                                                                .text(
                                                                    "loginpage_name_name3"),
                                                            hintStyle: student
                                                                .hinttext),
                                                      ),
                                                    )),
                                              ])),
                                      (student.is4person)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 20.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Container(
                                                          width: 300,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white),
                                                          child: TextField(
                                                            style: student
                                                                .fieldtext,
                                                            controller:
                                                                controller4,
                                                            decoration: InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText: AppTranslations.of(
                                                                        context)
                                                                    .text(
                                                                        "loginpage_name_name3"),
                                                                hintStyle: student
                                                                    .hinttext),
                                                          ),
                                                        )),
                                                  ]))
                                          : Text(''),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/cellulored.png',
                                              width: 40,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                  child: TextField(
                                                    style: student.fieldtext,
                                                    controller:
                                                        controllerrobotred,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: AppTranslations
                                                                .of(context)
                                                            .text(
                                                                "loginpage_robotred"),
                                                        hintStyle:
                                                            student.hinttexts),
                                                  ),
                                                )),
                                            Image.asset(
                                              'assets/images/celluloBlue2.png',
                                              width: 40,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: student.fieldtext,
                                                    controller:
                                                        controllerrobotblue,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: AppTranslations
                                                                .of(context)
                                                            .text(
                                                                "loginpage_robotblue"),
                                                        hintStyle:
                                                            student.hinttexts),
                                                  ),
                                                )),
                                          ]),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                //  height: 200,
                                                width: 300,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white,
                                                ),
                                                //  color: Colors.white,
                                                child: Column(children: [
                                                  Container(
                                                    width: 300,
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blueGrey),
                                                    child: Center(
                                                        child: Text(
                                                      AppTranslations.of(
                                                              context)
                                                          .text(
                                                              "loginpage_name_group"),
                                                      style: student.hinttext2,
                                                    )),
                                                  ),
                                                  Container(
                                                      width: 300,
                                                      height: 120,
                                                      child: GridView.count(
                                                        shrinkWrap: true,
                                                        // Create a grid with 2 columns. If you change the scrollDirection to
                                                        // horizontal, this produces 2 rows.
                                                        crossAxisCount: 5,
                                                        //crossAxisSpacing: 50,
                                                        // Generate 100 widgets that display their index in the List.
                                                        children: List.generate(
                                                            groupnames.length,
                                                            (index) {
                                                          return InkWell(
                                                              onTap: () {
                                                                if (controller1.text != null &&
                                                                    controller1
                                                                            .text !=
                                                                        '' &&
                                                                    controller2
                                                                            .text !=
                                                                        null &&
                                                                    controller2
                                                                            .text !=
                                                                        '' &&
                                                                    controller3
                                                                            .text !=
                                                                        null &&
                                                                    controller3
                                                                            .text !=
                                                                        '') {
                                                                  setState(() {
                                                                    selectedgroup =
                                                                        index;
                                                                  });

                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'sessions')
                                                                      .doc(student
                                                                          .sessionID)
                                                                      .collection(
                                                                          'students')
                                                                      .add({
                                                                    'd_group':
                                                                        index +
                                                                            1,
                                                                    'name':
                                                                        controller1
                                                                            .text,
                                                                  });
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'sessions')
                                                                      .doc(student
                                                                          .sessionID)
                                                                      .collection(
                                                                          'students')
                                                                      .add({
                                                                    'd_group':
                                                                        index +
                                                                            1,
                                                                    'name':
                                                                        controller2
                                                                            .text,
                                                                  });
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'sessions')
                                                                      .doc(student
                                                                          .sessionID)
                                                                      .collection(
                                                                          'students')
                                                                      .add({
                                                                    'd_group':
                                                                        index +
                                                                            1,
                                                                    'name':
                                                                        controller3
                                                                            .text,
                                                                  });
                                                                  student.groupname =
                                                                      groupnames[
                                                                          index];
                                                                  student.groupmember1name =
                                                                      controller1
                                                                          .text;
                                                                  student.groupmember2name =
                                                                      controller2
                                                                          .text;
                                                                  student.groupmember3name =
                                                                      controller3
                                                                          .text;
                                                                  if (student
                                                                      .is4person) {
                                                                    student.groupmember4name =
                                                                        controller4
                                                                            .text;
                                                                  }

                                                                  bool first =
                                                                      false;

                                                                  initialdatabase();
                                                                  student.sessionID =
                                                                      '22';
                                                                  // cellulox.robotID = int.parse(controllerrobotred.text);
                                                                  //celluloy.robotID = int.parse(controllerrobotblue.text);
                                                                  student.name =
                                                                      controller1
                                                                          .text;
                                                                  student.dbSessionRef = FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'sessions')
                                                                      .doc(student
                                                                          .sessionID);
                                                                  student.dbGroupRef = FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'sessions')
                                                                      .doc(student
                                                                          .sessionID)
                                                                      .collection(
                                                                          'groups')
                                                                      .doc(student
                                                                          .groupname);
                                                                  student
                                                                      .setupDatabse();
                                                                }
                                                              },
                                                              child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  child: Container(
                                                                      width: 40,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color: (selectedgroup ==
                                                                                index)
                                                                            ? Colors.blueGrey
                                                                            : Colors.blueGrey[300],
                                                                      ),
                                                                      child: Padding(
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Center(
                                                                            child:
                                                                                Text(groupnames[index]),
                                                                          )))));
                                                        }),
                                                      )),
                                                ]))
                                          ]),

                                      /*
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.web_asset),
                                            Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 300,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.white),
                                                  child: TextField(
                                                    style: student.fieldtext,
                                                    controller:
                                                        controllersessionID,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: AppTranslations
                                                                .of(context)
                                                            .text(
                                                                "loginpage_name_session"),
                                                        hintStyle:
                                                            student.hinttext),
                                                  ),
                                                )),
                                          ]),
                                  */
                                      Spacer(),
                                      joinButton(),
                                    ]))),
                            Image.asset('assets/images/rightdecor.png')
                          ]),
                          //  Image.asset('assets/images/mdecor.png'),
                        ])))))));
  }
}
