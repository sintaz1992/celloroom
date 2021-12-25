import 'package:flutter/material.dart';
import 'package:student/model/student.dart';
import 'package:student/services/app_translations.dart';
import 'package:provider/provider.dart';

Widget linesdash() {
  return Container(
      height: student.playgroundheight / 4,
      width: student.playgroundheight / 1.5,
      decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
      // width: student.playgroundheight * h2wscreen,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  width: 35,
                  height: 35,
                  //I used some padding without fixed width and height
                  decoration: new BoxDecoration(
                    shape: BoxShape
                        .circle, // You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                    color: Colors.blueGrey,
                  ),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            (1).toString(),
                            style: new TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))), // You can add a Icon instead of text also, like below.
                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                )),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  //height: student.playgroundheight / 4,
                  //width: student.playgroundheight / 1.5,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueGrey)),
                  // width: student.playgroundheight * h2wscreen,
                  child: (!student.acgame7.showsecretlines[0])
                      ? Image.asset("assets/images/question.png",
                          //height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 8)
                      : Image.asset(
                          "assets/images/line_Ac6_function1_trial1.png",
                          //height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 8)),
              SizedBox(height: 15 / 500 * student.playgroundheight),
              student.acgame7.linesstatus[0] == 0
                  ? Text('')
                  : (student.acgame7.linesstatus[0] == 1
                      ? Image.asset("assets/images/right.jpg",
                          height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 10)
                      : Image.asset("assets/images/right.jpg",
                          height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 10)),
            ]),
            Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  width: 35,
                  height: 35,
                  //I used some padding without fixed width and height
                  decoration: new BoxDecoration(
                    shape: BoxShape
                        .circle, // You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                    color: Colors.blueGrey,
                  ),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            (2).toString(),
                            style: new TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))), // You can add a Icon instead of text also, like below.
                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                )),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  //height: student.playgroundheight / 4,
                  //width: student.playgroundheight / 1.5,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueGrey)),
                  child: (!student.acgame7.showsecretlines[1])
                      ? Image.asset("assets/images/question.png",
                          //height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 8)
                      : Image.asset(
                          "assets/images/line_Ac7_function1_trial2.png",
                          //  height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 8)),
              SizedBox(height: 15 / 500 * student.playgroundheight),
              student.acgame7.linesstatus[1] == 0
                  ? Text('')
                  : (student.acgame7.linesstatus[1] == 1
                      ? Image.asset("assets/images/right.jpg",
                          height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 10)
                      : Image.asset("assets/images/right.jpg",
                          height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 10)),
            ]),
            Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  width: 35,
                  height: 35,
                  //I used some padding without fixed width and height
                  decoration: new BoxDecoration(
                    shape: BoxShape
                        .circle, // You can use like this way or like the below line
                    //borderRadius: new BorderRadius.circular(30.0),
                    color: Colors.blueGrey,
                  ),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            (3).toString(),
                            style: new TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ))), // You can add a Icon instead of text also, like below.
                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                )),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  //height: student.playgroundheight / 4,
                  //width: student.playgroundheight / 1.5,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blueGrey)),
                  child: (!student.acgame7.showsecretlines[2])
                      ? Image.asset("assets/images/question.png",
                          //height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 8)
                      : Image.asset(
                          "assets/images/line_Ac7_function1_trial3.png",
                          // height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 8)),
              SizedBox(height: 15 / 500 * student.playgroundheight),
              student.acgame7.linesstatus[2] == 0
                  ? Text('')
                  : (student.acgame7.linesstatus[2] == 1
                      ? Image.asset("assets/images/right.jpg",
                          height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 10)
                      : Image.asset("assets/images/right.jpg",
                          height: 75 * student.playgroundheight / 860,
                          width: student.playgroundheight / 10)),
            ]),
          ]));
}
