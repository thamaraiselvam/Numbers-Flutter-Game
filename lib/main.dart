import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numbers/screens/GameScreen/GameScreen.dart';
import 'package:numbers/screens/TurorialScreen.dart';
import 'package:numbers/screens/LoadingScreen.dart';
import 'package:numbers/screens/SplashScreen.dart';
import 'package:numbers/screens/HomeScreen/HomeScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


void main() {
  SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      // navigatorObservers: <NavigatorObserver>[observer],
    );
  }
}
