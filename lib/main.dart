import 'package:app_one/routes/profile/profile_home.dart';
import 'package:app_one/routes/routers/routers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'AppOne',
      initialRoute: '/',
      onGenerateRoute: Routers.generateRoute,
      color: Colors.black,
    );
  }
}
