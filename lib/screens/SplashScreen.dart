import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  primaryColor,
                  secondaryColor
                ])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Numbers',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontFamily: 'Open Sans',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
