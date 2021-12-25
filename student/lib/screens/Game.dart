import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:student/model/student.dart';

import 'package:student/activities/router.dart' as router;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student/services/app_translations_delegate.dart';
import 'package:student/services/application.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with SingleTickerProviderStateMixin {
  // final dbRef = FirebaseDatabase.instance.reference().child(group.sessionID);
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: Consumer<Student>(
            builder: (context, model, child) => MaterialApp(
                  // Start the app with the "/" named route. In this case, the app starts
                  // on the FirstScreen widget.
                  localizationsDelegates: [
                    _newLocaleDelegate,
                    //provides localised strings
                    GlobalMaterialLocalizations.delegate,
                    //provides RTL support
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: [
                    const Locale("en", ""),
                    const Locale("fr", ""),
                  ],

                  onGenerateRoute: router.Router.generateRoute,
                  // initialRoute: '/Ac7',
                  navigatorKey: student.navigatorKeygame,
                  // routes: {
                  // '/Ac7': (context) => Ac7(),
                  //   '/Ac8': (context) => Ac8(),
                  //     '/Ac9': (context) => Ac9(),
                  //     },
                )));
  }

  void onLocaleChange(Locale locale) {
    student.curLang = locale.languageCode;
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
