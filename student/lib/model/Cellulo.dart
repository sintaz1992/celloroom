//import 'dart:ffi'; // For FFI
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:ffi/ffi.dart';
import 'dart:convert' show utf8;
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:student/commonFunctions/poserocks.dart';
import 'dart:async';
import 'package:student/model/student.dart';

List<String> celluloList = [
  "00:06:66:E7:8A:CE",
  "00:06:66:74:40:DC",
  "00:06:66:74:40:FF",
  "00:06:66:D2:CF:97",
  "00:06:66:E7:8A:D9",
  "00:06:66:E7:8A:D1",
  "00:06:66:74:40:D3",
  "00:06:66:E7:8A:D8",
  "00:06:66:D2:CF:91",
  "00:06:66:E7:8A:E6",
  "00:06:66:D2:CF:85",
  "00:06:66:D2:CF:82",
  "00:06:66:D2:CF:7B",
  "00:06:66:E7:8A:CD",
  "00:06:66:E7:8A:E5",
  "00:06:66:74:3E:82",
  "00:06:66:74:3E:93",
  "00:06:66:D2:CF:97",
  "00:06:66:D2:CF:83",
  "00:06:66:D2:CF:8B",
  "00:06:66:74:40:D3",
  "00:06:66:74:43:00",
  "00:06:66:74:3E:82",
  "00:06:66:E7:8A:E5",
  "00:06:66:74:41:4C",
  "00:06:66:E7:8A:CE",
  "00:06:66:D2:CF:90",
  "00:06:66:D2:CF:8B",
  "00:06:66:E7:8A:D1",
  "00:06:66:E7:8A:D8",
  "00:06:66:E7:8A:E1",
  "00:06:66:D2:CF:99",
  "00:06:66:74:40:FF",
  "00:06:66:74:41:4C",
  "00:06:66:E7:8A:DE",
  "00:06:66:74:40:DC",
  "00:06:66:D2:CF:85",
  "00:06:66:D2:CF:99",
  "00:06:66:D2:CF:7B",
  "00:06:66:E7:8E:65",
  "00:06:66:E7:8E:6A",
  "00:06:66:E7:8E:E5",
  "00:06:66:E7:8A:44",
  "00:06:66:E7:8A:D6",
  "00:06:66:E7:8E:B2",
  "00:06:66:E7:8A:DE",
  "00:06:66:40:DB",
  "00:06:66:41:03"
      "00:06:66:E7:8A:C9"
      "00:06:66:40:D3"
      "00:06:66:D2:CF:8B"
      "00:06:66:E7:8A:41"
      "00:06:66:E7:8A:E6"
      "00:06:66:E7:8A:43"
      "00:06:66:48:A7"
      "00:06:66:3E:7E"
      "00:06:66:E7:8A:CA"
      "00:06:66:3E:82"
      "00:06:66:E7:8A:E2"
      "00:06:66:8A:E7"
      "00:06:66:46:58"
      "00:06:66:D2:CF:90"
      "00:06:66:E7:8E:6B"
      "00:06:66:8E:BE"
      "00:06:66:E7:91:BC"
      "00:06:66:E7:8A:E8"
      "00:06:66:43:01"
      "00:06:66:E7:8A:D8"
      "00:06:66:40:DC"
      "00:06:66:D2:CF:97"
      "00:06:66:43:00"
      "00:06:66:40:EE",
  "00:06:66:41:4C"
];
Cellulo cellulox = new Cellulo(0);
Cellulo celluloy = new Cellulo(1);
void colorRobots() {
  if (student.currentActivity == 'Ac1') {
    for (int i = 0; i < student.scoreX; i++) {
      cellulox.setColor(0, 255, 0, 1, i, 0);
    }
    for (int i = 0; i < student.scoreY; i++) {
      celluloy.setColor(0, 0, 255, 1, i, 1);
    }
  }
  if (student.currentActivity == 'Ac2') {
    for (int i = 0; i < student.scoreV; i++) {
      cellulox.setColor(0, 255, 0, 1, i, 0);
    }
    for (int i = 0; i < student.scoreV; i++) {
      celluloy.setColor(0, 0, 255, 1, i, 1);
    }
  }
  if (student.currentActivity == 'Ac3') {
    var reward = 0;
    //print(student.acgame4.spacemanVisible);
    for (int i = 0; i < student.acgame3.spacemanVisible.length; i++) {
      if (student.acgame3.spacemanVisible[i] == 1) reward = reward + 1;
    }
    for (int i = 0; i < reward; i++) {
      cellulox.setColor(0, 255, 0, 1, i, 0);
    }
    for (int i = 0; i < reward; i++) {
      celluloy.setColor(0, 0, 255, 1, i, 1);
    }
  }
  if (student.currentActivity == 'Ac4') {
    var reward = 0;
    //print(student.acgame4.spacemanVisible);
    for (int i = 0; i < student.acgame4.spacemanVisible.length; i++) {
      if (student.acgame4.spacemanVisible[i] == 1) reward = reward + 1;
    }
    for (int i = 0; i < reward; i++) {
      cellulox.setColor(0, 255, 0, 1, i, 0);
    }
    for (int i = 0; i < reward; i++) {
      celluloy.setColor(0, 0, 255, 1, i, 1);
    }
  }
}

