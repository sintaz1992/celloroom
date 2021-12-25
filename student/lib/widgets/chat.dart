import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/styles.dart';
import 'package:student/widgets/message.dart';
import 'package:student/commonFunctions/groupnames.dart';
import 'package:flutter/services.dart';
import 'package:student/widgets/showAlertDialog.Dart';
import 'package:flutter/scheduler.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';
import 'package:student/gameDynamic/Ac4.dart';

class Chat extends StatefulWidget {
  final int id;
  Chat({Key key, this.id}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  List<String> names = ['1', '2', '3', '4', '5', '6', '7'];
  int selected = 0;
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent:
            AppTranslations.of(student.navigatorKeygame.currentState.context)
                .text("chat_main"),
        messageType: "receiver"),
  ];
  String hintText =
      AppTranslations.of(student.navigatorKeygame.currentState.context)
          .text("chat_move");
  void initState() {
    super.initState();

    // dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    //dbRef.child('students').child(student.id).child('currentActivity').set("Ac1");
    // elapseTimer.start();
    _focusNode1.addListener(() {});
  }

  @override
  void dispose() {
    _focusNode1.dispose();

    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    print(event.logicalKey);
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        {
          if (0 < int.parse(controller.text) &&
              int.parse(controller.text) < 8) {
            setState(() {
              messages.add(ChatMessage(
                  messageContent: AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("chat_move2") +
                      controller.text,
                  messageType: "receiver"));
              if (widget.id == 1) {
                student.dbGroupRef.collection("cellulowtarget").add({
                  "x": int.parse(controller.text),
                  "y": student.acgame4.sety,
                  "studentName": student.name,
                  'timepassed': student.elapseTimer.elapsedMilliseconds,
                });
                student.dbGroupRef.collection("messagextarget").add({
                  "message": AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("chat_move") +
                      controller.text,
                  "studentName": student.role,
                  'timepassed': student.elapseTimer.elapsedMilliseconds
                });
              } else {
                student.dbGroupRef.collection("cellulowtarget").add({
                  "x": student.acgame4.setx,
                  "y": int.parse(controller.text),
                  "studentName": student.role,
                  'timepassed': student.elapseTimer.elapsedMilliseconds,
                });
                student.dbGroupRef.collection("messageytarget").add({
                  "message": AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("chat_move") +
                      controller.text,
                  "studentName": student.role,
                  'timepassed': student.elapseTimer.elapsedMilliseconds
                });
              }
            });

            SchedulerBinding.instance.addPostFrameCallback((_) {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            });
          } else {
            showAlertDialog(
                    student.navigatorKeygame.currentState.context,
                    'Instructions',
                    AppTranslations.of(
                            student.navigatorKeygame.currentState.context)
                        .text("chat_instructions"))
                .then(student.isAlertShown = false);
          }
          controller.text = '';

          // This will only print useful information in debug mode.
          //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';

        }
      }
    });
  }

  Widget build(BuildContext context) {
    return Consumer<Game4>(
        builder: (context, model, child) => Container(
            height: (widget.id != 3)
                ? 305 / 500 * student.playgroundheight
                : 230 / 500 * student.playgroundheight,
            child: Column(children: [
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  (widget.id == 1)
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Image.asset(
                              student.groupCurrentTurn == 3
                                  ? "assets/images/manM.png"
                                  : "assets/images/manR.png",
                              height: student.cellulosize / 2,
                              width: student.cellulosize / 2))
                      : ((widget.id == 2)
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Image.asset(
                                  student.groupCurrentTurn == 2
                                      ? "assets/images/manM.png"
                                      : "assets/images/manB.png",
                                  height: student.cellulosize / 2,
                                  width: student.cellulosize / 2))
                          : Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Image.asset(
                                  student.groupCurrentTurn == 1
                                      ? "assets/images/manM.png"
                                      : student.groupCurrentTurn == 2
                                          ? "assets/images/manB.png"
                                          : "assets/images/manR.png",
                                  height: student.cellulosize / 2,
                                  width: student.cellulosize / 2))),
                  (widget.id == 1)
                      ? Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(capitanr(), style: titletext))
                      : ((widget.id == 2)
                          ? Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(capitanb(), style: titletext),
                            )
                          : Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(capitanm(), style: titletext)))
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                (widget.id == 1 || widget.id == 2)
                    ? Container(
                        height: 170 / 500 * student.playgroundheight,
                        color: Colors.white,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: _scrollController,
                          itemCount: messages.length,
                          shrinkWrap: true,

                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          //  physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                decoration: BoxDecoration(color: Colors.white),
                                //color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: (widget.id == 1)
                                              ? Colors.red[200]
                                              : Colors.blue[200],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                              messages[index].messageContent),
                                        ))));
                          },
                        ),
                      )
                    : ((student.groupPolicy[student.role - 1]
                                [student.groupCurrentTurn - 1] ==
                            'B')
                        ? Container(
                            height: 170 / 500 * student.playgroundheight,
                            color: Colors.white,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _scrollController,
                              itemCount: (student.acgame4.messagesy.length == 1)
                                  ? 1
                                  : 2,
                              shrinkWrap: true,

                              padding: EdgeInsets.only(top: 0, bottom: 0),
                              //  physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    //color: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: student.acgame4.chatcolor,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text((index == 0)
                                                  ? student
                                                      .acgame4
                                                      .messagesy[index]
                                                      .messageContent
                                                  : student
                                                      .acgame4
                                                      .messagesy[student
                                                              .acgame4
                                                              .messagesy
                                                              .length -
                                                          1]
                                                      .messageContent),
                                            ))));
                              },
                            ),
                          )
                        : Container(
                            height: 170 / 500 * student.playgroundheight,
                            color: Colors.white,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              controller: _scrollController,
                              itemCount: (student.acgame4.messagesx.length == 1)
                                  ? 1
                                  : 2,
                              shrinkWrap: true,

                              padding: EdgeInsets.only(top: 0, bottom: 0),
                              //  physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    //color: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: student.acgame4.chatcolor,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text((index == 0)
                                                  ? student
                                                      .acgame4
                                                      .messagesx[index]
                                                      .messageContent
                                                  : student
                                                      .acgame4
                                                      .messagesx[student
                                                              .acgame4
                                                              .messagesx
                                                              .length -
                                                          1]
                                                      .messageContent),
                                            ))));
                              },
                            ),
                          )),
                (widget.id == 1 || widget.id == 2)
                    ?

                    /*
                    Container(
                        padding: EdgeInsets.only(
                            bottom: 5 / 500 * student.playgroundheight,
                            top: 5 / 500 * student.playgroundheight),

                        // height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                width: 150 / 500 * student.playgroundheight,
                                height: 30 / 500 * student.playgroundheight,
                                child: TextField(
                                  focusNode: _focusNode1,
                                  onSubmitted: (_) => {
                                    {
                                      if (0 < int.parse(controller.text) &&
                                          int.parse(controller.text) < 8)
                                        {
                                          setState(() {
                                            messages.add(ChatMessage(
                                                messageContent:
                                                    AppTranslations.of(student
                                                                .navigatorKeygame
                                                                .currentState
                                                                .context)
                                                            .text(
                                                                "chat_move2") +
                                                        controller.text,
                                                messageType: "receiver"));
                                            if (widget.id == 1) {
                                              student.dbGroupRef
                                                  .collection("cellulowtarget")
                                                  .add({
                                                "x": int.parse(controller.text),
                                                "y": student.acgame4.sety,
                                                "studentName": student.name,
                                                'timepassed': student
                                                    .elapseTimer
                                                    .elapsedMilliseconds,
                                              });
                                              student.dbGroupRef
                                                  .collection("messagextarget")
                                                  .add({
                                                "message": AppTranslations.of(
                                                            student
                                                                .navigatorKeygame
                                                                .currentState
                                                                .context)
                                                        .text("chat_move") +
                                                    controller.text,
                                                "studentName": student.role,
                                                'timepassed': student
                                                    .elapseTimer
                                                    .elapsedMilliseconds
                                              });
                                            } else {
                                              student.dbGroupRef
                                                  .collection("cellulowtarget")
                                                  .add({
                                                "x": student.acgame4.setx,
                                                "y": int.parse(controller.text),
                                                "studentName": student.role,
                                                'timepassed': student
                                                    .elapseTimer
                                                    .elapsedMilliseconds,
                                              });
                                              student.dbGroupRef
                                                  .collection("messageytarget")
                                                  .add({
                                                "message": AppTranslations.of(
                                                            student
                                                                .navigatorKeygame
                                                                .currentState
                                                                .context)
                                                        .text("chat_move") +
                                                    controller.text,
                                                "studentName": student.role,
                                                'timepassed': student
                                                    .elapseTimer
                                                    .elapsedMilliseconds
                                              });
                                            }
                                          }),
                                          SchedulerBinding.instance
                                              .addPostFrameCallback((_) {
                                            _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeOut,
                                            );
                                          })
                                        }
                                      else
                                        {
                                          showAlertDialog(
                                                  student.navigatorKeygame
                                                      .currentState.context,
                                                  'Instructions',
                                                  AppTranslations.of(student
                                                          .navigatorKeygame
                                                          .currentState
                                                          .context)
                                                      .text(
                                                          "chat_instructions"))
                                              .then(
                                                  student.isAlertShown = false),
                                        },
                                      controller.text = '',
                                      _focusNode1.requestFocus(),
                                      // This will only print useful information in debug mode.
                                      //   _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
                                    }
                                  },
                                  onTap: () {
                                    print('sxs');
                                  },
                                  controller: controller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      hintText: AppTranslations.of(student
                                              .navigatorKeygame
                                              .currentState
                                              .context)
                                          .text("chat_move"),
                                      hintStyle: TextStyle(
                                          color: Colors.black54, fontSize: 12),
                                      border: InputBorder.none),
                                )),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.send),
                              alignment: Alignment.center,
                              onPressed: () {
                                //   print(student.acgame4.messagesx[0].messageContent);
                                if (0 < int.parse(controller.text) &&
                                    int.parse(controller.text) < 8) {
                                  setState(() {
                                    messages.add(ChatMessage(
                                        messageContent: AppTranslations.of(
                                                    student.navigatorKeygame
                                                        .currentState.context)
                                                .text("chat_move2") +
                                            controller.text,
                                        messageType: "receiver"));
                                    if (widget.id == 1) {
                                      student.dbGroupRef
                                          .collection("cellulowtarget")
                                          .add({
                                        "x": int.parse(controller.text),
                                        "y": student.acgame4.sety,
                                        "studentName": student.name,
                                        'timepassed': student
                                            .elapseTimer.elapsedMilliseconds,
                                      });
                                      student.dbGroupRef
                                          .collection("messagextarget")
                                          .add({
                                        "message": AppTranslations.of(student
                                                    .navigatorKeygame
                                                    .currentState
                                                    .context)
                                                .text("chat_move") +
                                            controller.text,
                                        "studentName": student.role,
                                        'timepassed': student
                                            .elapseTimer.elapsedMilliseconds
                                      });
                                    } else {
                                      student.dbGroupRef
                                          .collection("cellulowtarget")
                                          .add({
                                        "x": student.acgame4.setx,
                                        "y": int.parse(controller.text),
                                        "studentName": student.role,
                                        'timepassed': student
                                            .elapseTimer.elapsedMilliseconds,
                                      });
                                      student.dbGroupRef
                                          .collection("messageytarget")
                                          .add({
                                        "message": AppTranslations.of(student
                                                    .navigatorKeygame
                                                    .currentState
                                                    .context)
                                                .text("chat_move") +
                                            controller.text,
                                        "studentName": student.role,
                                        'timepassed': student
                                            .elapseTimer.elapsedMilliseconds
                                      });
                                    }
                                  });

                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                    );
                                  });
                                } else {
                                  showAlertDialog(
                                          student.navigatorKeygame.currentState
                                              .context,
                                          'Instructions',
                                          AppTranslations.of(student
                                                  .navigatorKeygame
                                                  .currentState
                                                  .context)
                                              .text("chat_instructions"))
                                      .then(student.isAlertShown = false);
                                }
                                controller.text = '';
                              },
                            ),
                          ],
                        ),
                      ) */

                    Center(
                        child: Container(
                            width: 200 / 500 * student.playgroundheight,
                            height: 100 / 500 * student.playgroundheight,
                            child: GridView.count(
                              shrinkWrap: true,
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this produces 2 rows.
                              crossAxisCount: 4,
                              //crossAxisSpacing: 50,
                              // Generate 100 widgets that display their index in the List.
                              children: List.generate(names.length, (index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                      });

                                      if (true) {
                                        setState(() {
                                          messages.add(ChatMessage(
                                              messageContent:
                                                  AppTranslations.of(student
                                                              .navigatorKeygame
                                                              .currentState
                                                              .context)
                                                          .text("chat_move2") +
                                                      (selected + 1).toString(),
                                              messageType: "receiver"));
                                          if (widget.id == 1) {
                                            student.dbGroupRef
                                                .collection("cellulowtarget")
                                                .add({
                                              "x": selected + 1,
                                              "y": student.acgame4.sety,
                                              "studentName": student.name,
                                              'timepassed': student.elapseTimer
                                                  .elapsedMilliseconds,
                                            });
                                            student.dbGroupRef
                                                .collection("messagextarget")
                                                .add({
                                              "message": AppTranslations.of(
                                                          student
                                                              .navigatorKeygame
                                                              .currentState
                                                              .context)
                                                      .text("chat_move") +
                                                  (selected + 1).toString(),
                                              "studentName": student.role,
                                              'timepassed': student.elapseTimer
                                                  .elapsedMilliseconds
                                            });
                                          } else {
                                            student.dbGroupRef
                                                .collection("cellulowtarget")
                                                .add({
                                              "x": student.acgame4.setx,
                                              "y": selected + 1,
                                              "studentName": student.role,
                                              'timepassed': student.elapseTimer
                                                  .elapsedMilliseconds,
                                            });
                                            student.dbGroupRef
                                                .collection("messageytarget")
                                                .add({
                                              "message": AppTranslations.of(
                                                          student
                                                              .navigatorKeygame
                                                              .currentState
                                                              .context)
                                                      .text("chat_move") +
                                                  (selected + 1).toString(),
                                              "studentName": student.role,
                                              'timepassed': student.elapseTimer
                                                  .elapsedMilliseconds
                                            });
                                          }
                                        });

                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        });
                                      } else {
                                        showAlertDialog(
                                                student.navigatorKeygame
                                                    .currentState.context,
                                                'Instructions',
                                                AppTranslations.of(student
                                                        .navigatorKeygame
                                                        .currentState
                                                        .context)
                                                    .text("chat_instructions"))
                                            .then(student.isAlertShown = false);
                                      }
                                      controller.text = '';
                                    },
                                    child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Container(
                                            width: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: (selected == index)
                                                  ? ((widget.id == 1)
                                                      ? Colors.redAccent
                                                      : Colors.blueAccent)
                                                  : Colors.blueGrey[300],
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Center(
                                                  child: Text(names[index]),
                                                )))));
                              }),
                            )))
                    : Text(''),
              ]),
            ])));
  }
}
