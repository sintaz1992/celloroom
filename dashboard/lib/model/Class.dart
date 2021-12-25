//import 'package:firebase_thisClass.dbSessionRef/firebase_thisClass.dbSessionRef.dart';
import 'package:dashboard/model/Group.dart';
import 'package:dashboard/model/student.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:dashboard/model/activities/activity.Dart';
import 'package:flutter/material.dart';
import 'package:dashboard/commons/theme.dart';

Classroom thisClass = new Classroom("1");

class Classroom extends ChangeNotifier {
  int inactivity;
  String sessionID = '';

  bool repairmode = false;
  String teacherName;
  int numGroups = 0;
  bool firstStudent = true;
  bool startClass = false;
  bool classPaused = false;
  int brokengroup = 0;
  List<bool> groupPaused = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool movemode = false;
  bool limitmode = false;
  int maxnumGroups = 10;
  List<int> groupsonDash = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];
  bool activitySelect = false;
  var students = List.generate(10, (i) => [], growable: true);
  int maxnumgroups = 0;
  bool shouldishowpopup = true;
  Timer popuptimer;
  var elapseTimer = new Stopwatch();
  List<Group> groups = [
    new Group('1'),
    new Group('2'),
    new Group('3'),
    new Group('4'),
    new Group('5'),
    new Group('6'),
    new Group('7'),
    new Group('8'),
    new Group('9'),
    new Group('10'),
    new Group('11'),
    new Group('12'),
    new Group('13'),
    new Group('14'),
    new Group('15'),
    new Group('16'),
    new Group('17'),
    new Group('18'),
    new Group('19'),
    new Group('20'),
  ];
  List<String> groupIDs = [
    '2',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20'
  ];
  List<int> aggregatedMistakes = [0, 0, 0, 0];
  Classroom(this.sessionID);
  List<int> finishedGroupsNum = [0, 0, 0, 0, 0, 0, 0, 0];
  List<String> notifications = [];
  List<int> numstudents = [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6];
  int selectedAcIndex = 0;
  DocumentReference dbSessionRef;
  int classPage = 1;
  List<int> scoresac1 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> scoresac2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> scoresac3 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> scoresac4 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> timeac3 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> timeac4 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> timeac1 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> timeac2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int timebefore = 0;

  List<Color> groupcolor = [
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor,
    drawerBgColor
  ];
  StreamSubscription<QuerySnapshot> _ongroupAddedSubscription;
  StreamSubscription<QuerySnapshot> _onstudentAddedSubscription;
  StreamSubscription<QuerySnapshot> _ongroupActivityChangedSubscription;
  StreamSubscription<QuerySnapshot> _ongroupTurnAddedSubscription;
  StreamSubscription<QuerySnapshot> _ongroupActivityfinishedSubscription;
  StreamSubscription<QuerySnapshot> _ongroupTurnfinishedSubscription;
  StreamSubscription<QuerySnapshot> _ongroupChangedSubscription;
  StreamSubscription<QuerySnapshot> _onattemptAddedSubscription;
  StreamSubscription<QuerySnapshot> _onscoreAddedSubscription;
  StreamSubscription<QuerySnapshot> _ontimeAddedSubscription;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription1;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription2;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription3;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription4;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription5;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription6;
  StreamSubscription<DocumentSnapshot> _onscorechangedSubscription7;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription1;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription2;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription3;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription4;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription5;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription6;
  StreamSubscription<DocumentSnapshot> _onvelocitychangedSubscription7;
  StreamSubscription<QuerySnapshot> _onrobotpositionAddedSubscription;
  StreamSubscription<QuerySnapshot> _onengagementAddedSubscription;
  StreamSubscription<QuerySnapshot> _onrandomAddedSubscription;

  void setupDatabse() {
    _ongroupAddedSubscription = thisClass.dbSessionRef
        .collection("groups")
        .snapshots()
        .listen(onGroupAdded);

    _onstudentAddedSubscription = thisClass.dbSessionRef
        .collection("students")
        .snapshots()
        .listen(onStudentAdded);

    _ongroupActivityChangedSubscription = thisClass.dbSessionRef
        .collection("activityTransition")
        .snapshots()
        .listen(onGroupActivityAdded);

    _ongroupTurnAddedSubscription = thisClass.dbSessionRef
        .collection("turnTransition")
        .snapshots()
        .listen(onGroupTurnAdded);

    _ongroupActivityfinishedSubscription = thisClass.dbSessionRef
        .collection("activityFinished")
        .snapshots()
        .listen(onGroupActivityFinished);

    _ongroupTurnfinishedSubscription = thisClass.dbSessionRef
        .collection("turnFinished")
        .snapshots()
        .listen(onGroupTurnFinished);

    _onrobotpositionAddedSubscription = thisClass.dbSessionRef
        .collection("technicalStatus")
        .snapshots()
        .listen(onTechnicalStatusChanged);

    _onrandomAddedSubscription = thisClass.dbSessionRef
        .collection("random")
        .snapshots()
        .listen(onrandomChanged);
    /*
  
*/
    bool first = false;
    print('a');
    thisClass.dbSessionRef.get().then((value) => {
          first = value.get('first'),
          if (first == false)
            {
              print('b'),
              thisClass.dbSessionRef.collection("scores").doc('1').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.collection("scores").doc('2').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.collection("scores").doc('3').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.collection("scores").doc('4').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.collection("scores").doc('5').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.collection("scores").doc('6').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.collection("scores").doc('7').set({
                'score': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                'time': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
              }),
              thisClass.dbSessionRef.update({'first': true}),
              for (int i = 1; i < 8; i++)
                {
                  thisClass.dbSessionRef
                      .collection("velocity")
                      .doc(i.toString())
                      .set({
                    'velocityx': [
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                    ],
                    'velocityy': [
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0
                    ],
                    'error': [
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0,
                      0
                    ],
                  }),
                },
              print('c'),
            }
          else
            {
              thisClass.timebefore = value.get('timepassed'),
              print('time'),
            }
        });
    print('d');
    _onscorechangedSubscription1 = thisClass.dbSessionRef
        .collection('scores')
        .doc('1')
        .snapshots()
        .listen(onscorechanged1);
    _onscorechangedSubscription2 = thisClass.dbSessionRef
        .collection('scores')
        .doc('2')
        .snapshots()
        .listen(onscorechanged2);
    _onscorechangedSubscription3 = thisClass.dbSessionRef
        .collection('scores')
        .doc('3')
        .snapshots()
        .listen(onscorechanged3);
    _onscorechangedSubscription4 = thisClass.dbSessionRef
        .collection('scores')
        .doc('4')
        .snapshots()
        .listen(onscorechanged4);
    _onscorechangedSubscription5 = thisClass.dbSessionRef
        .collection('scores')
        .doc('5')
        .snapshots()
        .listen(onscorechanged5);
    _onscorechangedSubscription6 = thisClass.dbSessionRef
        .collection('scores')
        .doc('6')
        .snapshots()
        .listen(onscorechanged6);
    _onscorechangedSubscription7 = thisClass.dbSessionRef
        .collection('scores')
        .doc('7')
        .snapshots()
        .listen(onscorechanged7);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('1')
        .snapshots()
        .listen(onvelocitychanged1);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('2')
        .snapshots()
        .listen(onvelocitychanged2);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('3')
        .snapshots()
        .listen(onvelocitychanged3);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('4')
        .snapshots()
        .listen(onvelocitychanged4);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('5')
        .snapshots()
        .listen(onvelocitychanged5);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('6')
        .snapshots()
        .listen(onvelocitychanged6);

    _onvelocitychangedSubscription1 = thisClass.dbSessionRef
        .collection('velocity')
        .doc('7')
        .snapshots()
        .listen(onvelocitychanged7);

    print('e');
  }

  void desetupDatabse() {
    _ongroupAddedSubscription.cancel();
    _ongroupChangedSubscription.cancel();
    _onattemptAddedSubscription.cancel();
    _onengagementAddedSubscription.cancel();
    notifyListeners();
  }

  Future getPosition(int groupID, int acID, int turnID, int trialID) async {
    //  locator.registerLazySingleton(() => Api(Firestore.instance.collection('sessions').doc(controllerSessionID.text) thisClass.sessionID));

    thisClass.groups[groupID].activities[acID].turns[turnID].trials[trialID]
        .cellulov.x = [0.0];

    thisClass.groups[groupID].activities[acID].turns[turnID].trials[trialID]
        .cellulov.y = [0.0];

    if (acID == 6) {
      thisClass.groups[groupID].activities[acID].turns[turnID].trials[trialID]
          .cellulox.x = [0.0];

      thisClass.groups[groupID].activities[acID].turns[turnID].trials[trialID]
          .cellulox.y = [0.0];
    }

    QuerySnapshot querySnapshot = await thisClass.dbSessionRef
        .collection("celluloPosition")
        .doc((groupID + 1).toString())
        .collection('Activities')
        .doc((acID + 1).toString())
        .collection('turns')
        .doc((turnID + 1).toString())
        .collection('trials')
        .doc((trialID).toString())
        .collection("celluloPosition")
        .orderBy('time')
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      thisClass.groups[groupID].activities[acID].turns[turnID].trials[trialID]
          .cellulov.x
          .add(((a.get('x'))));
      thisClass.groups[groupID].activities[acID].turns[turnID]
        ..trials[trialID].cellulov.y.add(((a.get('y'))));
    }
    print('cellulov');

    if (acID == 6) {
      QuerySnapshot querySnapshot = await thisClass.dbSessionRef
          .collection("celluloPosition")
          .doc((groupID + 1).toString())
          .collection('Activities')
          .doc((acID + 1).toString())
          .collection('turns')
          .doc((turnID + 1).toString())
          .collection('trials')
          .doc((trialID).toString())
          .collection("celluloPositionV")
          .orderBy('time')
          .get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];

        thisClass.groups[groupID].activities[acID].turns[turnID].trials[trialID]
            .cellulox.x
            .add(((a.get('x'))));
        thisClass.groups[groupID].activities[acID].turns[turnID]
          ..trials[trialID].cellulox.y.add(((a.get('y'))));
      }
      print('cellulov');
    }
  }

  Future getDocs() async {
    if (thisClass.groups.length > 0) {
      thisClass.groups.clear();
      thisClass.groupIDs = [];
      //  thisClass.desetupDatabse(),
    }

    thisClass.sessionID = '22';

    //  locator.registerLazySingleton(() => Api(Firestore.instance.collection('sessions').doc(controllerSessionID.text) thisClass.sessionID));

    thisClass.dbSessionRef = FirebaseFirestore.instance
        .collection('sessions')
        .doc(thisClass.sessionID);

    QuerySnapshot querySnapshot =
        await thisClass.dbSessionRef.collection("students").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      onStudentAdded2(a);
    }

    QuerySnapshot querySnapshot2 =
        await thisClass.dbSessionRef.collection("activityTransition").get();
    for (int i = 0; i < querySnapshot2.docs.length; i++) {
      var a = querySnapshot2.docs[i];
      onGroupActivityAdded2(a);
    }

    QuerySnapshot querySnapshot3 =
        await thisClass.dbSessionRef.collection("turnTransition").get();
    for (int i = 0; i < querySnapshot3.docs.length; i++) {
      var a = querySnapshot3.docs[i];
      onGroupTurnAdded2(a);
    }

    QuerySnapshot querySnapshot4 =
        await thisClass.dbSessionRef.collection("activityFinished").get();
    for (int i = 0; i < querySnapshot4.docs.length; i++) {
      var a = querySnapshot4.docs[i];
      onGroupActivityFinished2(a);
    }

    QuerySnapshot querySnapshot5 =
        await thisClass.dbSessionRef.collection("turnFinished").get();
    for (int i = 0; i < querySnapshot5.docs.length; i++) {
      var a = querySnapshot5.docs[i];
      onGroupTurnFinished2(a);
    }
  }

  onStudentAdded2(QueryDocumentSnapshot event) {
    if (firstStudent) {
      firstStudent = false;
      for (int groupID = 0; groupID < 20; groupID++) {
        thisClass.groups.add(new Group(groupID.toString()));
        thisClass.groupIDs.add((groupID.toString()));
      }
    }
    print('thisClass.groups.length');
    print(thisClass.groups.length);
    if (event.get('d_group') < maxnumGroups) {
      if (event.get('d_group') > maxnumgroups) {
        maxnumgroups = event.get('d_group');
        print(maxnumgroups);
      }
      for (int i = 0; i < thisClass.students.length; i++) {
        for (int j = 0; j < thisClass.students[i].length; j++) {
          if (event.get('name') == thisClass.students[i][j]) {
            thisClass.students[i].remove(event.get('name'));
            print('removed');
            break;
          }
        }
      }
      thisClass.students[event.get('d_group') - 1].add((event.get('name')));

      notifyListeners();
    } else {
      print('number outide of range');
    }
  }

  onStudentAdded(QuerySnapshot event) {
    if (firstStudent) {
      firstStudent = false;
      for (int groupID = 0; groupID < 20; groupID++) {
        thisClass.groups.add(new Group(groupID.toString()));
        thisClass.groupIDs.add((groupID.toString()));
      }
    }
    print('thisClass.groups.length');
    print(thisClass.groups.length);

    if (event.docChanges.first.doc.get('d_group') < maxnumGroups) {
      if (event.docChanges.first.doc.get('d_group') > maxnumgroups) {
        maxnumgroups = event.docChanges.first.doc.get('d_group');
        print(maxnumgroups);
        thisClass.dbSessionRef.collection("teacherevents").add({
          "event": 'groupjoined',
          'group': maxnumgroups,
          "time":
              thisClass.elapseTimer.elapsedMilliseconds + thisClass.timebefore,
        });
      }
      for (int i = 0; i < thisClass.students.length; i++) {
        for (int j = 0; j < thisClass.students[i].length; j++) {
          if (event.docChanges.first.doc.get('name') ==
              thisClass.students[i][j]) {
            thisClass.students[i]
                .remove(event.docChanges.first.doc.get('name'));
            print('removed');
            break;
          }
        }
      }
      thisClass.students[event.docChanges.first.doc.get('d_group') - 1]
          .add((event.docChanges.first.doc.get('name')));

      notifyListeners();
    } else {
      print('number outide of range');
    }
  }

  onGroupActivityAdded2(QueryDocumentSnapshot event) {
    thisClass.groups[int.parse(event.get('d_group')) - 1]
        .activities[event.get('numAc')].gprogressvalues = thisClass
            .groups[int.parse(event.get('d_group')) - 1]
            .activities[event.get('numAc')]
            .gprogressvalues +
        (event.get('rolevalue'));

    if (true) {
      thisClass.groups[int.parse(event.get('d_group')) - 1]
          .activities[event.get('numAc')].gprogress = 0;

      //student.currentActivity[int.parse(event.docChanges.first.doc.get('d_group')) - 1]=acList[event.docChanges.first.doc.get('numAc')];lkjj
    }
    if (event.get('numAc') > 0) {
      /*
      thisClass
          .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc') - 1]
          .progress[2] = 1;
    */
    }
    notifyListeners();
    print('gg');
  }

  onGroupActivityAdded(QuerySnapshot event) {
    thisClass
        .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
        .activities[event.docChanges.first.doc.get('numAc')]
        .gprogressvalues = thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .gprogressvalues +
        (event.docChanges.first.doc.get('rolevalue'));

    if (true) {
      thisClass.groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc')].gprogress = 0;

      //student.currentActivity[int.parse(event.docChanges.first.doc.get('d_group')) - 1]=acList[event.docChanges.first.doc.get('numAc')];lkjj
    }
    if (event.docChanges.first.doc.get('numAc') > 0) {
      /*
      thisClass
          .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc') - 1]
          .progress[2] = 1;
    */
    }
    notifyListeners();
  }

  onGroupTurnAdded2(QueryDocumentSnapshot event) {
    thisClass
        .groups[int.parse(event.get('d_group')) - 1]
        .activities[event.get('numAc')]
        .progressvalues[event.get('numTurn')] = thisClass
            .groups[int.parse(event.get('d_group')) - 1]
            .activities[event.get('numAc')]
            .progressvalues[event.get('numTurn')] +
        (event.get('rolevalue'));

    if (true) {
      thisClass.groups[int.parse(event.get('d_group')) - 1]
          .activities[event.get('numAc')].progress[event.get('numTurn')] = 0;
      student.groupCurrentTurn[int.parse(event.get('d_group')) - 1] =
          event.get('numTurn') + 1;
      /* 
      if (event.docChanges.first.doc.get('numTurn') == 0) {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .gprogress = 1;
      } else {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progress[event.docChanges.first.doc.get('numTurn') - 1] = 1;
      }
      */
    }
    notifyListeners();
  }

  onGroupTurnAdded(QuerySnapshot event) {
    thisClass
        .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
        .activities[event.docChanges.first.doc.get('numAc')]
        .progressvalues[event.docChanges.first.doc.get('numTurn')] = thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progressvalues[event.docChanges.first.doc.get('numTurn')] +
        (event.docChanges.first.doc.get('rolevalue'));
    print(thisClass
        .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
        .activities[event.docChanges.first.doc.get('numAc')]
        .progressvalues);
    if (true) {
      thisClass
          .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc')]
          .progress[event.docChanges.first.doc.get('numTurn')] = 0;
      student.groupCurrentTurn[
              int.parse(event.docChanges.first.doc.get('d_group')) - 1] =
          event.docChanges.first.doc.get('numTurn') + 1;
      /* 
      if (event.docChanges.first.doc.get('numTurn') == 0) {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .gprogress = 1;
      } else {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progress[event.docChanges.first.doc.get('numTurn') - 1] = 1;
      }
      */
    }
    notifyListeners();
  }

  onGroupActivityFinished2(QueryDocumentSnapshot event) {
    thisClass.groups[int.parse(event.get('d_group')) - 1]
        .activities[event.get('numAc')].gprogressvaluesfinish = thisClass
            .groups[int.parse(event.get('d_group')) - 1]
            .activities[event.get('numAc')]
            .gprogressvaluesfinish +
        (event.get('rolevalue'));

    if (true) {
      print('acfinished');
      thisClass.groups[int.parse(event.get('d_group')) - 1]
          .activities[event.get('numAc')].gprogress = 1;
      student.currentActivity[int.parse(event.get('d_group')) - 1] =
          student.acList[event.get('numAc')];
      print(student.currentActivity);
    }
    if (event.get('numAc') > 0) {
      /*
      thisClass
          .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc') - 1]
          .progress[2] = 1;
    */
    }
    notifyListeners();
  }

  onGroupActivityFinished(QuerySnapshot event) {
    thisClass
        .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
        .activities[event.docChanges.first.doc.get('numAc')]
        .gprogressvaluesfinish = thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .gprogressvaluesfinish +
        (event.docChanges.first.doc.get('rolevalue'));
    print(thisClass
        .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
        .activities[event.docChanges.first.doc.get('numAc')]
        .gprogressvaluesfinish);
    if (true) {
      print('acfinished');
      thisClass.groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc')].gprogress = 1;
      student.currentActivity[
              int.parse(event.docChanges.first.doc.get('d_group')) - 1] =
          student.acList[event.docChanges.first.doc.get('numAc')];
      print(student.currentActivity);
    }
    if (event.docChanges.first.doc.get('numAc') > 0) {
      /*
      thisClass
          .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc') - 1]
          .progress[2] = 1;
    */
    }
    notifyListeners();
  }

  onGroupTurnFinished2(QueryDocumentSnapshot event) {
    thisClass
        .groups[int.parse(event.get('d_group')) - 1]
        .activities[event.get('numAc')]
        .progressvaluesfinish[event.get('numTurn') - 1] = thisClass
            .groups[int.parse(event.get('d_group')) - 1]
            .activities[event.get('numAc')]
            .progressvaluesfinish[event.get('numTurn') - 1] +
        (event.get('rolevalue'));

    if (true) {
      thisClass
          .groups[int.parse(event.get('d_group').toString()) - 1]
          .activities[event.get('numAc')]
          .progress[event.get('numTurn') - 1] = 1;
      /* 
      if (event.docChanges.first.doc.get('numTurn') == 0) {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .gprogress = 1;
      } else {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progress[event.docChanges.first.doc.get('numTurn') - 1] = 1;
      }
      */
    }
    notifyListeners();
  }

  onGroupTurnFinished(QuerySnapshot event) {
    thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progressvaluesfinish[
        event.docChanges.first.doc.get('numTurn') - 1] = thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progressvaluesfinish[event.docChanges.first.doc
                .get('numTurn') -
            1] +
        (event.docChanges.first.doc.get('rolevalue'));
    print(thisClass
        .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
        .activities[event.docChanges.first.doc.get('numAc')]
        .progressvaluesfinish);
    if (true) {
      thisClass
          .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
          .activities[event.docChanges.first.doc.get('numAc')]
          .progress[event.docChanges.first.doc.get('numTurn') - 1] = 1;
      /* 
      if (event.docChanges.first.doc.get('numTurn') == 0) {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .gprogress = 1;
      } else {
        thisClass
            .groups[int.parse(event.docChanges.first.doc.get('d_group')) - 1]
            .activities[event.docChanges.first.doc.get('numAc')]
            .progress[event.docChanges.first.doc.get('numTurn') - 1] = 1;
      }
      */
    }
    notifyListeners();
  }

  onGroupAdded(QuerySnapshot event) {
    event.docChanges.forEach((change) {});

    notifyListeners();
  }

  onrandomChanged(QuerySnapshot event) {
    event.docs.forEach((element) {
      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv2');
    });

    print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
    print(event.docChanges.first.doc);

    notifyListeners();
  }

  onscorechanged1(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[0] = score[0];

    thisClass.scoresac2[0] = score[1];

    thisClass.scoresac3[0] = score[2];

    thisClass.scoresac4[0] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[0] = time[0];

    thisClass.timeac2[0] = time[1];

    thisClass.timeac3[0] = time[2];

    thisClass.timeac4[0] = time[3];

    notifyListeners();
  }

  onscorechanged2(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[1] = score[0];

    thisClass.scoresac2[1] = score[1];

    thisClass.scoresac3[1] = score[2];

    thisClass.scoresac4[1] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[1] = time[0];

    thisClass.timeac2[1] = time[1];

    thisClass.timeac3[1] = time[2];

    thisClass.timeac4[1] = time[3];

    notifyListeners();
  }

  onscorechanged3(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[2] = score[0];

    thisClass.scoresac2[2] = score[1];

    thisClass.scoresac3[2] = score[2];

    thisClass.scoresac4[2] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[2] = time[0];

    thisClass.timeac2[2] = time[1];

    thisClass.timeac3[2] = time[2];

    thisClass.timeac4[2] = time[3];

    notifyListeners();
  }

  onscorechanged4(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[3] = score[0];

    thisClass.scoresac2[3] = score[1];

    thisClass.scoresac3[3] = score[2];

    thisClass.scoresac4[3] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[3] = time[0];

    thisClass.timeac2[3] = time[1];

    thisClass.timeac3[3] = time[2];

    thisClass.timeac4[3] = time[3];

    notifyListeners();
  }

  onscorechanged5(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[4] = score[0];

    thisClass.scoresac2[4] = score[1];

    thisClass.scoresac3[4] = score[2];

    thisClass.scoresac4[4] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[4] = time[0];

    thisClass.timeac2[4] = time[1];

    thisClass.timeac3[4] = time[2];

    thisClass.timeac4[4] = time[3];

    notifyListeners();
  }

  onscorechanged6(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[5] = score[0];

    thisClass.scoresac2[5] = score[1];

    thisClass.scoresac3[5] = score[2];

    thisClass.scoresac4[5] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[5] = time[0];

    thisClass.timeac2[5] = time[1];

    thisClass.timeac3[5] = time[2];

    thisClass.timeac4[5] = time[3];

    notifyListeners();
  }

  onscorechanged7(DocumentSnapshot event) {
    var score = ((event.get('score')));

    thisClass.scoresac1[6] = score[0];

    thisClass.scoresac2[6] = score[1];

    thisClass.scoresac3[6] = score[2];

    thisClass.scoresac4[6] = score[3];

    var time = ((event.get('time')));

    thisClass.timeac1[6] = time[0];

    thisClass.timeac2[6] = time[1];

    thisClass.timeac3[6] = time[2];

    thisClass.timeac4[6] = time[3];

    notifyListeners();
  }

  onvelocitychanged1(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[0].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];

      thisClass.groups[0].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];

      thisClass.groups[0].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
    }
    print('velocity');
    print(thisClass.groups[0].activities[4].turns[0].velocity);
    notifyListeners();
  }

  onvelocitychanged2(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[1].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];

      thisClass.groups[1].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];
      thisClass.groups[1].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
      notifyListeners();
    }
  }

  onvelocitychanged3(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[2].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];

      thisClass.groups[2].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];

      thisClass.groups[2].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
    }

    notifyListeners();
  }

  onvelocitychanged4(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[3].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];

      thisClass.groups[3].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];

      thisClass.groups[3].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
    }
    notifyListeners();
  }

  onvelocitychanged5(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[4].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];

      thisClass.groups[4].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];

      thisClass.groups[4].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
    }
    notifyListeners();
  }

  onvelocitychanged6(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[5].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];

      thisClass.groups[5].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];

      thisClass.groups[5].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
    }
    notifyListeners();
  }

  onvelocitychanged7(DocumentSnapshot event) {
    var velocityx = ((event.get('velocityx')));
    var velocityy = ((event.get('velocityy')));
    var error = ((event.get('error')));
    for (int i = 0; i < 9; i++) {
      thisClass.groups[6].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[0] = velocityx[i];
      thisClass.groups[6].activities[(i / 3).floor() + 4].turns[i % 3]
          .velocity[1] = velocityy[i];
      thisClass.groups[6].activities[(i / 3).floor() + 4].turns[i % 3].error =
          error[i];
    }
    notifyListeners();
  }

  onTechnicalStatusChanged(QuerySnapshot event) {
    if ((event.docChanges.first.doc.get('status')) == 1) {
      thisClass.groupcolor[
              int.parse(event.docChanges.first.doc.get('d_group')) - 1] =
          Colors.black;

      if (int.parse(event.docChanges.first.doc.get('d_group')) ==
          thisClass.brokengroup) {
        thisClass.repairmode = false;
        thisClass.notifications;
      }
    } else {
      thisClass.groupcolor[
              int.parse(event.docChanges.first.doc.get('d_group')) - 1] =
          Colors.red;
      thisClass.brokengroup =
          int.parse(event.docChanges.first.doc.get('d_group'));
      thisClass.repairmode = true;
      thisClass.notifications;
    }

    notifyListeners();
  }

  onScoreAdded(QuerySnapshot event) {
    //print(event.docChanges.first.doc);
    if ((event.docChanges.first.doc.get('numAc')) == 0)
      thisClass.scoresac1[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('score'));
    if ((event.docChanges.first.doc.get('numAc')) == 1)
      thisClass.scoresac2[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('score'));
    if ((event.docChanges.first.doc.get('numAc')) == 2)
      thisClass.scoresac3[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('score'));
    if ((event.docChanges.first.doc.get('numAc')) == 3)
      thisClass.scoresac4[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('score'));
    notifyListeners();
    print(thisClass.scoresac1);
  }

  onScoreAdded2(QueryDocumentSnapshot event) {
    //print(event.docChanges.first.doc);
    if ((event.get('numAc')) == 0)
      thisClass.scoresac1[int.parse(event.get('d_group')) - 1] =
          (event.get('score'));
    if ((event.get('numAc')) == 1)
      thisClass.scoresac2[int.parse(event.get('d_group')) - 1] =
          (event.get('score'));
    if ((event.get('numAc')) == 2)
      thisClass.scoresac3[int.parse(event.get('d_group')) - 1] =
          (event.get('score'));
    if ((event.get('numAc')) == 3)
      thisClass.scoresac4[int.parse(event.get('d_group')) - 1] =
          (event.get('score'));
    notifyListeners();
    print(thisClass.scoresac1);
  }

  onTimeAdded(QuerySnapshot event) {
    print('added');

    if ((event.docChanges.first.doc.get('numAc')) == 0)
      thisClass.timeac1[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('time'));
    if ((event.docChanges.first.doc.get('numAc')) == 1)
      thisClass.timeac2[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('time'));

    if ((event.docChanges.first.doc.get('numAc')) == 2)
      thisClass.timeac3[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('time'));
    if ((event.docChanges.first.doc.get('numAc')) == 3)
      thisClass.timeac4[int.parse(event.docChanges.first.doc.get('d_group')) -
          1] = (event.docChanges.first.doc.get('time'));

    notifyListeners();
  }

  onTimeAdded2(QueryDocumentSnapshot event) {
    print('added');

    if ((event.get('numAc')) == 0)
      thisClass.timeac1[int.parse(event.get('d_group')) - 1] =
          (event.get('time'));
    if ((event.get('numAc')) == 1)
      thisClass.timeac2[int.parse(event.get('d_group')) - 1] =
          (event.get('time'));

    if ((event.get('numAc')) == 2)
      thisClass.timeac3[int.parse(event.get('d_group')) - 1] =
          (event.get('time'));
    if ((event.get('numAc')) == 3)
      thisClass.timeac4[int.parse(event.get('d_group')) - 1] =
          (event.get('time'));

    notifyListeners();
  }