class Cellulo extends ChangeNotifier {
  int robotID = 0;
  double end = 0.95;
  static const platformMethodChannel =
      const MethodChannel('heartbeat.fritz.ai/native');
  bool colorset = false;
  bool velocityset = false;
  int status;
  double celluloSize = 76;
  static var robots = [];
  double mapSizeWidthfull = 860;
  double mapSizeHeightfull = 860;
  double traveledDistance = 0;
  int robot = -1;
  Cellulo(this.robotID);
  double x = 0.0;
  double y = 0.0;
  double prevx = 0.0;
  double prevy = 0.0;
  double treshold = 100;
  double theta = 0.0;
  Future<Null> getrobotx(int id) async {
    if (student.currentActivity == 'Ac1' ||
        student.currentActivity == 'Ac2' ||
        student.currentActivity == 'Ac3' ||
        student.currentActivity == 'Ac4' ||
        student.currentActivity == 'Ac9') {
      if (student.permisMoveX) {
        if (id == 0) {
          if ((getX(cellulox.robot) - treshold - celluloSize / 2) /
                  mapSizeWidth >
              end) {
            student.cellulox.x = end - student.initialcellulosize / 2 / 500;
          } else if ((getX(cellulox.robot) - treshold - celluloSize / 2) /
                  mapSizeWidth <
              0) {
            student.cellulox.x = 0;
          } else
            student.cellulox.x =
                (getX(cellulox.robot) - treshold - celluloSize / 2) /
                    mapSizeWidth;
        }
        if (id == 1) {
          if ((getX(celluloy.robot) - treshold - celluloSize / 2) /
                  mapSizeWidth >
              end) {
            student.celluloy.x = end - student.initialcellulosize / 2 / 500;
          } else if ((getX(celluloy.robot) - treshold - celluloSize / 2) /
                  mapSizeWidth <
              0) {
            student.celluloy.x = 0;
          } else
            student.celluloy.x =
                (getX(celluloy.robot) - treshold - celluloSize / 2) /
                    mapSizeWidth;
        }
        student.notifyListeners();
      }
    } else {
      if (student.permisMoveX) {
        if (id == 0) {
          if ((getX(cellulox.robot) - celluloSize / 2) / mapSizeWidthfull >
              end) {
            student.cellulox.x = end - student.initialcellulosize / 2 / 500;
          } else if ((getX(cellulox.robot) - celluloSize / 2) /
                  mapSizeWidthfull <
              0) {
            student.cellulox.x = 0;
          } else
            student.cellulox.x =
                (getX(cellulox.robot) - celluloSize / 2) / mapSizeWidthfull;
        }
        if (id == 1) {
          if ((getX(celluloy.robot) - celluloSize / 2) / mapSizeWidthfull >
              end) {
            student.celluloy.x = end - student.initialcellulosize / 2 / 500;
          } else if ((getX(celluloy.robot) - celluloSize / 2) /
                  mapSizeWidthfull <
              0) {
            student.celluloy.x = 0;
          } else
            student.celluloy.x =
                (getX(celluloy.robot) - celluloSize / 2) / mapSizeWidthfull;
        }
        student.notifyListeners();
      }
    }
  }

