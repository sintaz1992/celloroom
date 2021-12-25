import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:student/activities/Ac0.dart';
import 'package:student/activities/Ac1.dart';
import 'package:student/activities/Ac1_tt.dart';
import 'package:student/activities/Ac2_t.dart';
import 'package:student/activities/Ac3_t.dart';

import 'package:student/activities/Ac4_t.dart';
import 'package:student/activities/Ac_9.dart';
import 'package:student/activities/Ac2.dart';
import 'package:student/activities/Ac3.dart';
import 'package:student/activities/Ac_10.dart';
import 'package:student/activities/Ac4.dart';
import 'package:student/activities/Ac51.dart';
import 'package:student/activities/Ac8.dart';
import 'package:student/activities/Ac7.dart';
import 'package:student/activities/Ac6.dart';
import 'package:student/activities/AcD.dart';
import 'package:student/activities/Ac_finish.dart';
import 'package:student/model/student.dart';
//import 'package:Teacher_Dashboard/screens/bottom_nav_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (student.currentActivity) {
      case 'Ac7':
        return MaterialPageRoute(builder: (_) => Ac7());
      case 'Ac8':
        return MaterialPageRoute(builder: (_) => Ac8());
      case 'Ac9':
        return MaterialPageRoute(builder: (_) => Ac9());
      case 'Ac10':
        return MaterialPageRoute(builder: (_) => Ac10());
      case 'Ac6':
        return MaterialPageRoute(builder: (_) => Ac6());
      case 'Ac61':
        return MaterialPageRoute(builder: (_) => Ac1());
      case 'Ac5':
        return MaterialPageRoute(builder: (_) => Ac5());
      case 'Ac4':
        return MaterialPageRoute(builder: (_) => Ac4());
      case 'Ac3':
        return MaterialPageRoute(builder: (_) => Ac3());
      case 'Ac2':
        return MaterialPageRoute(builder: (_) => Ac2());
      case 'Ac0':
        return MaterialPageRoute(builder: (_) => Ac0());
      case 'Ac1':
        return MaterialPageRoute(builder: (_) => Ac1());
      case 'Ac1t':
        return MaterialPageRoute(builder: (_) => Ac1t());
      case 'Ac2t':
        return MaterialPageRoute(builder: (_) => Ac2t());
      case 'Ac3t':
        return MaterialPageRoute(builder: (_) => Ac3t());
      case 'Ac4t':
        return MaterialPageRoute(builder: (_) => Ac4t());
      case 'AcD':
        return MaterialPageRoute(builder: (_) => AcD());
      case 'Acf':
        return MaterialPageRoute(builder: (_) => Acf());
      case 'Idle':
        return MaterialPageRoute(builder: (_) => Ac1());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for '),
                  ),
                ));
    }
  }
}
