import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';

Widget nextmissionbutton() {
  return Consumer<Student>(
      builder: (context, model, child) => Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
              width: student.playgroundheight / 4,
              height: student.playgroundheight / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: student.nextmissionbuttoncolor,
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
                        .text("nextmission_button"),
                    style: student.buttontext),
                onPressed: () => {
                  if (!student.showpause && false)
                    {
                      if (student.currentActivity == 'Ac1' &&
                          (student.aclimit == 'Ac4t' ||
                              student.aclimit == 'Ac3t' ||
                              student.aclimit == 'Ac2t'))
                        {
                          student.dbGroupRef.update({
                            'currentActivity': 'Ac2',
                          }),
                        },
                      if (student.currentActivity == 'Ac2' &&
                          (student.aclimit == 'Ac4t' ||
                              student.aclimit == 'Ac3t'))
                        {
                          student.dbGroupRef.update({
                            'currentActivity': 'Ac3',
                          }),
                        },
                      if (student.currentActivity == 'Ac3' &&
                          student.aclimit == 'Ac4t')
                        {
                          student.dbGroupRef.update({
                            'currentActivity': 'Ac4',
                          }),
                        },
                    }
                },
              ))));
}