  Future<Null> getroboty(int id) async {
    //clearTracking(cellulox.robot);
    if (student.currentActivity == 'Ac1' ||
        student.currentActivity == 'Ac2' ||
        student.currentActivity == 'Ac3' ||
        student.currentActivity == 'Ac4') {
      if (student.permisMoveY) {
        if (id == 0) {
          if ((getY(cellulox.robot) - celluloSize / 2) / mapSizeHeight > end) {
            student.cellulox.y = end - student.initialcellulosize / 2 / 500;
          } else if ((getY(cellulox.robot) - celluloSize / 2) / mapSizeHeight <
              0) {
            student.cellulox.y = 0;
          } else
            student.cellulox.y =
                (getY(cellulox.robot) - celluloSize / 2) / mapSizeHeight;
        }
        if (id == 1) {
          if ((getY(celluloy.robot) - celluloSize / 2) / mapSizeHeight > end) {
            student.celluloy.y = end - student.initialcellulosize / 2 / 500;
          } else if ((getY(celluloy.robot) - celluloSize / 2) / mapSizeHeight <
              0) {
            student.celluloy.y = 0;
          } else
            student.celluloy.y =
                (getY(celluloy.robot) - celluloSize / 2) / mapSizeHeight;
        }
        student.notifyListeners();
      }
    } else {
      if (student.permisMoveY) {
        if (id == 0) {
          if ((getY(cellulox.robot) - celluloSize / 2) / mapSizeHeightfull >
              end) {
            student.cellulox.y = end - student.initialcellulosize / 2 / 500;
          } else if ((getY(cellulox.robot) - celluloSize / 2) /
                  mapSizeHeightfull <
              0) {
            student.cellulox.y = 0;
          } else
            student.cellulox.y =
                (getY(cellulox.robot) - celluloSize / 2) / mapSizeHeightfull;
        }
        if (id == 1) {
          if ((getY(celluloy.robot) - celluloSize / 2) / mapSizeHeightfull >
              end) {
            student.celluloy.y = end - student.initialcellulosize / 2 / 500;
          } else if ((getY(celluloy.robot) - celluloSize / 2) /
                  mapSizeHeightfull <
              0) {
            student.celluloy.y = 0;
          } else
            student.celluloy.y =
                (getY(celluloy.robot) - celluloSize / 2) / mapSizeHeightfull;
        }
        student.notifyListeners();
      }
    }
  }

  Future<Null> _managePower(String mcaddress, int id) async {
    int _robot = newRobot();
    //Pointer<Utf8>  encoded = utf8.encode('00:06:66:E7:8E:5E');
    //Pointer<Utf8> p = Utf8.toUtf8("Hi");
    Pointer<Utf8> charPointer = (mcaddress).toNativeUtf8();
    setLocalAdapterMacAddr(_robot, "".toNativeUtf8());
    setMacAddr(_robot, charPointer); //Utf8.toUtf8('00:06:66:E7:8E:5E').cast());
    connectToServer(_robot);
    print('success');
    String _message;
    try {
      final String result =
          await platformMethodChannel.invokeMethod('powerManage');
      _message = result;
    } on PlatformException catch (e) {
      _message = "Can't do native stuff ${e.message}.";
    }
    if (id == 0) cellulox.robot = _robot;
    if (id == 1) celluloy.robot = _robot;

    //robots.add(_robot);
    //robots.add(_robot);
  }

  Future<Null> _dismanagePower(String mcaddress, int id) async {
    if (id == 0) {
      disconnectToServer(cellulox.robot);
      //Pointer<Utf8> charPointer = (mcaddress).toNativeUtf8();
      //setMacAddr(cellulox.robot, charPointer);
    }
    if (id == 1) disconnectToServer(cellulox.robot);
    {
      disconnectToServer(celluloy.robot);
      //Pointer<Utf8> charPointer = (mcaddress).toNativeUtf8();
      //setMacAddr(celluloy.robot, charPointer);
    }
    //int _robot = newRobot();
    //Pointer<Utf8>  encoded = utf8.encode('00:06:66:E7:8E:5E');
    //Pointer<Utf8> p = Utf8.toUtf8("Hi");
    //Pointer<Utf8> charPointer = (mcaddress).toNativeUtf8();
    //setLocalAdapterMacAddr(_robot, "".toNativeUtf8());
    //setMacAddr(_robot, charPointer); //Utf8.toUtf8('00:06:66:E7:8E:5E').cast());

    //destroyServer(_robot);

    //robots.add(_robot);
    //robots.add(_robot);
  }

  void setColor(int greencode, int redcode, int bluecode, int effect, int code,
      int id) async {
    if (id == 0) {
      setVisualEffect(
          cellulox.robot, effect, redcode, greencode, bluecode, code);
    }
    if (id == 1)
      setVisualEffect(
          celluloy.robot, effect, redcode, greencode, bluecode, code);
  }

  void setGoalPosition(int id, double x, double y, double w) async {
    if (id == 0) {
      setGoalPosition(cellulox.robot, x, y, w);
    }
    if (id == 1) setGoalPosition(cellulox.robot, x, y, w);
  }

  void connectionStatus(int id) async {
    if (getConnectionStatus(cellulox.robot) == 2 &&
        getConnectionStatus(celluloy.robot) == 2) {
      student.dbSessionRef.collection("technicalStatus").add({
        "d_group": student.groupname,
        "status": 1,
      });
    } else {
      student.dbSessionRef.collection("technicalStatus").add({
        "d_group": student.groupname,
        "status": 0,
      });
    }
  }

  Future<Null> _setColor() async {
    colorset = !colorset;
    if (colorset)
      setVisualEffect(cellulox.robot, 0, 255, 0, 0, 0);
    else
      setVisualEffect(cellulox.robot, 0, 0, 0, 0, 0);
  }

