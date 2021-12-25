//import 'dart:ffi'; // For FFI

import 'package:flutter/widgets.dart';

Cellulo cellulox = new Cellulo(0);
Cellulo celluloy = new Cellulo(1);

class Cellulo extends ChangeNotifier {
  int robotID = 0;
  bool colorset = false;
  bool velocityset = false;
  int status;
  static var robots = [];
  double traveledDistance = 0;
  int robot = -1;
  Cellulo(this.robotID);
  List<double> x = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];
  List<double> y = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];
  double prevx = 0.0;
  double prevy = 0.0;
  double theta = 0.0;
  setup() async {
    /*
    print(totalRobots());
    
    Timer timerStatus = new Timer.periodic(new Duration(seconds: 3), (time) {
      cellulox.getconnection().then((val) => {
            cellulox.status = val,
          });
      celluloy.getconnection().then((val) => {
            celluloy.status = val,
          });

      dbRef.child('technicalStatus').push().set(json.encode({
            "groupID": group.id,
            //"acID": group.currentActivity,
            "X": cellulox.status,
            "Y": celluloy.status,
          }));
    });
    // print("thisis the current robot" + _robot.toString());
    // robot = _robot;
    for (var i = 0; i < totalRobots(); i++) {
      int _robot = newRobotfromPool();
      robots.add(_robot);
    }

    cellulox.resetrobot();
    celluloy.resetrobot();
    cellulox.setColor(0, 255, 0, 0, 0);

    celluloy.setColor(0, 0, 255, 0, 0);
    */
  }
}
