import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/model/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student/services/app_translations.dart';

/// This is the main method of app, from here execution starts.

/// App widget class
///
///

class Ac4t extends StatefulWidget {
  Ac4t({Key key}) : super(key: key);

  @override
  _Ac4tState createState() => _Ac4tState();
}

class _Ac4tState extends State<Ac4t> with TickerProviderStateMixin {
  //making list of pages needed to pass in IntroViewsFlutter constructor.

  double screenSizeWidth;
  double screenSizeHeight;
  int page = 1;
  int valueofchange = 0;
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  String donetext = 'Start the game';
  String esctext = 'I have question about the game.';
  void runActivity() async {
    {
      {
        page = page + 1;

        if (page == 2) {
          if (student.automode == false) {
            setState(() {
              donetext = 'Wait for teacher to start the game...';
            });
          } else {
            student.dbRef.update({
              'readTutAc4t': true,
            });
            await FirebaseFirestore.instance
                .collection('sessions')
                .doc(student.sessionID)
                .collection('groups')
                .doc(student.groupname)
                .collection('members')
                .get()
                .then((value) => {
                      for (int i = 0; i < value.size; i++)
                        {
                          if (value.docs.elementAt(i).get('readTutAc4t') ==
                              true)
                            {
                              valueofchange = valueofchange + 1,
                            }
                        }
                    });

            if (valueofchange < student.numStudents) {
              setState(() {
                donetext = AppTranslations.of(context).text("act_button_wait");
              });
            } else {
              student.dbGroupRef.update({
                'currentActivity': 'Ac4',
              });
              student.dbSessionRef.collection("activityFinished").add({
                "d_group": student.groupname,
                "numAc": 3,
                'rolevalue': student.is4person ? 10 : 6,
              });
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    student.dbSessionRef.collection("activityTransition").add({
      "d_group": student.groupname,
      "numAc": 3,
      'rolevalue': student.role,
    });
    if (student.is4person) {
      student.numStudents = 4;
      student.groupPolicy2 = [
        ['R', 'R', 'T'],
        ['B', 'T', 'B'],
        ['T', 'T', 'T'],
        ['T', 'B', 'R'],
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (page == 1) {
      donetext = AppTranslations.of(context).text("act_button_start");
    }
    screenSizeWidth = MediaQuery.of(context).size.width;
    screenSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(AppTranslations.of(context).text("ac4t_appbar"),
              style: student.appbar),
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController2,
            child: SingleChildScrollView(
                controller: _scrollController2,
                scrollDirection: Axis.horizontal,
                child: Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      child: Consumer<Student>(
                          builder: (context, model, child) => Center(
                              child: Container(
                                  color: Colors.white,
                                  width: screenSizeWidth,
//height: screenSizeWidth * 0.8,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 10),
                                        Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: (page == 1)
                                                ? Image.asset(
                                                    (student.curLang == 'en')
                                                        ? 'assets/images/master44.png'
                                                        : (student.curLang ==
                                                                'fa')
                                                            ? 'assets/images/faac4.png'
                                                            : 'assets/images/master44f.png',
                                                    //  height: screenSizeHeight*0.8,
                                                    width: screenSizeWidth,
                                                    // alignment: Alignment.center,
                                                  )
                                                : Image.asset(
                                                    (student.curLang == 'en')
                                                        ? 'assets/images/master44.png'
                                                        : (student.curLang ==
                                                                'fa')
                                                            ? 'assets/images/faac4.png'
                                                            : 'assets/images/master44f.png',
                                                    //  height: screenSizeHeight*0.8,
                                                    width: screenSizeWidth,
                                                    // alignment: Alignment.center,
                                                  )),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 20.0),
                                            child: Container(
                                                // height: 70,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 2,
                                                        offset: Offset(2,
                                                            4), // Shadow position
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.grey),
                                                width: screenSizeWidth / 3.5,
                                                child: FlatButton(
                                                    // colorBrightness: Colors.blue,
                                                    //color: Colors.lightBlue,
                                                    child: Text(
                                                      donetext,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    onPressed: () =>
                                                        runActivity()))),
                                        /*
                                            (page > 1)
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Container(
                                                        height: 70,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color: Colors
                                                                .orangeAccent),
                                                        width: 200,
                                                        child: FlatButton(
                                                            // colorBrightness: Colors.blue,
                                                            //color: Colors.lightBlue,
                                                            child: Text(
                                                              esctext,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 18),
                                                            ),
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    esctext =
                                                                        'Wait for teacher to answer your question...';
                                                                  }),
                                                                })))
                                                : Text(''),
                                                */
                                      ])))),
                    )))));
    //Material App
  }
}

/// Home Page of our example app.
