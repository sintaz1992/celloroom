import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:provider/provider.dart';
import 'package:student/services/app_translations.dart';

Widget startbutton() {
  return Consumer<Game4>(
      builder: (context, model, child) => (student.acgame4.startgame == false)
          ? Container(
              width: student.playgroundheight / 4,
              height: student.playgroundheight / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: student.acgame4.startButtonColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(2, 4), // Shadow position
                  ),
                ],
              ),
              child: FlatButton(
                child: Text(
                  AppTranslations.of(
                          student.navigatorKeygame.currentState.context)
                      .text("startmission_button"),
                  style: student.buttontext,
                ),
                onPressed: () => {
                  student.acgame4.startgame = true,
                  student.permisMoveV = true,
                  student.acgame4.timerset(),

                  student.acgame4.instructionText = '',
                  student.acgame4.showinstruction = true,
                  student.acgame4.showinstructionT = false,
                  student.acgame4.notifyListeners(),
                  // notifyListeners();
                  if ((student.role != 3 && student.is4person == true) ||
                      (student.is4person == false))
                    {
                      student.acgame4.tasktext = AppTranslations.of(
                              student.navigatorKeygame.currentState.context)
                          .text("instruction_40seconds"),
                    },
                  student.dbGroupRef.collection("gamevents").add({
                    "event": 'startgame',
                    'finishedactivity': student.currentActivity,
                    'turnto': student.groupCurrentTurn,
                    'timepassed': student.elapseTimer.elapsedMilliseconds
                  }),
                  student.acgame4.timerColorButton.cancel(),
                },
              ))
          : Text(''));
}
