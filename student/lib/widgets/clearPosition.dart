import 'package:student/model/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future clearPosition(int trialID, int acID) async {
  if (acID == 5) {
    QuerySnapshot querySnapshot = await student.dbSessionRef
        .collection("celluloPosition")
        .doc(student.groupname)
        .collection('Activities')
        .doc('5')
        .collection('turns')
        .doc((student.groupCurrentTurn).toString())
        .collection('trials')
        .doc(trialID.toString())
        .collection("celluloPosition")
        .get();

    for (int i = 1; i < querySnapshot.docs.length; i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('5')
          .collection('turns')
          .doc((student.groupCurrentTurn).toString())
          .collection('trials')
          .doc(trialID.toString())
          .collection('celluloPosition')
          .doc(i.toString())
          .delete();
    }
  }
  if (acID == 6) {
    QuerySnapshot querySnapshot = await student.dbSessionRef
        .collection("celluloPosition")
        .doc(student.groupname)
        .collection('Activities')
        .doc('6')
        .collection('turns')
        .doc((student.groupCurrentTurn).toString())
        .collection('trials')
        .doc(trialID.toString())
        .collection("celluloPosition")
        .get();

    for (int i = 1; i < querySnapshot.docs.length; i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('6')
          .collection('turns')
          .doc((student.groupCurrentTurn).toString())
          .collection('trials')
          .doc(trialID.toString())
          .collection('celluloPosition')
          .doc(i.toString())
          .delete();
    }
  }
  if (acID == 7) {
    QuerySnapshot querySnapshot = await student.dbSessionRef
        .collection("celluloPosition")
        .doc(student.groupname)
        .collection('Activities')
        .doc('7')
        .collection('turns')
        .doc((student.groupCurrentTurn).toString())
        .collection('trials')
        .doc(trialID.toString())
        .collection("celluloPosition")
        .get();

    for (int i = 1; i < querySnapshot.docs.length; i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('7')
          .collection('turns')
          .doc((student.groupCurrentTurn).toString())
          .collection('trials')
          .doc(trialID.toString())
          .collection('celluloPosition')
          .doc(i.toString())
          .delete();
    }
  }

  if (acID == 8) {
    QuerySnapshot querySnapshot = await student.dbSessionRef
        .collection("celluloPosition")
        .doc(student.groupname)
        .collection('Activities')
        .doc('8')
        .collection('turns')
        .doc((student.groupCurrentTurn).toString())
        .collection('trials')
        .doc(trialID.toString())
        .collection("celluloPosition")
        .get();

    for (int i = 1; i < querySnapshot.docs.length; i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('8')
          .collection('turns')
          .doc((student.groupCurrentTurn).toString())
          .collection('trials')
          .doc(trialID.toString())
          .collection('celluloPosition')
          .doc(i.toString())
          .delete();
    }
  }
  if (acID == 9) {
    QuerySnapshot querySnapshot = await student.dbSessionRef
        .collection("celluloPosition")
        .doc(student.groupname)
        .collection('Activities')
        .doc('9')
        .collection('turns')
        .doc((student.groupCurrentTurn).toString())
        .collection('trials')
        .doc(trialID.toString())
        .collection("celluloPosition")
        .get();

    for (int i = 1; i < querySnapshot.docs.length; i++) {
      student.dbSessionRef
          .collection("celluloPosition")
          .doc(student.groupname)
          .collection('Activities')
          .doc('9')
          .collection('turns')
          .doc((student.groupCurrentTurn).toString())
          .collection('trials')
          .doc(trialID.toString())
          .collection('celluloPosition')
          .doc(i.toString())
          .delete();
    }
  }
}
