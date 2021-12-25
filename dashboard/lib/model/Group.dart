import 'package:dashboard/model/cellulo.dart';
import 'package:flutter/rendering.dart';
import 'package:dashboard/model/activities/activity.Dart';

Group group = new Group("1");

class Group {
  String id = "1";
  var skills = {
    "slope": [0, 0, 0],
    "initialPoint": [0, 0, 0],
  };
//  String _title;
  // String _description;
  int curinactivity;
  Cellulo cellulox = new Cellulo();
  Cellulo celluloy = new Cellulo();
  List<int> inactivity = new List<int>.generate(50, (index) => -1);
  String member1name = '';
  String member2name = '';
  String member3name = '';
  String robot1code;
  String robot2code;
  String tabletStatus;
  String robotStatus;
  bool ispaused;
  bool canChangeActivity = false;

  int numAttempts;
  List<int> progress = [-2, -2, -2];
  String currentActivity = 'Ac7';
  double engagementX = 0.0;
  double engagementY = 0.0;
  double engagement = 0.0;
  List<Activity> activities = [
    new Activity("Ac1"),
    new Activity("Ac2"),
    new Activity("Ac3"),
    new Activity("Ac4"),
    new Activity("Ac5"),
    new Activity("Ac6"),
    new Activity("Ac7"),
    new Activity("Ac8")
  ];

  Group(this.id);

  toJson() {
    return {
      "userId": member1name,
      "subject": member1name,
      "completed": member1name,
    };
  }
}
