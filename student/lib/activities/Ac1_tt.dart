import 'package:flutter/material.dart';

import 'package:student/model/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student/services/app_translations.dart';
import 'package:student/services/application.dart';
import 'package:provider/provider.dart';

/// This is the main method of app, from here execution starts.

/// App widget class
///
///

class Ac1t extends StatefulWidget {
  Ac1t({Key key}) : super(key: key);

  @override
  _Ac1tState createState() => _Ac1tState();
}

class _Ac1tState extends State<Ac1t> with TickerProviderStateMixin {
  //making list of pages needed to pass in IntroViewsFlutter constructor.

  double screenSizeWidth;
  double screenSizeHeight;
  String dropdownValue = 'fa';
  int page = 1;

  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  String donetext = 'To read the rest of story click here.';
  String esctext = 'I have question about the game.';
  int valueofchange = 0;
  void runActivity(BuildContext context) async {
    {
      //application.onLocaleChanged(Locale('fa'));
      {
        page = page + 1;
        if (page == 2)
          setState(() {
            donetext = AppTranslations.of(context).text("act_button_start");
          });
        if (page == 3) {
          if (student.automode == false) {
            setState(() {
              donetext = 'Wait for teacher to start the game...';
            });
          } else {
            student.dbRef.update({
              'readTutAc1t': true,
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
                          print(value.docs.elementAt(i).get('readTutAc1t')),
                          if (value.docs.elementAt(i).get('readTutAc1t') ==
                              true)
                            {
                              valueofchange = valueofchange + 1,
                              print('valuechange' + valueofchange.toString()),
                            }
                        }
                    });

            if (valueofchange < student.numStudents) {
              setState(() {
                donetext = AppTranslations.of(context).text("act_button_wait");
              });
            } else {
              student.dbGroupRef.update({
                'currentActivity': 'Ac1',
              });
              student.dbSessionRef.collection("activityFinished").add({
                "d_group": student.groupname,
                "numAc": 0,
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
    if (student.is4person) {
      student.numStudents = 4;
      student.groupPolicy2 = [
        ['R', 'R', 'T'],
        ['B', 'T', 'B'],
        ['T', 'T', 'T'],
        ['T', 'B', 'R'],
      ];
    }
    student.dbSessionRef.collection("activityTransition").add({
      "d_group": student.groupname,
      "numAc": 0,
      "rolevalue": 6,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (page < 2) {
      donetext = AppTranslations.of(context).text("ac1t_button_continue");
    }
    screenSizeWidth = MediaQuery.of(context).size.width;
    screenSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(AppTranslations.of(context).text("ac1t_appbar"),
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
                                                        ? 'assets/images/master.png'
                                                        : (student.curLang ==
                                                                'fa')
                                                            ? 'assets/images/ac1_1fa.png'
                                                            : 'assets/images/master22f.png',
                                                    //  height: screenSizeHeight*0.8,
                                                    width: screenSizeWidth,
                                                    //height: 500
                                                    // alignment: Alignment.center,
                                                  )
                                                : Image.asset(
                                                    (student.curLang == 'en')
                                                        ? 'assets/images/master2.png'
                                                        : (student.curLang ==
                                                                'fa')
                                                            ? 'assets/images/fa_ac1_2.png'
                                                            : 'assets/images/master22f.png',
                                                    //  height: screenSizeHeight*0.8,
                                                    width: screenSizeWidth,
                                                    // height: 500
                                                    // alignment: Alignment.center,
                                                  )),
                                        Container(
                                            width: screenSizeWidth,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(''),
                                                Spacer(),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0),
                                                    child: Container(
                                                        // height: 70,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                blurRadius: 2,
                                                                offset: Offset(
                                                                    2,
                                                                    4), // Shadow position
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color: Colors.grey),
                                                        width: screenSizeWidth /
                                                            3.5,
                                                        child: FlatButton(
                                                            child: Text(
                                                              donetext,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            onPressed: () =>
                                                                runActivity(
                                                                    context)))),
                                              ],
                                            )),
                                      ])))),
                    )))));
    //Material App
  }
}

/// Home Page of our example app.
