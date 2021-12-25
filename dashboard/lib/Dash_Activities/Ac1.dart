import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashboard/widgets/custom_app_bar.dart';
import 'dart:convert';
import 'package:dashboard/config/palette.dart';
import 'package:dashboard/config/styles.dart';
import 'dart:async';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

Widget ac1() {
  double _userRating = 3.0;
  bool mistakesSwitch = false;
  bool rankingSwitch = false;
  bool robotPatternSwitch = true;
  return Consumer<Classroom>(
    builder: (context, model, child) => Row(children: <Widget>[
      SizedBox(width: 17),
      Column(children: <Widget>[
        Text('First Turn'),
        Row(children: <Widget>[
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.blue,
            ),
            itemCount: 1,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: Axis.horizontal,
          ),
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.red,
            ),
            itemCount: 1,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: Axis.horizontal,
          ),
        ]),
      ]),
      SizedBox(width: 17),
      Column(children: <Widget>[
        Text('Second Turn'),
        Row(children: <Widget>[
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.blue,
            ),
            itemCount: 1,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: Axis.horizontal,
          ),
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.red,
            ),
            itemCount: 1,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: Axis.horizontal,
          ),
        ]),
      ]),
      SizedBox(width: 17),
      Column(children: <Widget>[
        Text('Third Turn'),
        Row(children: <Widget>[
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.blue,
            ),
            itemCount: 1,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: Axis.horizontal,
          ),
          RatingBarIndicator(
            rating: _userRating,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.red,
            ),
            itemCount: 1,
            itemSize: 50.0,
            unratedColor: Colors.amber.withAlpha(50),
            direction: Axis.horizontal,
          ),
        ]),
      ]),
    ]),
  );
}
