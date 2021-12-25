import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashboard/model/Class.dart';
import 'package:dashboard/model/student.dart';
import 'package:dashboard/screens/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => thisClass),
        ChangeNotifierProvider(create: (_) => student),

        // StreamProvider:
        // StreamProvider(builder: (_) => _ongroupChangedSubscription, initialData: 0)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Teacher Dashboard',
        theme: ThemeData(),
        home: MainPage(),
        // onGenerateRoute: router.Router.generateRoute,
      ),
    );
  }
}
