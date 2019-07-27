import 'package:flutter/services.dart';
import 'package:numbers/screens/GameScreen.dart';
import 'package:numbers/screens/HowToScreen.dart';
import 'package:numbers/screens/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:numbers/screens/SplashScreen.dart';
import 'package:numbers/screens/homeScreen.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  runApp(
    new MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => SplashScreen(),
        '/home': (BuildContext context) => HomeScreen(),
        '/loading': (BuildContext context) => LoadingScreen(),
        '/game': (BuildContext context) => GameScreen(),
        '/howTo': (BuildContext context) => HowToScreen(),
      },
    ));
}
