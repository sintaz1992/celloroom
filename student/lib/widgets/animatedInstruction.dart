import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:student/model/student.dart';

class AnimatedInstruction extends StatefulWidget {
  final String tasktext;
  AnimatedInstruction({Key key, this.tasktext}) : super(key: key);

  @override
  _AnimatedInstructionState createState() => _AnimatedInstructionState();
}

class _AnimatedInstructionState extends State<AnimatedInstruction>
    with TickerProviderStateMixin {
  double h2wscreen = 1.0;
  Animation<int> _characterCount;

  int _stringIndex;

  void runAnimation() async {
    {
      AnimationController controller = new AnimationController(
        duration: const Duration(milliseconds: 4000),
        vsync: this,
      );
      setState(() {
        _stringIndex = 0;
        _characterCount = new StepTween(begin: 0, end: widget.tasktext.length)
            .animate(
                new CurvedAnimation(parent: controller, curve: Curves.easeIn));
      });
      await controller.forward();
      controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();

    // dbRef.child('students').child(student.id).child('tabletStatus').set("YES");
    //dbRef.child('students').child(student.id).child('currentActivity').set("Ac1");
    // elapseTimer.start();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: student.playgroundheight * h2wscreen,
      //  height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: !(student.reachendV) ? Colors.blueGrey : Colors.blueGrey),
      child: Row(children: [
        Padding(
            padding: EdgeInsets.all(6.0),
            child: Image.asset('assets/images/manC.png',
                height: student.playgroundheight * 40 / 500,
                width: student.playgroundwidth * 40 / 500)),
        Container(
          width: student.playgroundheight * h2wscreen -
              60 / 500 * student.playgroundheight * h2wscreen,
          child: Padding(
            padding: EdgeInsets.all(6.0),
            child: _characterCount == null
                ? null
                : AnimatedBuilder(
                    animation: _characterCount,
                    builder: (BuildContext context, Widget child) {
                      String text =
                          widget.tasktext.substring(0, _characterCount.value);
                      return Text(text, style: student.titletext);
                    },
                  ),
          ),
        ),
      ]),
    );
  }
}
