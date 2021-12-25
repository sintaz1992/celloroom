import 'package:dashboard/commons/theme.dart';
import 'package:dashboard/model/Class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupNamesWidget extends StatefulWidget {
  const GroupNamesWidget({Key key, @required Size media, int groupID})
      : _media = media,
        _groupID = groupID,
        super(key: key);

  final Size _media;
  final int _groupID;
  @override
  _GroupNamesWidgetState createState() => _GroupNamesWidgetState();
}

class _GroupNamesWidgetState extends State<GroupNamesWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: thisClass.groupcolor[widget._groupID],
      child: Container(
        height: widget._media.height / 12,
        width: 2 * widget._media.width / 3 - 100,
        child: Consumer<Classroom>(
            builder: (context, model, child) => Row(
                  children: <Widget>[
                    Container(
                      height: widget._media.height / 12,
                      width: (2 * widget._media.width / 3 - 100) / 4,
                      decoration: BoxDecoration(
                        color: thisClass.groupcolor[widget._groupID],
                        border: Border(
                          right: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          top: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          bottom: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          left: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            SizedBox(
                                height: widget._media.height / 12,
                                width: 3 *
                                        (2 * widget._media.width / 3 - 100) /
                                        16 -
                                    10,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, int position) {
                                      return Container(
                                          height: widget._media.height / 12,
                                          width: (2 * widget._media.width / 3 -
                                                      100) /
                                                  16 -
                                              10 / 3,
                                          decoration: BoxDecoration(
                                              color: thisClass
                                                          .groups[
                                                              widget._groupID]
                                                          .activities[0]
                                                          .progress[position] ==
                                                      0
                                                  ? inprogress
                                                  : (thisClass
                                                                  .groups[widget
                                                                      ._groupID]
                                                                  .activities[0]
                                                                  .progress[
                                                              position] ==
                                                          1
                                                      ? finished
                                                      : Colors.white),
                                              border: Border.all(
                                                color: drawerBgColor,
                                                width: 5,
                                              )),
                                          child: Center(
                                            child: thisClass
                                                        .groups[widget._groupID]
                                                        .activities[0]
                                                        .progress[position] ==
                                                    1
                                                ? Icon(Icons.check)
                                                : Text(''),
                                          ));
                                    })),
                          ])),
                    ),
                    Container(
                      height: widget._media.height / 12,
                      width: (2 * widget._media.width / 3 - 100) / 4,
                      decoration: BoxDecoration(
                        color: thisClass.groupcolor[widget._groupID],
                        border: Border(
                          right: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          top: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          bottom: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          left: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: widget._media.height / 12,
                                width: 3 *
                                        (2 * widget._media.width / 3 - 100) /
                                        16 -
                                    10,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, int position) {
                                      return Container(
                                          height: widget._media.height / 12,
                                          width: (2 * widget._media.width / 3 -
                                                      100) /
                                                  16 -
                                              10 / 3,
                                          decoration: BoxDecoration(
                                              color: thisClass
                                                          .groups[
                                                              widget._groupID]
                                                          .activities[1]
                                                          .progress[position] ==
                                                      0
                                                  ? inprogress
                                                  : (thisClass
                                                                  .groups[widget
                                                                      ._groupID]
                                                                  .activities[1]
                                                                  .progress[
                                                              position] ==
                                                          1
                                                      ? finished
                                                      : Colors.white),
                                              border: Border.all(
                                                color: drawerBgColor,
                                                width: 5,
                                              )),
                                          child: Center(
                                            child: thisClass
                                                        .groups[widget._groupID]
                                                        .activities[1]
                                                        .progress[position] ==
                                                    1
                                                ? Icon(Icons.check)
                                                : Text(''),
                                          ));
                                    })),
                          ]),
                    ),
                    Container(
                      height: widget._media.height / 12,
                      width: (2 * widget._media.width / 3 - 100) / 4,
                      decoration: BoxDecoration(
                        color: thisClass.groupcolor[widget._groupID],
                        border: Border(
                          right: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          top: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          bottom: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          left: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: widget._media.height / 12,
                                width: 3 *
                                        (2 * widget._media.width / 3 - 100) /
                                        16 -
                                    10,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, int position) {
                                      return Container(
                                          height: widget._media.height / 12,
                                          width: 1 *
                                                  (2 * widget._media.width / 3 -
                                                      100) /
                                                  16 -
                                              10 / 3,
                                          decoration: BoxDecoration(
                                              color: thisClass
                                                          .groups[
                                                              widget._groupID]
                                                          .activities[2]
                                                          .progress[position] ==
                                                      0
                                                  ? inprogress
                                                  : (thisClass
                                                                  .groups[widget
                                                                      ._groupID]
                                                                  .activities[2]
                                                                  .progress[
                                                              position] ==
                                                          1
                                                      ? finished
                                                      : Colors.white),
                                              border: Border.all(
                                                color: drawerBgColor,
                                                width: 5,
                                              )),
                                          child: Center(
                                            child: thisClass
                                                        .groups[widget._groupID]
                                                        .activities[2]
                                                        .progress[position] ==
                                                    1
                                                ? Icon(Icons.check)
                                                : Text(''),
                                          ));
                                    })),
                          ]),
                    ),
                    Container(
                      height: widget._media.height / 12,
                      width: (2 * widget._media.width / 3 - 100) / 4,
                      decoration: BoxDecoration(
                        color: thisClass.groupcolor[widget._groupID],
                        border: Border(
                          right: BorderSide(color: Colors.white, width: 2),
                          top: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          bottom: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                          left: BorderSide(
                              color: thisClass.groupcolor[widget._groupID],
                              width: 5),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: widget._media.height / 12,
                                width: 3 *
                                        (2 * widget._media.width / 3 - 100) /
                                        16 -
                                    10,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, int position) {
                                      return Container(
                                          height: widget._media.height / 12,
                                          width: (2 * widget._media.width / 3 -
                                                      100) /
                                                  16 -
                                              10 / 3,
                                          decoration: BoxDecoration(
                                              color: thisClass
                                                          .groups[
                                                              widget._groupID]
                                                          .activities[3]
                                                          .progress[position] ==
                                                      0
                                                  ? inprogress
                                                  : (thisClass
                                                                  .groups[widget
                                                                      ._groupID]
                                                                  .activities[3]
                                                                  .progress[
                                                              position] ==
                                                          1
                                                      ? finished
                                                      : Colors.white),
                                              border: Border.all(
                                                color: drawerBgColor,
                                                width: 5,
                                              )),
                                          child: Center(
                                            child: thisClass
                                                        .groups[widget._groupID]
                                                        .activities[3]
                                                        .progress[position] ==
                                                    1
                                                ? Icon(Icons.check)
                                                : Text(''),
                                          ));
                                    })),
                          ]),
                    ),
                  ],
                )),
      ),
    );
  }
}