  Future<Null> _setVelocity() async {
    if (robot != -1) {
      velocityset = !velocityset;
      if (velocityset)
        setGoalVelocity(robot, 100, 0, 0);
      else
        setGoalVelocity(robot, 0, 0, 0);
    }
  }

  setcolor2() async {
    _setColor();
  }

  disetup() async {
    ///print('setup');

    _dismanagePower(celluloList[cellulox.robotID], 0);
    _dismanagePower(celluloList[celluloy.robotID], 1);

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

  setup() async {
    _managePower(celluloList[cellulox.robotID], 0);
    //
    _managePower(celluloList[celluloy.robotID], 1);

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

final DynamicLibrary nativeCellulolib = Platform.isAndroid
    ? DynamicLibrary.open("libcellulo-library.so")
    : DynamicLibrary.process();

final int Function() initialize = nativeCellulolib
    .lookup<NativeFunction<Int32 Function()>>("initialize")
    .asFunction();
final int Function() deinitialize = nativeCellulolib
    .lookup<NativeFunction<Int32 Function()>>("deinitialize")
    .asFunction();

final int Function() newRobot = nativeCellulolib
    .lookup<NativeFunction<Int64 Function()>>("newRobot")
    .asFunction();

final void Function(
    int robot,
    Pointer<Utf8>
        macAddr) setLocalAdapterMacAddr = nativeCellulolib
    .lookup<NativeFunction<Void Function(Int64 robot, Pointer<Utf8> macAddr)>>(
        "setLocalAdapterMacAddr")
    .asFunction();

final void Function(
    int robot,
    Pointer<Utf8>
        macAddr) setMacAddr = nativeCellulolib
    .lookup<NativeFunction<Void Function(Int64 robot, Pointer<Utf8> macAddr)>>(
        "setMacAddr")
    .asFunction();

final void Function(int robot) connectToServer = nativeCellulolib
    .lookup<NativeFunction<Void Function(Int64 robot)>>("connectToServer")
    .asFunction();

final void Function(int robot) clearTracking = nativeCellulolib
    .lookup<NativeFunction<Void Function(Int64 robot)>>("clearTracking")
    .asFunction();

final void Function(int robot) disconnectToServer = nativeCellulolib
    .lookup<NativeFunction<Void Function(Int64 robot)>>("disconnectFromServer")
    .asFunction();

final void Function(int robot) destroyServer = nativeCellulolib
    .lookup<NativeFunction<Void Function(Int64 robot)>>("destroyRobot")
    .asFunction();

/*final int Function() newRobotfromPool = nativeCellulolib
    .lookup<NativeFunction<Int64 Function()>>("newRobotFromPool")
    .asFunction();*/

final void Function(int robot, int effect, int r, int g, int b, int value)
    setVisualEffect = nativeCellulolib
        .lookup<
            NativeFunction<
                Void Function(Int64 robot, Int64 effect, Int64 r, Int64 g,
                    Int64 b, Int64 value)>>("setVisualEffect")
        .asFunction();
//setGoalVelocity(int64_t robot, float vx, float vy, float w)
final void Function(int robot, double vx, double vy, double w) setGoalVelocity =
    nativeCellulolib
        .lookup<
            NativeFunction<
                Void Function(Int64 robot, Float vx, Float vy,
                    Float w)>>("setGoalVelocity")
        .asFunction();

final int Function() totalRobots = nativeCellulolib
    .lookup<NativeFunction<Int64 Function()>>("totalRobots")
    .asFunction();

final int Function(int robot) getConnectionStatus = nativeCellulolib
    .lookup<NativeFunction<Int64 Function(Int64 robot)>>("getConnectionStatus")
    .asFunction();

final double Function(int robot) getX = nativeCellulolib
    .lookup<NativeFunction<Float Function(Int64 robot)>>("getX")
    .asFunction();

final int Function(int robot) getShuttingdown = nativeCellulolib
    .lookup<NativeFunction<Uint8 Function(Int64 robot)>>("getShuttingdown")
    .asFunction();

final double Function(int robot) getY = nativeCellulolib
    .lookup<NativeFunction<Float Function(Int64 robot)>>("getY")
    .asFunction();

final void Function(
        int robot, double vx, double vy, double w, double v, double w2)
    setGoalPose = nativeCellulolib
        .lookup<
            NativeFunction<
                Void Function(Int64 robot, Float vx, Float vy, Float w, Float v,
                    Float w2)>>("setGoalPose")
        .asFunction();

final void Function(int robot, double x, double y, double w) setGoalPosition =
    nativeCellulolib
        .lookup<
            NativeFunction<
                Void Function(
                    Int64 robot, Float x, Float y, Float w)>>("setGoalPosition")
        .asFunction();

final int Function(int robot) getKidnapped = nativeCellulolib
    .lookup<NativeFunction<Uint8 Function(Int64 robot)>>("getKidnapped")
    .asFunction();
