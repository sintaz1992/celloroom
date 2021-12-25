import 'package:dashboard/model/Class.dart';
import 'package:flutter/material.dart';
import 'dart:async';

showAlertDialog(BuildContext context, String title, String content,
    String content2, String imagepath1, String imagepath2, String imagepath3) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Image.asset(
                        imagepath3,
                        height: 300,
                        // width: widget._media.width / 9,
                      ),
                    ))),
          ]),
          Spacer(flex: 1),
          Container(
              // width: 500,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black26, spreadRadius: 2)
                ],
                color: Colors.white,
              ),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20),
                  ))),
          Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
                child: Text(
              'Teacher Action',
              textAlign: TextAlign.left,
            )),
          ),
          Container(
              //width: 500,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black26, spreadRadius: 2)
                ],
                color: Colors.white,
              ),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    content2,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20),
                  ))),
          Spacer(flex: 4),
        ],
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        FlatButton(
          color: Colors.grey,
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
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

showAlertDialog2(
    BuildContext context, String title, String content, String content2) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 1),
          Container(
              width: 500,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black26, spreadRadius: 2)
                ],
                color: Colors.white,
              ),
              child: Text(content)),
          Spacer(flex: 1),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                child: Text(
              'Teacher Action',
              textAlign: TextAlign.left,
            )),
          ),
          Container(
              width: 500,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10, color: Colors.black26, spreadRadius: 2)
                ],
                color: Colors.white,
              ),
              child: Text(content2)),
          Spacer(flex: 1),
        ],
      ),
      backgroundColor: Colors.white,
      actions: <Widget>[
        FlatButton(
          color: Colors.grey,
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
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

showAlertDialog3(
    BuildContext context, String title, String content, String content2) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(flex: 1),
              Container(
                  width: 500,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          spreadRadius: 2)
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        content,
                        textAlign: TextAlign.justify,
                      ))),
              Container(height: 25),
              Container(
                  width: 500,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          spreadRadius: 2)
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        content2,
                        textAlign: TextAlign.justify,
                      ))),
              Spacer(flex: 1),
            ],
          )),
      backgroundColor: Colors.white,
      actions: <Widget>[
        FlatButton(
          color: Colors.grey,
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
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

showAlertDialog4(BuildContext context, String title, String content) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 400,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black26,
                          spreadRadius: 2)
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        content,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 24),
                      ))),
            ],
          )),
      backgroundColor: Colors.white,
      actions: <Widget>[
        FlatButton(
          color: Colors.grey,
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            thisClass.popuptimer =
                new Timer.periodic(new Duration(milliseconds: 30000), (time) {
              showAlertDialog4(
                context,
                'Hey',
                'Click here to see your orchestartion tool',
              );

              thisClass.popuptimer.cancel();
            });
            thisClass.shouldishowpopup = true;
            thisClass.dbSessionRef.collection("teacherevents").add({
              "event": 'popupclick',
              "time": thisClass.elapseTimer.elapsedMilliseconds+thisClass.timebefore,
            });
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
