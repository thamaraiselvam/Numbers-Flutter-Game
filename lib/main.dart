import 'dart:async';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numbers/screens/GameScreen/GameScreen.dart';
import 'package:numbers/screens/TurorialScreen.dart';
import 'package:numbers/screens/LoadingScreen.dart';
import 'package:numbers/screens/SplashScreen.dart';
import 'package:numbers/screens/HomeScreen/HomeScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:numbers/utils/Config.dart';

Future<void> main() async {

  FirebaseAnalytics analytics = FirebaseAnalytics();

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runZoned<Future<Null>>(() async {
    runApp(new MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
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
  }, onError: (error, stackTrace) async {
    // Whenever an error occurs, call the `reportCrash` function. This will send
    // Dart errors to our dev console or Crashlytics depending on the environment.
    await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: false);
  });
}
