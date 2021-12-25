import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';

Widget nextturnbutton() {
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
                  .text("nextturn_button"),
              style: student.buttontext,
            ),
            onPressed: () => {
              if (!student.showpause)
                {
                  if (student.groupCurrentTurn <= 2)
                    {
                      student.dbGroupRef.update({
                        'currentActivity': student.currentActivity,
                      }),
                      student.dbGroupRef.update({
                        'CurrentTurn': student.groupCurrentTurn + 1,
                      }),
                      print('turn'),
                      if (student.currentActivity != 'Ac1')
                        {
                          student.dbGroupRef.update({
                            'reachendV': false,
                          }),
                        }
                      else
                        {
                          student.dbGroupRef.update({
                            'reachendX': false,
                            'reachendY': false,
                          }),
                        },
                    }
                }
            },
          )));
}
