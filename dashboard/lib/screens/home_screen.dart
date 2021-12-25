import 'package:dashboard/model/Class.dart';
import 'package:dashboard/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/model/activities/activity.Dart';
import 'package:dashboard/model/core/services/api.dart';
import 'package:dashboard/config/palette.dart';
import 'package:dashboard/config/styles.dart';
import 'package:dashboard/screens/screens.dart';
import 'package:dashboard/screens/bottom_nav_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dashboard/widgets/showAlertDialog.Dart';
import 'package:dashboard/screens/Debriefing.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var isallgroupsconnected = false;
  bool joinEnabled = true;
  Animation<double> animation;
  AnimationController _controller;
  String numConnectedGroups = '0';
  bool joinenables = true;
  String startAcdropdownValue;

  // List<Product> products;
  @override
  void initState() {
    super.initState();
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'C',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'ell',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ulo',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<CRUDModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    TextEditingController controllerSessionID = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.primaryColor,
        elevation: 0.0,
        title: Text('Start your class'),
        leading: IconButton(
          icon: const Icon(Icons.settings),
          iconSize: 28.0,
          onPressed: () {},
        ),
        //  actions: <Widget>[
        //    IconButton(
        //     icon: const Icon(Icons.notifications_none),
        //     iconSize: 28.0,
        //     onPressed: () {},
        //   ),
        //  ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _overalClass(screenHeight),
          SliverToBoxAdapter(
            child: Column(children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextField(
                    controller: controllerSessionID,
                    onChanged: (String value) {},
                    cursorColor: Colors.deepOrange,
                    decoration: InputDecoration(
                        hintText: "Session ID",
                        prefixIcon: Material(
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(
                            Icons.lock,
                            color: Palette.primaryColor,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color:
                            joinEnabled ? Palette.primaryColor : Colors.grey),
                    child: FlatButton(
                      child: Text(
                        "Join",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      onPressed: () => {
                        (joinEnabled)
                            ? {
                                if (thisClass.groups.length > 0)
                                  {
                                    thisClass.groups.clear(),
                                    thisClass.groupIDs = [],
                                    //  thisClass.desetupDatabse(),
                                  },
                                if (controllerSessionID.text != '')
                                  {
                                    thisClass.sessionID =
                                        controllerSessionID.text,

                                    //  locator.registerLazySingleton(() => Api(Firestore.instance.collection('sessions').doc(controllerSessionID.text) thisClass.sessionID));

                                    thisClass.setupDatabse(),
                                  }
                                else
                                  {
                                    //    showAlertDialog(context, '', '',
                                    //     'Please specify a session ID'),
                                  },
                                joinEnabled = false,
                              }
                            : null,
                      },
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                      width: 500,
                      child: DropdownButton<String>(
                        hint:
                            Text('Students start the session with activity: '),
                        value: startAcdropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        onChanged: (String newValue) {
                          setState(() {
                            startAcdropdownValue = newValue;
                          });
                        },
                        items: acListD
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ))),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Palette.primaryColor),
                    child: TextButton(
                      child: Text(
                        "Start the session",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      onPressed: () {
                        if (startAcdropdownValue != '' &&
                            startAcdropdownValue != null) {
                          for (int i = 0; i < thisClass.groups.length; i++) {
                            thisClass.dbSessionRef
                                .collection('groups')
                                .doc(thisClass.groupIDs[i])
                                .update({
                              'currentActivity':
                                  acList[acListD.indexOf(startAcdropdownValue)],
                            });
                          }

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Debriefing()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Debriefing()));
                        }
                      },
                    ),
                  )),
            ]),
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _controlClass(double screenHeight) {
    Color color1 = Color(0xffFC5CF0);
    Color color2 = Color(0xffFE8852);

    return SliverToBoxAdapter(
        child: Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color1, color2],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: Row(
              children: <Widget>[
                Spacer(),
              ],
            ),
          ),
          Center(
              child: IconButton(
            color: Colors.white,
            icon: Icon(FontAwesomeIcons.pause),
            onPressed: () {},
            tooltip: "Pause the student",
          )),
        ],
      ),
    ));
  }

  SliverToBoxAdapter _overalClass(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(child: Image.asset('assets/images/cellulo.png')),
            const SizedBox(height: 20.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Column(
                children: <Widget>[
                  Consumer<Classroom>(
                      builder: (context, model, child) => Text(
                            thisClass.groups.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )),
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    children: <Widget>[
                      Icon(Icons.group, color: Colors.white),
                      Text(
                        "  Connected Groups",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _recentAc(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/images/cellulo.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Do you want to see how many robots are working?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'Click on the button below',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _alarms(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.alarm,
              color: Colors.red,
              size: 94.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'One group has problem with robot',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  'One group is not progressing..For details press here',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
