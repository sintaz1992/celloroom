import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:student/gameDynamic/Ac5.dart';
import 'dart:async';
import 'package:student/model/student.dart';
import 'package:student/widgets/membersBar.Dart';
import 'package:student/services/app_translations.dart';
import 'package:student/widgets/mapTablet.dart' as mapTablet;
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student/widgets/buttons/nextturn.dart';
import 'package:student/widgets/chat.dart';
import 'package:student/widgets/buttons/startbutton.dart';
import 'package:student/widgets/buttons/nextmission.dart';
import 'package:student/widgets/buttons/trybutton.dart';
import 'package:student/widgets/screenArrow.dart';

class Ac5 extends StatefulWidget {
  Ac5({Key key}) : super(key: key);

  @override
  _Ac5State createState() => _Ac5State();
}

class _Ac5State extends State<Ac5> with TickerProviderStateMixin {
  var elapseTimer = new Stopwatch();
  var timeOutofBorder;

  TextEditingController controllerx = TextEditingController();
  TextEditingController controllery = TextEditingController();

  double screenSizeWidth;
  double screenSizeHeight;
  double h2wscreen = 1.0;
  // Celulo
  bool readytosubmitCellulowtarget = true;

  final _scrollController = ScrollController();
  final _scrollController2 = ScrollController();

//Activity Dependent

  double screenWidth = 500;
  double screenHeight = 500;

  bool formcellulowtargetsubmitVisible = true;

  @override
  void initState() {
    super.initState();

    // initialposition();
    if (student.groupCurrentTurn != 1) {
      student.dbGroupRef.update({
        'CurrentTurn': 1,
      });
    } else {
      student.acgame5.begingame();
    }

    student.dbSessionRef.collection("turnTransition").add({
      "d_group": student.groupname,
      "numAc": 4,
      "numTurn": 0,
      'rolevalue': 6
    });

    if (student.elapseTimer.elapsedMicroseconds < 2) {
      student.elapseTimer.start();
    }
    student.starttimer[4] = student.elapseTimer.elapsedMilliseconds;

    student.acgame5.timerColorButton =
        new Timer.periodic(new Duration(milliseconds: 2000), (time) {
      if (student.acgame5.startButtonColor == Colors.grey) {
        student.acgame5.startButtonColor = Colors.orange;
        //  student.acgame4.notifyListeners();
      } else {
        student.acgame5.startButtonColor = Colors.grey;
        //student.acgame4.notifyListeners();
      }
    });

    elapseTimer.start();

    student.dbSessionRef.collection("activityTransition").add({
      "d_group": student.groupname,
      "numAc": 4,
      "rolevalue": 6,
    });
  }

