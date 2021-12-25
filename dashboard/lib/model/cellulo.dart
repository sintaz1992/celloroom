import 'package:flutter/rendering.dart';

//Activity ac7 = new Activity("Ac7");

//Activity ac8 = new Activity("Ac8");

//List<String> acList = ['Ac7', 'Ac8'];

class Cellulo {
  String id;
//  String _title;
  // String _description;
  int numAttempts = 0;
  int currentTurn = 1;
  int elapsedTime = 0;
  List<double> x = [0.0];
  List<double> y = [0.0];
  List<int> vx = [0];
  List<double> vy = [0.0];
  int status;
  Cellulo();
}
