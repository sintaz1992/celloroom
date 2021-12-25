import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';

Widget submitbutton() {
  return Consumer<Student>(
      builder: (context, model, child) => Container(
          width: student.playgroundheight / 4,
          height: student.playgroundheight / 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: student.nextturnbuttoncolor,
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
              AppTranslations.of(student.navigatorKeygame.currentState.context)
                  .text("submit_button"),
              style: student.buttontext,
            ),
            onPressed: () => {
              if (student.acgame7.score > 100)
                {
                  student.acgame7.linesstatus[student.acgame7.currenttrial] =
                      -1,
                }
              else
                {
                  student.acgame7.linesstatus[student.acgame7.currenttrial] = 1,
                },
              student.acgame7.showsecretlines[student.acgame7.currenttrial] =
                  true,
              {
                if (student.acgame7.currenttrial ==
                    student.acgame7.numtrials - 1)
                  {
                    student.acgame7.reachend(),
                    student.acgame7.timerCelluloPositionPaint.cancel(),
                    student.acgame7.allowPaint = false,
                    student.acgame7.submitbuttonshow = false,
                    student.acgame7.showline = true,
                    student.acgame7.emptygridshow = false,
                  }
                else
                  {
                    student.acgame7.showline = true,
                    student.acgame7.emptygridshow = false,
                    student.acgame7.submitbuttonshow = false,
                    student.acgame7.trybuttonshow = true,
                    student.acgame7.allowPaint = false,
                    //trybuttonshow = true,
                    //startGameV = false;
                    //allowPaint = false;
                  }
              },
              // student.acgame7.allowdraw = false,
              student.acgame7.tasktext = AppTranslations.of(
                      student.navigatorKeygame.currentState.context)
                  .text("instruction_imagineline2"),
            },
          )));
}