  @override
  void dispose() {
    elapseTimer.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeWidth = MediaQuery.of(context).size.width;
    screenSizeHeight = MediaQuery.of(context).size.height;
    student.playgroundheight =
        (MediaQuery.of(context).size.width - 50) / (h2wscreen + 1);
    student.playgroundheight =
        (MediaQuery.of(context).size.width - 50) / (h2wscreen + 1);

    // if (student.playgroundheight < 300) student.playgroundheight = 300;
    if (student.playgroundheight > 600) student.playgroundheight = 600;
    if (student.playgroundheight > screenSizeHeight - 90)
      student.playgroundheight = screenSizeHeight - 100;

    student.cellulosize =
        student.playgroundheight * student.initialcellulosize * 0.8 / 500;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.blueGrey,
          title: Text(
              (student.currentActivity == 'Ac5')
                  ? AppTranslations.of(context).text("ac5_appbar")
                  : 'Bring the spaceships back to Earth',
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
                    child: IconButton(
                      icon: const Icon(Icons.sync_problem_rounded),
                      tooltip: 'Report Robot Problem',
                      onPressed: () {
                        showAlertDialogmain(
                            context, 'Change the Cellulos IDs', 'grfg');

                        //
                      },
                    )))
          ],
        ),
        backgroundColor: Colors.white,
        body: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Container(
                    width: screenSizeWidth,
//height: screenSizeWidth * 0.8,
                    child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController2,
                        child: SingleChildScrollView(
                          controller: _scrollController2,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 30 / 500 * student.playgroundheight),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Stack(children: [
                                          mapTablet.Map(),
                                          Positioned(
                                              top: student.playgroundheight / 2,
                                              child: Padding(
                                                  padding: EdgeInsets.all(0.0),
                                                  child: (student.acgame5
                                                          .showinstructionT)
                                                      ? Consumer<Game5>(
                                                          builder: (context,
                                                                  model,
                                                                  child) =>
                                                              Container(
                                                                  width: student
                                                                          .playgroundheight *
                                                                      h2wscreen,
                                                                  // height: 70,
                                                                  child: Column(
                                                                      children: [
                                                                        Container(
                                                                            width: student.playgroundheight *
                                                                                h2wscreen,
                                                                            // height: 70,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: student.reachendV ? Colors.green[500] : Colors.blueGrey),
                                                                            child: Center(
                                                                                child: Padding(
                                                                              padding: EdgeInsets.all(6.0),
                                                                              child: Text(student.acgame5.instructionText, textAlign: TextAlign.center, style: student.titletext),
                                                                            ))),
                                                                        SizedBox(
                                                                            height: 10 /
                                                                                500 *
                                                                                student.playgroundheight),
                                                                      ])))
                                                      : Text(''))),
                                          student.showpause
                                              ? Center(
                                                  child: Icon(Icons.pause,
                                                      size: 100 *
                                                          student
                                                              .playgroundheight /
                                                          500,
                                                      color: Colors.red),
                                                )
                                              : Container()
                                        ])),
                                    SizedBox(width: 20),
                                    Container(
                                        height: student.playgroundheight,
                                        width: student.playgroundheight *
                                            h2wscreen,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width:
                                                      student.playgroundheight *
                                                          h2wscreen,
                                                  child: Row(children: [
                                                    Spacer(),
                                                    Stack(children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  0.0),
                                                          child: Image.asset(
                                                              'assets/images/mapicon.png',
                                                              height: student
                                                                      .playgroundheight *
                                                                  50 /
                                                                  500,
                                                              width: student
                                                                      .playgroundheight *
                                                                  50 /
                                                                  500)),
                                                      Positioned(
                                                          top: student
                                                                  .playgroundheight *
                                                              14 /
                                                              500,
                                                          left: student
                                                                  .playgroundheight *
                                                              25 /
                                                              500,
                                                          child: Text('3',
                                                              style: TextStyle(
                                                                  fontSize: 18 *
                                                                      student
                                                                          .playgroundheight /
                                                                      500)))
                                                    ]),
                                                  ])),
                                              SizedBox(
                                                  height: 15 /
                                                      500 *
                                                      student.playgroundheight),
                                              Container(
                                                width:
                                                    student.playgroundheight *
                                                        h2wscreen,
                                                //  height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: student
                                                        .acgame5.tasktextcolor),
                                                child: Row(children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.all(6.0),
                                                      child: Image.asset(
                                                          'assets/images/manC.png',
                                                          height: student
                                                                  .playgroundheight *
                                                              40 /
                                                              500,
                                                          width: student
                                                                  .playgroundwidth *
                                                              40 /
                                                              500)),
                                                  Container(
                                                    width: student
                                                                .playgroundheight *
                                                            h2wscreen -
                                                        60 /
                                                            500 *
                                                            student
                                                                .playgroundheight *
                                                            h2wscreen,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6.0),
                                                      child: Consumer<Game5>(
                                                          builder: (context,
                                                                  model,
                                                                  child) =>
                                                              Text(
                                                                  student
                                                                      .acgame5
                                                                      .tasktext,
                                                                  style: student
                                                                      .titletext)),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              SizedBox(
                                                  height: 15 /
                                                      500 *
                                                      student.playgroundheight),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: student
                                                              .playgroundheight *
                                                          h2wscreen /
                                                          2,
                                                      child: Center(
                                                        child: RoleBar(
                                                            curTurn: student
                                                                .groupCurrentTurn),
                                                      )),
                                                ],
                                              ),
                                              Spacer(),
                                              Container(
                                                  width:
                                                      student.playgroundheight *
                                                          h2wscreen,
                                                  child: Row(children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: Text('')),
                                                    Spacer(),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: ((!student
                                                                    .reachendV &&
                                                                student.acgame5
                                                                    .trybuttonshow)
                                                            ? trybutton()
                                                            : Text(''))),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.all(0.0),
                                                        child: ((student.groupCurrentTurn <
                                                                    3 &&
                                                                student
                                                                    .reachendV)
                                                            ? nextturnbutton()
                                                            : Text(''))),
                                                  ])),
                                            ])),
                                  ])),
                        ))))));
  }
}
