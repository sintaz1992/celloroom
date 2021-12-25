import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:dashboard/config/palette.dart';
import 'package:dashboard/config/styles.dart';
import 'dart:async';

import 'package:dashboard/model/Class.dart';
import 'package:dashboard/model/Group.dart';
import 'package:dashboard/model/activities/activity.Dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:dashboard/widgets/hexagonPainter.Dart';
import 'package:dashboard/widgets/celluloMap.Dart';
import 'package:dashboard/widgets/mapShapeMaker.dart';
import 'package:dashboard/widgets/miniature.dart';
import 'package:provider/provider.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

Widget ac3() {
  bool mistakesSwitch = false;
  bool rankingSwitch = false;
  bool robotPatternSwitch = true;
  return Consumer<Classroom>(
    builder: (context, model, child) => Container(
        height: 550,
        child: ListView.builder(
          itemCount: thisClass.groups.length,
          itemBuilder: (context, int position) {
            return Card(
                child: ListTile(
              onLongPress: () {
                /*
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupDashboard(currentgroupID: position)));
                      */
              },
              title: Row(children: <Widget>[
                SizedBox(width: 17),
                Stack(children: <Widget>[
                  CircularStepProgressIndicator(
                    totalSteps: 3,
                    //  currentStep:
                    //    thisClass.groups[position].activities[0].progress,
                    width: 100,
                    customColor: (index) => thisClass
                                .groups[position]
                                .activities[acList.indexOf(
                                    thisClass.groups[position].currentActivity)]
                                .progress[index] >
                            -2
                        ? (thisClass
                                    .groups[position]
                                    .activities[acList.indexOf(thisClass
                                        .groups[position].currentActivity)]
                                    .progress[index] >
                                -1
                            ? (thisClass
                                        .groups[position]
                                        .activities[
                                            acList.indexOf(thisClass.groups[position].currentActivity)]
                                        .progress[index] >
                                    0
                                ? Colors.green
                                : Colors.blue)
                            : Colors.red)
                        : Colors.grey,
                  ),
                  Positioned(
                    bottom: 45,
                    right: 28,
                    child: Center(
                        child: Text(
                      thisClass.groups[position].id,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    )),
                  ),
                ]),
                SizedBox(width: 25),
                minituare(position, 1, mistakesSwitch, rankingSwitch,
                    robotPatternSwitch),
                SizedBox(
                  width: 25,
                ),
                minituare(position, 2, mistakesSwitch, rankingSwitch,
                    robotPatternSwitch),
                SizedBox(
                  width: 25,
                ),
                minituare(position, 3, mistakesSwitch, rankingSwitch,
                    robotPatternSwitch),
              ]),
              trailing: Icon(Icons.more_vert),
            ));
          },
        )),
  );
}
