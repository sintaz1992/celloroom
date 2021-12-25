import 'package:flutter/material.dart';

class AnimatedTypingTextWidget extends StatefulWidget {
  final String toanimtext;

  AnimatedTypingTextWidget({Key key, this.toanimtext}) : super(key: key);
  @override
  State createState() => new AnimatedTypingTextWidgetState();
}

class AnimatedTypingTextWidgetState extends State<AnimatedTypingTextWidget>
    with TickerProviderStateMixin {
  Animation<int> _characterCount;

  int _stringIndex;
  static List<String> _kStrings = const <String>[
    ' widget.toanimtext',
  ];
  String get _currentString => _kStrings[_stringIndex % _kStrings.length];

  void initState() {
    // _kStrings[0] = widget.toanimtext;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    
    return new Row(children: [
      new Container(
        margin: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
        child: _characterCount == null
            ? null
            : new AnimatedBuilder(
                animation: _characterCount,
                builder: (BuildContext context, Widget child) {
                  String text =
                      widget.toanimtext.substring(0, _characterCount.value);
                  return new Text(text, );
                },
              ),
      ),
    ]);
  }
}
