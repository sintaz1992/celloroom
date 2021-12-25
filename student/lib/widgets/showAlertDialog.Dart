import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/model/student.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import  'package:student/model/Cellulo.dart';
import 'package:student/services/app_translations.dart';

showAlertDialogAc(BuildContext context, String title, String content) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: Colors.white,
      actions: <Widget>[
        FlatButton(
          color: Colors.blueGrey,
          child: Text('Ok'),
          onPressed: () {
            student.isAlertShown = false;
            Navigator.of(student.navigatorKeygame.currentState.context,
                    rootNavigator: true)
                .pop();
          },
        )
      ]);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog(BuildContext context, String title, String content) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: Colors.white,
      actions: <Widget>[
        FlatButton(
          color: Colors.blueGrey,
          child: Text('Ok'),
          onPressed: () {
            student.isAlertShown = false;
            Navigator.of(student.navigatorKeygame.currentState.context,
                    rootNavigator: true)
                .pop();
          },
        )
      ]);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showPauseDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text('Pay Attention'),
    content: Text('Wait until teacher continues the activity'),
    backgroundColor: Colors.white,
  );
  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      final provider = Provider.of<Student>(context);
      if (provider.ispaused == false) {
        Navigator.of(context,
                rootNavigator: true)
            .pop();

        print(student.navigatorKeygame.currentState.context);
      }
      // Navigator.currentState.pop();
      return alert;
    },
  );
}

showAlertDialogmain(BuildContext context, String title, String content) {
  // set up the button
Timer crashtimer;
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content:
      Container(
        height: 200,
child:         Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/cellulored.png',
                                              width: 40,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                  child: TextField(
                                                    style: student.fieldtext,
                                                    controller:
                                                        student.controlleridx,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: AppTranslations
                                                                .of(context)
                                                            .text(
                                                                "loginpage_robotred"),
                                                        hintStyle:
                                                            student.hinttexts),
                                                  ),
                                                )),
                                            Image.asset(
                                              'assets/images/celluloBlue2.png',
                                              width: 40,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 100,
                                                  padding: EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: student.fieldtext,
                                                    controller:
                                                        student.controlleridy,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: AppTranslations
                                                                .of(context)
                                                            .text(
                                                                "loginpage_robotblue"),
                                                        hintStyle:
                                                            student.hinttexts),
                                                  ),
                                                )),
                                          ])),
  
      backgroundColor: Colors.white,
      actions: <Widget>[
        Row(children:[
FlatButton(
          color: Colors.blueGrey,
          child: Text('Disconnect the old Robots'),
          onPressed: () {

     
     
     cellulox.disetup();

  
        
          },
        ),

       
Container (width:30),
        FlatButton(
          color: Colors.blueGrey,
          child: Text('Connect the new robots'),
          onPressed: () {

     
     
    
print('fdfdedsef');
print(student.controlleridx.text);
print(int.parse(student.controlleridx.text));
           cellulox.robotID = int.parse(student.controlleridx.text);
                            celluloy.robotID = int.parse(student.controlleridy.text);
                             cellulox.setup();            
                

            Navigator.of(context, rootNavigator: true).pop();

    
    
          },
        )




        ])
        
      ]);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
