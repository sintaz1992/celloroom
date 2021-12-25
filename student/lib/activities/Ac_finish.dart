import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student/commonFunctions/playaudio.dart';
import 'package:provider/provider.dart';
import 'package:student/services/app_translations.dart';

/// This is the main method of app, from here execution starts.

/// App widget class
///
///

class Acf extends StatefulWidget {
  Acf({Key key}) : super(key: key);

  @override
  _AcfState createState() => _AcfState();
}

class _AcfState extends State<Acf> with TickerProviderStateMixin {
  //making list of pages needed to pass in IntroViewsFlutter constructor.

  double screenSizeWidth;
  double screenSizeHeight;
  int page = 1;
  int valueofchange = 0;
  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();
  String donetext = 'Are you ready to start the game? Click here';
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
              'readTutAcf': true,
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
                          if (value.docs.elementAt(i).get('readTutAcf') == true)
                            {
                              valueofchange = valueofchange + 1,
                            }
                        }
                    });

            if (valueofchange < 3) {
              setState(() {
                donetext = 'Waiting for your friends to get ready...';
              });
            } else {
              student.dbGroupRef.update({
                'currentActivity': 'Ac4',
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
    // playHandler('assets/images/win.mp3');
  }

  @override
  Widget build(BuildContext context) {
    screenSizeWidth = MediaQuery.of(context).size.width;
    screenSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(AppTranslations.of(context).text("congratulation"),
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
                                  child: Column(children: [
                                    SizedBox(height: 10),
                                    Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: (page == 1)
                                            ? Image.asset(
                                                (student.curLang == 'en')
                                                    ? 'assets/images/master_ff.png'
                                                    : (student.curLang == 'fa')
                                                        ? 'assets/images/finalfa.png'
                                                        : 'assets/images/master_ff.png',
                                                //  height: screenSizeHeight*0.8,
                                                width: screenSizeWidth,
                                                // alignment: Alignment.center,
                                              )
                                            : Image.asset(
                                                (student.curLang == 'en')
                                                    ? 'assets/images/master_f.png'
                                                    : 'assets/images/master_ff.png',
                                                //  height: screenSizeHeight*0.8,
                                                width: screenSizeWidth / 2,
                                                // alignment: Alignment.center,
                                              )),

                                    //  Sparkler(),
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
