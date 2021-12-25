import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';

Widget trybutton() {
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
                AppTranslations.of(
                        student.navigatorKeygame.currentState.context)
                    .text("try_button"),
                style: student.buttontext,
              ),
              onPressed: () => {
                    if (student.currentActivity == 'Ac5')
                      student.acgame5.newtrial(),
                    if (student.currentActivity == 'Ac7')
                      student.acgame7.newtrial(),
                    if (student.currentActivity == 'Ac9')
                      student.acgame9.newtrial(),
                  })));
}
