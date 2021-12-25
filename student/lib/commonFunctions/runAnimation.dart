import 'package:flutter/material.dart';
import 'dart:async';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:student/model/student.dart';

void runAnimation(String texttoanimate, bool isnext, String nextstring) {
  int value = 0;
  Timer runanimation;

  runanimation = new Timer.periodic(new Duration(milliseconds: 200), (time) {
    value = value + 1;
    if (student.currentActivity == 'Ac1') {
      if (value > texttoanimate.length) {
        runanimation.cancel();
        if (isnext) {
          runanimation =
              new Timer.periodic(new Duration(milliseconds: 100), (time) {
            value = value + 1;

            if (value > nextstring.length) {
              runanimation.cancel();
            } else {
              student.acgame1.tasktext = nextstring.substring(0, value);
              student.acgame1.notifyListeners();
            }
          });
        }
      } else {
        student.acgame1.tasktext = texttoanimate.substring(0, value);
        student.acgame1.notifyListeners();
      }
    }

    if (student.currentActivity == 'Ac2') {
      if (value > texttoanimate.length) {
        runanimation.cancel();
        if (isnext) {
          runanimation =
              new Timer.periodic(new Duration(milliseconds: 100), (time) {
            value = value + 1;

            if (value > nextstring.length) {
              runanimation.cancel();
            } else {
              student.acgame2.tasktext = nextstring.substring(0, value);
              student.acgame2.notifyListeners();
            }
          });
        }
      } else {
        student.acgame2.tasktext = texttoanimate.substring(0, value);
        student.acgame2.notifyListeners();
      }
    }

    if (student.currentActivity == 'Ac3') {
      if (value > texttoanimate.length) {
        runanimation.cancel();
        if (isnext) {
          runanimation =
              new Timer.periodic(new Duration(milliseconds: 100), (time) {
            value = value + 1;

            if (value > nextstring.length) {
              runanimation.cancel();
            } else {
              student.acgame3.tasktext = nextstring.substring(0, value);
              student.acgame3.notifyListeners();
            }
          });
        }
      } else {
        student.acgame3.tasktext = texttoanimate.substring(0, value);
        student.acgame3.notifyListeners();
      }
    }

    if (student.currentActivity == 'Ac4') {
      if (value > texttoanimate.length) {
        runanimation.cancel();
        if (isnext) {
          runanimation =
              new Timer.periodic(new Duration(milliseconds: 100), (time) {
            value = value + 1;

            if (value > nextstring.length) {
              runanimation.cancel();
            } else {
              student.acgame4.tasktext = nextstring.substring(0, value);
              student.acgame4.notifyListeners();
            }
          });
        }
      } else {
        student.acgame4.tasktext = texttoanimate.substring(0, value);
        student.acgame4.notifyListeners();
      }
    }
  });
}
