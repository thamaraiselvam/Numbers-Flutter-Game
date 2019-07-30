import 'dart:async';
import 'dart:math';
import 'package:numbers/utils/Common.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  Color _color = Colors.green;
  int _startCounter = 3;
  Timer _timer;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    this.runCounter();
  }

  void runCounter() {
    _timer = Timer.periodic(Duration(seconds: 1), loadTimer);
  }

  loadTimer(Timer timer) {
    setState(() {
      this.loadGameWhenReady(timer);
      this.continueLoader();
    });
  }

  void continueLoader() {
    _color = Common.getRandomColor();
    _startCounter--;
  }

  void loadGameWhenReady(Timer timer) {
    if (_startCounter > 1) {
      return;
    }

    timer.cancel();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/game', (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment(0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _startCounter.toString(),
                  style: TextStyle(
                      fontSize: 50, color: _color, fontWeight: FontWeight.w600),
                ),
                Text(
                  'GET READY',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
