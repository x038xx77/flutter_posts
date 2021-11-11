import 'package:flutter/material.dart';

import 'app.dart';
import 'pages/about.dart';
import 'pages/details.dart';
import 'pages/home.dart';
import 'sign_up/sign_up_page.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TestAPPLPA',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/details': (BuildContext context) => Details(),
        '/about': (BuildContext context) => About(),
        '/auth': (BuildContext context) => AuthPage(),
        '/signup': (BuildContext context) => SignUpPage(),
      },
      // ignore: missing_return
      onGenerateRoute: (routeSettings) {
        var path = routeSettings.name.split('/');
        print('path: ${path}');
      },
    );
  }
}
