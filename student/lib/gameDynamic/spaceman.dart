import 'dart:async';
import 'dart:io'; // For Platform.isX
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
//import 'package:student/widgets/showAlertDialog.Dart';
//import 'package:student/Database.dart';
import 'package:student/model/student.dart';
import 'package:provider/provider.dart';
import 'package:student/commonFunctions/playaudio.dart';

class Spaceman {
  Offset position = new Offset(0.0, 0.0);
  bool isactive = false;

  Spaceman();

  double mapSizeWidth = 860;
  double mapSizeHeight = 860;
}
