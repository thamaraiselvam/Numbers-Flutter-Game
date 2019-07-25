// import 'package:add_numbers/screens/GameScreen.dart';
import 'package:add_numbers/screens/GameScreen.dart';
import 'package:add_numbers/screens/LoadingScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (BuildContext context) => LoadingScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/game': (BuildContext context) => GameScreen(),
      },
    ));
