import 'package:flutter/services.dart';
import 'package:numbers/screens/GameScreen/GameScreen.dart';
import 'package:numbers/screens/TurorialScreen.dart';
import 'package:numbers/screens/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:numbers/screens/SplashScreen.dart';
import 'package:numbers/screens/HomeScreen/HomeScreen.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> main() async {
    FirebaseAnalytics analytics = FirebaseAnalytics();

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
      '/tutorial': (BuildContext context) => TurorialScreen(),
    },
    navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
  ));
}
