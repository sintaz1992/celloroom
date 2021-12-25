import 'package:flutter/rendering.dart';
import 'package:dashboard/model/cellulo.dart';
import 'package:dashboard/model/turn.dart';

List<String> acList = ['Ac1', 'Ac2', 'Ac3', 'Ac4', 'Ac5', 'Ac6', 'Ac7', 'Ac8'];
List<String> acListT = [
  'Ac1',
  'Ac2',
  'Ac3',
  'Ac4',
  'Ac5t',
  'Ac6t',
  'Ac7t',
  'Ac8'
];
List<String> acListTosend = [
  'Ac1t',
  'Ac2t',
  'Ac3t',
  'Ac4t',
  'Ac5t',
  'Ac6',
  'Ac7',
  'Ac8'
];
List<String> acListD = [
  'Warm-up:Guide the submarines in ocean',
  'Guide the submarine purple in ocean together',
  'Class Discussion: how students can play the game better?',
  'Guide the submarine purple in ocean with grid',
  'Class Discussion: Does grid help you in the game?',
];

class Activity {
  String id;
//  String _title;
  // String _description;
  int numturns;
  int currentTurn = 1;
  int elapsedTime = 0;
  int gprogress = -1;
  int gprogressvalues = 0;
  int gprogressvaluesfinish = 0;
  List<int> progressvalues = [0, 0, 0];
  List<int> progressvaluesfinish = [0, 0, 0];
  List<int> progress = [-2, -2, -2];
  List<Turn> turns = [new Turn(), new Turn(), new Turn()];
  int expectedDuration;
  int expectedNumTrials;
  var mistakes = {
    "slope": [0, 0, 0],
    "initialPoint": [0, 0, 0],
  };
  var skills = {
    "slope": [0, 0, 0],
    "initialPoint": [0, 0, 0],
  };

  var mapHit = [
    {
      'Circles': [0, 0, 0, 0, 0, 0],
      'Rectangles': [0, 0, 0, 0, 0],
      'Polygons': [0, 0, 0, 0, 0, 0],
    },
    {
      'Circles': [0, 0, 0, 0, 0, 0],
      'Rectangles': [0, 0, 0, 0, 0],
      'Polygons': [0, 0, 0, 0, 0, 0],
    },
    {
      'Circles': [0, 0, 0, 0, 0, 0],
      'Rectangles': [0, 0, 0, 0, 0],
      'Polygons': [0, 0, 0, 0, 0, 0],
    },
  ];

  Activity(this.id);
}
