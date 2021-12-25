import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/model/Class.dart';
import 'package:dashboard/widgets/showAlertDialog.Dart';
import 'package:dashboard/commons/theme.dart';

class GroupWidget extends StatefulWidget {
  final Size _media;
  const GroupWidget({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);
  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  List<bool> _checkbox = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: drawerBgColor,
      child: Container(
        height: 0.7 * widget._media.height / 3,
        width: 4 * widget._media.width / 6 - 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                width: widget._media.width / 6 - 25,
                //color: Colors.white,

                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.white, width: 5),
                      left: BorderSide(color: Colors.white, width: 2)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          onDoubleTap: () {
                            showAlertDialog(
                                context,
                                'First Activity: Warm up ',
                                'In this activity, each team has two spaceships that should be guided to Earth without hitting the meteorites. Two students drive one spaceship each with their keyboards (left, right, up, down) but they cannot see the meteorites. The third student is able see the rocks on their screen (they cannot move the spaceships) and should guide the two others. This first activity is designed to give students practice in using the game environment. ',
                                'Teachers can encourage students to share what they see on their screens with their teammates. They can also motivate students to play the game by sharing the rankings of each group, if deemed as an incentive. ',
                                "assets/images/ac1t.png",
                                "assets/images/ac1t.png",
                                "assets/images/ac1t.png");
                          },
                          child: Container(
                            color: drawerBgColor,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: Image.asset(
                                      "assets/images/ac1t.png",
                                      height: 4 * widget._media.height / 30,
                                      width: widget._media.width / 10,
                                    ))),
                          )),
                      Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            thisClass.activitySelect
                                ? Checkbox(
                                    value: _checkbox[0],
                                    onChanged: (value) {
                                      thisClass.selectedAcIndex = 0;
                                      setState(() {
                                        _checkbox[0] = !_checkbox[0];
                                      });
                                    },
                                  )
                                : Container(),
                            Padding(
                                padding: EdgeInsets.all(0),
                                child: Card(
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          '1) Warm up',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )))),
                          ])),
                    ])),
            Container(
                width: widget._media.width / 6 - 25,
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: drawerBgColor,
                  border: Border(
                      right: BorderSide(color: Colors.white, width: 5),
                      left: BorderSide(color: Colors.white, width: 5)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          onDoubleTap: () {
                            showAlertDialog(
                                context,
                                'Second Activity: Controlling the spaceship together',
                                'In this activity, the team has the same objective as the first activity, however two astronauts control a single spaceship together. One astronaut can move the spaceship horizontally (left or right) while the other one can move it vertically (up or down). The roles of astronauts implicitly represent the roles of variables X-Y in a coordinate system. Students start to understand these variables, and the roles they play in situating the spaceship in space, by playing with these before teaching them the notations of X-Y. ',
                                'After the activity, encouraging students to reflect on their challenges while playing the game by simply asking: What was difficult when guiding their teammates? This will give an opportunity to highlight the answers that indicate the lack of a precise system for communication, e.g. “I can tell my friend to go left, but I cannot easily say how much they should go left”. Such statements can make students understand the need for a better system to represent positions in space. ',
                                "assets/images/ac2t.png",
                                "assets/images/ac2t.png",
                                "assets/images/ac2t.png");
                          },
                          child: Container(
                            color: drawerBgColor,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: Image.asset(
                                      "assets/images/ac2t.png",
                                      height: 4 * widget._media.height / 30,
                                      width: widget._media.width / 10,
                                    ))),
                          )),
                      Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            thisClass.activitySelect
                                ? Checkbox(
                                    value: _checkbox[1],
                                    onChanged: (value) {
                                      thisClass.selectedAcIndex = 1;
                                      setState(() {
                                        _checkbox[1] = !_checkbox[1];
                                      });
                                    },
                                  )
                                : Container(),
                            Padding(
                                padding: EdgeInsets.all(0),
                                child: Card(
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          '2) Co-Captains',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ))))
                          ])),
                    ])),
            Container(
                width: widget._media.width / 6 - 25,
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: drawerBgColor,
                  border: Border(
                      right: BorderSide(color: Colors.white, width: 5),
                      left: BorderSide(color: Colors.white, width: 5)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          onDoubleTap: () {
                            showAlertDialog(
                                context,
                                'Third Activity: New Alien Radar (Coordinate Grid)',
                                'In this activity the team has the same objective as the second activity, however for the first time students will see the grid and the numbers on the axes. We want to motivate them to think about what this new representation (grid and numbers) brings to them. What is the difference between playing the game in the second activity and the third activity? We expect some students to use numbers to guide their friends, etc.',
                                'It is a good point to have the students reflect on the difference between this activity and the previous one by prompting: When the radar changed (by adding grids and numbers), how did the experience of playing the game change? Here the teacher has the opportunity to highlight a group that used numbers to describe the target position and inquire if it helped them to play the game better. ',
                                "assets/images/ac3r.png",
                                "assets/images/ac3b.png",
                                "assets/images/ac3t.png");
                          },
                          child: Container(
                            color: drawerBgColor,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: Image.asset(
                                      "assets/images/ac3t.png",
                                      height: 4 * widget._media.height / 30,
                                      width: widget._media.width / 10,
                                    ))),
                          )),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              thisClass.activitySelect
                                  ? Checkbox(
                                      value: _checkbox[2],
                                      onChanged: (value) {
                                        thisClass.selectedAcIndex = 2;
                                        setState(() {
                                          _checkbox[2] = !_checkbox[2];
                                        });
                                      },
                                    )
                                  : Container(),
                              Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Card(
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '3) Alien Radar',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))))
                            ]),
                      ),
                    ])),
            Container(
                width: widget._media.width / 6 - 25,
                //color: Colors.white,
                decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: Colors.white, width: 2),
                      left: BorderSide(color: Colors.white, width: 5)),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          onDoubleTap: () {
                            showAlertDialog(
                                context,
                                'Fourth Activity: Find the lost astrounats',
                                'For the last activity, students should save the astronauts lost in space! This new feature of the game pushes students to play the game faster, since they have only a limited amount of time to save the lost astronauts. Each lost astronaut is placed intentionally in one of the tiles of the grid, so students can use numbers to describe the target position to their friends. Students can use chat boxes to write the target position to their friends. This feature helps students to not only guide by numbers verbally but also to write the numbers (coordinates) in a separate chat box for each person. ',
                                'During the game, encourage students to use numbers (verbal or written) to talk about the spaceship position. Teachers can ask students to communicate only via the chat box and close the audio channel, if desired. After the activity, find groups who used the numbers (verbal or written via the chat box) to play the game. Here it gives the teacher a good opportunity to start discussing the notions of X and Y coordinates, and concepts such as the axes and their names plus the notation of writing coordinates in a pair order. ',
                                "assets/images/ac4r.png",
                                "assets/images/ac4b.png",
                                "assets/images/ac4t.png");
                          },
                          child: Container(
                            color: drawerBgColor,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80.0),
                                    child: Image.asset(
                                      "assets/images/ac4t.png",
                                      height: 4 * widget._media.height / 30,
                                      width: widget._media.width / 10,
                                    ))),
                          )),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              thisClass.activitySelect
                                  ? Checkbox(
                                      value: _checkbox[3],
                                      onChanged: (value) {
                                        thisClass.selectedAcIndex = 3;
                                        setState(() {
                                          _checkbox[3] = !_checkbox[3];
                                        });
                                      },
                                    )
                                  : Container(),
                              Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Card(
                                      child: Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Text(
                                            '4) Lost astronauts',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ))))
                            ]),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