/*
  oncelluloPositionAdded(QueryDocumentSnapshot event) {
   
    
        int currentGroup = thisClass.groupIDs
            .indexOf((event.get('groupID')));
        int currentActivity =
            acList.indexOf((event.docChanges.first.doc.get('acID')));

        int currentTurn = ((event.docChanges.first.doc.get('turn')));

        // print(currentTurn);
        // int currentActivity =
        //   acList.indexOf(jsonDecode(event.snapshot.value)['acID'].toString());
        // print((jsonDecode(event.snapshot.value)['x']));
        print('xishere');

        if (currentGroup != -1) {
          var xlen = thisClass.groups[currentGroup].activities[currentActivity]
              .turns[currentTurn - 1].cellulox.x.length;

          thisClass.groups[currentGroup].activities[currentActivity]
              .turns[currentTurn - 1].cellulov.x
              .add(((event.docChanges.first.doc.get('x'))));

          thisClass.groups[currentGroup].activities[currentActivity]
              .turns[currentTurn - 1].cellulov.y
              .add(((event.docChanges.first.doc.get('y'))));
        }

        print(thisClass.groups[0].activities[4].turns[1].cellulov.y.length);
        print('yishere');
//    thisClass.groups[currentGroup].celluloy.y
        //      .add((jsonDecode(event.snapshot.value)['y'] / 40))
        //  setState(() {});

        notifyListeners();
      
    );
  }
  */
/*
  onGroupChanged(QuerySnapshot event) {
    //thisClass.groups.add(Group.fromSnapshot(event.snapshot));

    int currentGroup = thisClass.groupIDs.indexOf(event.snapshot.key);
    // print("group" + currentGroup.toString().toString());
    thisClass.groups[currentGroup].currentActivity =
        (event.snapshot.value)['currentActivity'].toString();
    thisClass.groups[currentGroup].tabletStatus =
        (event.snapshot.value)['tabletStatus'].toString();
    // setState(() {});
    notifyListeners();
    //print(thisClass.groups[currentGroup].currentActivity.toString());
  }



 

*/

}
