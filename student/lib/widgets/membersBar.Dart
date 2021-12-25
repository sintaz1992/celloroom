import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:student/model/student.dart';
import 'package:provider/provider.dart';
import 'package:student/widgets/animationSpacema.dart';
import 'package:student/gameDynamic/Ac4.dart';
import 'package:student/gameDynamic/Ac3.dart';

class MembersBar extends StatefulWidget {
  final int curTurn;

  MembersBar({Key key, this.curTurn}) : super(key: key);

  @override
  _MembersBarState createState() => _MembersBarState();
}

class _MembersBarState extends State<MembersBar> {
  Widget build(BuildContext context) {
    return Consumer<Student>(
        builder: (context, model, child) => Padding(
            padding: EdgeInsets.all(0.0),
            child: Container(

                // height: 295,
                width: student.playgroundheight*4/5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset("assets/images/celluloRed.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)),
                      SizedBox(width: student.playgroundheight * 40 / 500),
                      (student.scoreX > 0)
                          ? Image.asset("assets/images/starred.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreX > 1)
                          ? Image.asset("assets/images/starred.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreX > 2)
                          ? Image.asset("assets/images/starred.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreX > 3)
                          ? Image.asset("assets/images/starred.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreX > 4)
                          ? Image.asset("assets/images/starred.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreX > 5)
                          ? Image.asset("assets/images/starred.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),

                      /* 
                          LiquidLinearProgressIndicator(
                            value: student.scoreX /
                                student.scoreMax, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(Colors
                                .red), // Defaults to the current Theme's accentColor.
                            backgroundColor: Colors
                                .white, // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.red,
                            borderWidth: 1.0,
                            borderRadius: 6.0,
                            direction: Axis
                                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                            center: Text(""),
                          )
                          */
                    ]),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset("assets/images/celluloBlue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)),
                      SizedBox(width: student.playgroundheight * 40 / 500),
                      (student.scoreY > 0)
                          ? Image.asset("assets/images/starblue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreY > 1)
                          ? Image.asset("assets/images/starblue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreY > 2)
                          ? Image.asset("assets/images/starblue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreY > 3)
                          ? Image.asset("assets/images/starblue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreY > 4)
                          ? Image.asset("assets/images/starblue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                      (student.scoreY > 5)
                          ? Image.asset("assets/images/starblue.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/heart.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500),
                    ]),
                    /*
                SizedBox(height: 20),
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: (student.groupPolicy[2]
                                  [student.groupCurrentTurn - 1] ==
                              'R')
                          ? Image.asset("assets/images/celluloRed.png",
                              height: 40, width: 40)
                          : ((student.groupPolicy[2]
                                      [student.groupCurrentTurn - 1] ==
                                  'B')
                              ? Image.asset("assets/images/celluloBlue.png",
                                  height: 40, width: 40)
                              : Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset("assets/images/tablet.png",
                                      height: 40, width: 40)))),
                  Container(
                      width: 100,
                      child: Text(
                        student.groupmember3name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  SizedBox(width: 50),
                  (student.groupPolicy[2][student.groupCurrentTurn - 1] == 'R')
                      ? SizedBox(
                          width: 50,
                          height: 40,
                          child: LiquidLinearProgressIndicator(
                            value: student.scoreX /
                                student.scoreMax, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(Colors
                                .red), // Defaults to the current Theme's accentColor.
                            backgroundColor: Colors
                                .white, // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.red,
                            borderWidth: 1.0,
                            borderRadius: 6.0,
                            direction: Axis
                                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                            center: Text(""),
                          ))
                      : ((student.groupPolicy[2]
                                  [student.groupCurrentTurn - 1] ==
                              'B')
                          ? SizedBox(
                              width: 50,
                              height: 40,
                              child: LiquidLinearProgressIndicator(
                                value: student.scoreY /
                                    student.scoreMax, // Defaults to 0.5.
                                valueColor: AlwaysStoppedAnimation(Colors
                                    .blue), // Defaults to the current Theme's accentColor.
                                backgroundColor: Colors
                                    .white, // Defaults to the current Theme's backgroundColor.
                                borderColor: Colors.red,
                                borderWidth: 1.0,
                                borderRadius: 6.0,
                                direction: Axis
                                    .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                center: Text(""),
                              ))
                          : Text('')),
                ]),
              */
                  ],
                ))));
  }
}

class MembersBar2 extends StatefulWidget {
  final int curTurn;
  MembersBar2({Key key, this.curTurn}) : super(key: key);

  @override
  _MembersBar2State createState() => _MembersBar2State();
}

class _MembersBar2State extends State<MembersBar2> {
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          // height: 270,
          width: student.playgroundheight*4/5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset("assets/images/celluloPurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)),
                  SizedBox(width: student.playgroundheight * 40 / 500),
                  (student.scoreV > 0)
                      ? Image.asset("assets/images/starpurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)
                      : Image.asset("assets/images/heart.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500),
                  (student.scoreV > 1)
                      ? Image.asset("assets/images/starpurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)
                      : Image.asset("assets/images/heart.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500),
                  (student.scoreV > 2)
                      ? Image.asset("assets/images/starpurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)
                      : Image.asset("assets/images/heart.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500),
                  (student.scoreV > 3)
                      ? Image.asset("assets/images/starpurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)
                      : Image.asset("assets/images/heart.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500),
                  (student.scoreV > 4)
                      ? Image.asset("assets/images/starpurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)
                      : Image.asset("assets/images/heart.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500),
                  (student.scoreV > 5)
                      ? Image.asset("assets/images/starpurple.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500)
                      : Image.asset("assets/images/heart.png",
                          height: student.playgroundheight * 40 / 500,
                          width: student.playgroundheight * 40 / 500),
                ]),
              ]),
        ));
  }
}

class RewardBar extends StatefulWidget {
  RewardBar({
    Key key,
  }) : super(key: key);

  @override
  _RewardBarState createState() => _RewardBarState();
}

class _RewardBarState extends State<RewardBar> {
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          // height: 270,
          width: student.playgroundheight * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  SizedBox(width: student.playgroundheight * 40 / 500),
                  (student.acgame4.spacemanVisible[0] != 0)
                      ? ((student.acgame4.spacemanVisible[0] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game4>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator(
                                curman: 0,
                              )),
                  (student.acgame4.spacemanVisible[1] != 0)
                      ? ((student.acgame4.spacemanVisible[1] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game4>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator(
                                curman: 1,
                              )),
                  (student.acgame4.spacemanVisible[2] != 0)
                      ? ((student.acgame4.spacemanVisible[2] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game4>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator(
                                curman: 2,
                              )),
                  (student.acgame4.spacemanVisible[3] != 0)
                      ? ((student.acgame4.spacemanVisible[3] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game4>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator(
                                curman: 3,
                              )),
                  (student.acgame4.spacemanVisible[4] != 0)
                      ? ((student.acgame4.spacemanVisible[4] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game4>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator(
                                curman: 4,
                              )),
                ]),
              ]),
        ));
  }
}


class RewardBar2 extends StatefulWidget {
  RewardBar2({
    Key key,
  }) : super(key: key);

  @override
  _RewardBar2State createState() => _RewardBar2State();
}

class _RewardBar2State extends State<RewardBar2> {
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          // height: 270,
          width: student.playgroundheight * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  SizedBox(width: student.playgroundheight * 40 / 500),
                  (student.acgame3.spacemanVisible[0] != 0)
                      ? ((student.acgame3.spacemanVisible[0] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game3>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator2(
                                curman: 0,
                              )),
                  (student.acgame3.spacemanVisible[1] != 0)
                      ? ((student.acgame3.spacemanVisible[1] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game3>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator2(
                                curman: 1,
                              )),
                  (student.acgame3.spacemanVisible[2] != 0)
                      ? ((student.acgame3.spacemanVisible[2] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game3>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator2(
                                curman: 2,
                              )),
                  (student.acgame3.spacemanVisible[3] != 0)
                      ? ((student.acgame3.spacemanVisible[3] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game3>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator2(
                                curman: 3,
                              )),
                  (student.acgame3.spacemanVisible[4] != 0)
                      ? ((student.acgame3.spacemanVisible[4] == 1)
                          ? Image.asset("assets/images/spacescorefull.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500)
                          : Image.asset("assets/images/spacescoredead.png",
                              height: student.playgroundheight * 40 / 500,
                              width: student.playgroundheight * 40 / 500))
                      : Consumer<Game3>(
                          builder: (context, model, child) =>
                              AnimatedLiquidCustomProgressIndicator2(
                                curman: 4,
                              )),
                              
                ]),
              ]),
        ));
  }
}


class RoleBar extends StatefulWidget {
  final int curTurn;
  RoleBar({Key key, this.curTurn}) : super(key: key);

  @override
  _RoleBarState createState() => _RoleBarState();
}

class _RoleBarState extends State<RoleBar> {
  double h2wscreen = 1;
  double size = 60;
  Widget build(BuildContext context) {
    return Container(
        height: student.playgroundheight * 120 / 500,
        width: student.playgroundheight * h2wscreen / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: student.acgame1.tasktextcolor),
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: <Widget>[
                widget.curTurn== 1
                      ? Image.asset("assets/images/cellulox.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : (widget.curTurn == 2
                          ? Image.asset("assets/images/tablet.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/celluloy.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)),
                  Container(
                      child: Text(
                    student.groupmember1name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  widget.curTurn == 1
                      ? Image.asset("assets/images/celluloy.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : (widget.curTurn == 2
                          ? Image.asset("assets/images/cellulox.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/tablet.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)),
                  Container(
                      child: Text(
                    student.groupmember2name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                  widget.curTurn == 1
                      ? Image.asset("assets/images/tablet.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : (widget.curTurn == 2
                          ? Image.asset("assets/images/celluloy.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/cellulox.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)),
                  Container(
                      child: Text(
                    student.groupmember3name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            
          ],
        ));
  }
}

// role bar 2 is for when we have 4 students. 

class RoleBar2 extends StatefulWidget {
  final int curTurn;
  RoleBar2({Key key, this.curTurn}) : super(key: key);

  @override
  _RoleBar2State createState() => _RoleBar2State();
}

class _RoleBar2State extends State<RoleBar2> {
  double h2wscreen = 1;
  double size = 60;
  Widget build(BuildContext context) {
    return Container(
        height: student.playgroundheight * 120 / 500,
        width: student.playgroundheight * h2wscreen ,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: student.acgame1.tasktextcolor),
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: <Widget>[
            (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 0
                      ? Image.asset("assets/images/cellulox.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 1
                          ? Image.asset("assets/images/observer.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 2
                          ? Image.asset("assets/images/tablet.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/celluloy.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500))),
                  Container(
                      child: Text(
                    student.groupmember1name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                 (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 0
                      ? Image.asset("assets/images/celluloy.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 1
                          ? Image.asset("assets/images/cellulox.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 2
                          ? Image.asset("assets/images/observer.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/tablet.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500))),
                  Container(
                      child: Text(
                    student.groupmember2name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
             (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 0
                      ? Image.asset("assets/images/tablet.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 1
                          ? Image.asset("assets/images/celluloy.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 2
                          ? Image.asset("assets/images/cellulox.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/observer.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500))),
                  Container(
                      child: Text(
                    student.groupmember3name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
                (student.is4person==true)?

                   Spacer():Text(''),

             (student.is4person==true)? Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                 (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 0
                      ? Image.asset("assets/images/observer.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                      : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 1
                          ? Image.asset("assets/images/tablet.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : ( (((student.acList.indexOf(student.currentActivity)-1)*3+widget.curTurn)%4)== 2
                          ? Image.asset("assets/images/celluloy.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500)
                          : Image.asset("assets/images/cellulox.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500))),
                  Container(
                      child: Text(
                    student.groupmember4name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])):Text('')
          ],
        ));
  }
}



class RoleBar3 extends StatefulWidget {
  final int curTurn;
  RoleBar3({Key key, this.curTurn}) : super(key: key);

  @override
  _RoleBar3State createState() => _RoleBar3State();
}

class _RoleBar3State extends State<RoleBar3> {
  double h2wscreen = 1;
  double size = 60;
  Widget build(BuildContext context) {
    return Container(
        height: student.playgroundheight * 120 / 500,
        width: student.playgroundheight * h2wscreen / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: student.acgame1.tasktextcolor),
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: <Widget>[
               Image.asset("assets/images/cellulox.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500)
                     ,
                  Container(
                      child: Text(
                                        widget.curTurn == 1
                      ? student.groupmember1name: widget.curTurn == 2
                      ? (student.groupmember2name):student.groupmember3name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                 Image.asset("assets/images/celluloy.png",
                              height: student.playgroundheight * size / 500,
                              width: student.playgroundheight * size / 500),
                        
                  Container(
                      child: Text(
                                         widget.curTurn == 1
                      ? student.groupmember1name: widget.curTurn == 2
                      ? (student.groupmember2name):student.groupmember3name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(children: [
                   Image.asset("assets/images/tablet.png",
                          height: student.playgroundheight * size / 500,
                          width: student.playgroundheight * size / 500),
                  Container(
                      child: Text(
                     widget.curTurn == 1
                      ? student.groupmember1name: widget.curTurn == 2
                      ? (student.groupmember2name):student.groupmember3name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                ])),
            
          ],
        ));
  }
}


