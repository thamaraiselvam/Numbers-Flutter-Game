// import 'package:add_numbers/screens/GameScreen.dart';
import 'package:add_numbers/screens/LoadingScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
       home: new LoadingScreen(),
    );
  }
}
