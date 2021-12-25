import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/screens/loginpage_names.dart';
import 'package:student/model/student.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student/services/app_translations_delegate.dart';
import 'package:student/services/application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student/model/Cellulo.dart';

void main() {
  -initialize();
  int robot = -1;

  runApp(LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  void initFirestoreDatabase() async {
    await Firebase.initializeApp();
    //final FirebaseFirestore databaseReference = FirebaseFirestore.instance;
  }

  @override
  void initState() {
    super.initState();
    initFirestoreDatabase();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return

        // Otherwise, show something whilst waiting for initialization to complete
        MultiProvider(
            providers: [
          ChangeNotifierProvider(create: (_) => student),
          ChangeNotifierProvider(create: (_) => student.acgame9),
          ChangeNotifierProvider(create: (_) => student.acgame7),
          ChangeNotifierProvider(create: (_) => student.acgame6),
          ChangeNotifierProvider(create: (_) => student.acgame4),
          ChangeNotifierProvider(create: (_) => student.acgame5),
          ChangeNotifierProvider(create: (_) => student.acgame3),
          ChangeNotifierProvider(create: (_) => student.acgame2),
          ChangeNotifierProvider(create: (_) => student.acgame1),
          ChangeNotifierProvider(create: (_) => student.celluloy),
          // StreamProvider:
          // StreamProvider(builder: (_) => _ongroupChangedSubscription, initialData: 0)
        ],
            child: MaterialApp(
              navigatorKey: student.keylogin,
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
                const Locale("fa", ""),
              ],
              // initialRoute: Routes.home,
              home: LoginPage(),
            ));
  }

  void onLocaleChange(Locale locale) {
    // print(locale.languageCode);
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
