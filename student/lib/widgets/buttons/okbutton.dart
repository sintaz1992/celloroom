import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';

Widget okbutton() {
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
                  .text("ok_button"),
              style: student.buttontext,
            ),
            onPressed: () => {
              student.acgame7.okbuttonshow = false,
              student.acgame7.showline = false,
              student.acgame7.emptygridshow = true,
              student.acgame7.submitbuttonshow = true,
              student.acgame7.allowPaint = true,
              student.acgame7.tasktext = AppTranslations.of(
                      student.navigatorKeygame.currentState.context)
                  .text("instruction_imagineline"),
              student.acgame7.funcstartgame()
            },
          )));
}
